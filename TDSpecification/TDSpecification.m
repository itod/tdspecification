//
//  TDSpecification.m
//  TDSpecification
//
//  Created by Todd Ditchendorf on 5/26/16.
//  Copyright © 2016 Celestial Teapot. All rights reserved.
//

#import "TDSpecification.h"

@interface TDSpecification () {
@protected
    NSArray *_leafSpecifications;
}
@property (nonatomic, retain) NSArray *leafSpecifications;
@end

@interface TDCompositeSpecification : TDSpecification {
    TDSpecification *_lhs;
    TDSpecification *_rhs;
}

- (instancetype)initWithLhs:(TDSpecification *)lhs rhs:(TDSpecification *)rhs;

@property (nonatomic, retain) TDSpecification *lhs;
@property (nonatomic, retain) TDSpecification *rhs;
@end

@implementation TDCompositeSpecification

- (instancetype)init {
    NSAssert(0, @"call -[TDCompositeSpecification initWithLhs:rhs:] instead");
    return nil;
}


- (instancetype)initWithLhs:(TDSpecification *)lhs rhs:(TDSpecification *)rhs {
    NSAssert(lhs, @"");
    self = [super init];
    if (self) {
        self.lhs = lhs;
        self.rhs = rhs;
    }
    return self;
}


- (void)dealloc {
    self.lhs = nil;
    self.rhs = nil;
    [super dealloc];
}


- (NSArray *)leafSpecifications {
    if (!_leafSpecifications) {
        NSAssert(_lhs, @"");
        NSMutableArray *v = [NSMutableArray arrayWithArray:[_lhs leafSpecifications]];
        [v addObjectsFromArray:[_rhs leafSpecifications]];
        self.leafSpecifications = [[v copy] autorelease];
    }
    return _leafSpecifications;
}

@end

@interface TDAndSpecification : TDCompositeSpecification

@end

@implementation TDAndSpecification

- (BOOL)isSatisfiedBy:(id)obj {
    NSAssert(_lhs, @"");
    NSAssert(_rhs, @"");
    return [_lhs isSatisfiedBy:obj] && [_rhs isSatisfiedBy:obj];
}

@end

@interface TDOrSpecification : TDCompositeSpecification

@end

@implementation TDOrSpecification

- (BOOL)isSatisfiedBy:(id)obj {
    NSAssert(_lhs, @"");
    NSAssert(_rhs, @"");
    return [_lhs isSatisfiedBy:obj] || [_rhs isSatisfiedBy:obj];
}

@end

@interface TDNotSpecification : TDCompositeSpecification

@end

@implementation TDNotSpecification

- (BOOL)isSatisfiedBy:(id)obj {
    NSAssert(_lhs, @"");
    NSAssert(!_rhs, @"");
    return ![_lhs isSatisfiedBy:obj];
}

@end

@interface TDTrueSpecification : TDSpecification

@end

@implementation TDTrueSpecification

- (BOOL)isSatisfiedBy:(id)obj { return YES; }

@end

@interface TDFalseSpecification : TDSpecification

@end

@implementation TDFalseSpecification

- (BOOL)isSatisfiedBy:(id)obj { return NO; }

@end

static TDSpecification *sTrueSpec = nil;
static TDSpecification *sFalseSpec = nil;

@implementation TDSpecification

+ (void)initialize {
    if ([TDSpecification class] == self) {
        sTrueSpec = [[TDTrueSpecification alloc] init];
        sFalseSpec = [[TDFalseSpecification alloc] init];
    }
}

+ (instancetype)booleanTrue { return sTrueSpec; }
+ (instancetype)booleanFalse { return sFalseSpec; }
+ (instancetype)boolean:(BOOL)yn { return yn ? sTrueSpec : sFalseSpec; }

- (void)dealloc {
    self.leafSpecifications = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark Private

- (NSArray *)leafSpecifications {
    if (!_leafSpecifications) {
        self.leafSpecifications = @[self];
    }
    return _leafSpecifications;
}


#pragma mark -
#pragma mark Public

- (TDSpecification *)and:(TDSpecification *)rhs {
    return [[[TDAndSpecification alloc] initWithLhs:self rhs:rhs] autorelease];
}


- (TDSpecification *)or:(TDSpecification *)rhs {
    return [[[TDOrSpecification alloc] initWithLhs:self rhs:rhs] autorelease];
}


- (TDSpecification *)not {
    return [[[TDNotSpecification alloc] initWithLhs:self rhs:nil] autorelease];
}


- (BOOL)isSatisfiedBy:(id)obj {
    NSAssert2(0, @"%s is an abstract method and must be implemented in %@", __PRETTY_FUNCTION__, [self class]);
    return NO;
}


// This impl only sufficient if you ONLY USE AND Specs and DON'T use OR or NOT Specs.
- (BOOL)subsumes:(TDSpecification *)otherParent {
    if ([otherParent isKindOfClass:[TDCompositeSpecification class]]) {
        for (TDSpecification *otherChild in otherParent.leafSpecifications) {
            if (![self.leafSpecifications containsObject:otherChild]) {
                return NO;
            }
        }
    } else {
        if (![self.leafSpecifications containsObject:otherParent]) {
            return NO;
        }
    }
    return YES;
}

@end
