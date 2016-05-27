//
//  Person.m
//  TDSpecification
//
//  Created by Todd Ditchendorf on 5/27/16.
//  Copyright © 2016 Celestial Teapot. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (instancetype)personWithGender:(PersonGender)gender age:(NSInteger)age {
    return [[[Person alloc] initWithGender:gender age:age] autorelease];
}


- (instancetype)initWithGender:(PersonGender)gender age:(NSInteger)age {
    self = [super init];
    if (self) {
        self.gender = gender;
        self.age = age;
    }
    return self;
}

@end
