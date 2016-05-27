//
//  AgeSpecification.m
//  TDSpecification
//
//  Created by Todd Ditchendorf on 5/26/16.
//  Copyright © 2016 Celestial Teapot. All rights reserved.
//

#import "AgeSpecification.h"

static NSMutableDictionary *sCache = nil;

@implementation AgeSpecification {
    NSInteger _age;
}

+ (void)initialize {
    if ([AgeSpecification class] == self) {
        sCache = [[NSMutableDictionary alloc] init];
    }
}


+ (instancetype)specificationWithAge:(NSInteger)age {
    NSAssert(sCache, @"");
    AgeSpecification *spec = sCache[@(age)];
    if (!spec) {
        spec = [[[AgeSpecification alloc] initWithAge:age] autorelease];
        sCache[@(age)] = spec;
    }
    return spec;
}


- (instancetype)init {
    NSAssert(0, @"Use factory methods like +[AgeSpecification specificationWithAge] instead.");
    return nil;
}


- (instancetype)initWithAge:(NSInteger)age {
    self = [super init];
    if (self) {
        _age = age;
    }
    return self;
}


- (BOOL)isEqual:(id)obj {
    BOOL res = self == obj;
    NSAssert((res && self == obj && _age == ((AgeSpecification *)obj)->_age) || (!res && self != obj), @"");
    return res;
}

@end
