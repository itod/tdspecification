//
//  Person.h
//  TDSpecification
//
//  Created by Todd Ditchendorf on 5/27/16.
//  Copyright © 2016 Celestial Teapot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PersonGender) {
    PersonGenderFemale,
    PersonGenderMale,
};

@interface Person : NSObject
+ (instancetype)personWithGender:(PersonGender)gender age:(NSInteger)age;
- (instancetype)initWithGender:(PersonGender)gender age:(NSInteger)age;

@property (nonatomic, assign) PersonGender gender;
@property (nonatomic, assign) NSInteger age;
@end
