//
//  GenderSpecification.m
//  TDSpecification
//
//  Created by Todd Ditchendorf on 5/26/16.
//  Copyright © 2016 Celestial Teapot. All rights reserved.
//

#import "GenderSpecification.h"

@implementation GenderSpecification {
    NSInteger _flag;
}

+ (instancetype)female {
    return [[[GenderSpecification alloc] initWithFlag:0] autorelease];
}


+ (instancetype)male {
    return [[[GenderSpecification alloc] initWithFlag:1] autorelease];
}


- (instancetype)init {
    NSAssert(0, @"Use factory methods like +[GenderSpecification female] instead.");
    return nil;
}


- (instancetype)initWithFlag:(NSInteger)flag {
    self = [super init];
    if (self) {
        _flag = flag;
    }
    return self;
}


- (BOOL)isEqual:(id)obj {
    BOOL res = self == obj;
    NSAssert((res && self == obj && _flag == ((GenderSpecification *)obj)->_flag) || (!res && self != obj), @"");
    return res;
}

@end
