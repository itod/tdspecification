//
//  GenderSpecification.m
//  TDSpecification
//
//  Created by Todd Ditchendorf on 5/26/16.
//  Copyright © 2016 Celestial Teapot. All rights reserved.
//

#import "GenderSpecification.h"
#import "Person.h"

@implementation GenderSpecification {
    NSInteger _gender;
}

+ (instancetype)female {
    return [[[GenderSpecification alloc] initWithGender:PersonGenderFemale] autorelease];
}


+ (instancetype)male {
    return [[[GenderSpecification alloc] initWithGender:PersonGenderMale] autorelease];
}


- (instancetype)init {
    NSAssert(0, @"Use factory methods like +[GenderSpecification female] instead.");
    return nil;
}


- (instancetype)initWithGender:(NSInteger)gender {
    self = [super init];
    if (self) {
        _gender = gender;
    }
    return self;
}


- (BOOL)isEqual:(id)obj {
    BOOL res = self == obj;
    NSAssert((res && self == obj && _gender == ((GenderSpecification *)obj)->_gender) || (!res && self != obj), @"");
    return res;
}


- (BOOL)isSatisfiedBy:(id)obj {
    BOOL result = NO;
    
    if ([obj isKindOfClass:[Person class]]) {
        Person *p = (id)obj;
        result = p.gender == _gender;
    }
    
    return result;
}

@end
