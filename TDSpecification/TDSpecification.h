//
//  TDSpecification.h
//  TDSpecification
//
//  Created by Todd Ditchendorf on 5/26/16.
//  Copyright © 2016 Celestial Teapot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDSpecification : NSObject

- (TDSpecification *)and:(TDSpecification *)rhs;
- (TDSpecification *)or:(TDSpecification *)rhs;
- (TDSpecification *)not;

- (BOOL)isSatisfiedBy:(id)obj;
- (BOOL)subsumes:(TDSpecification *)spec;
@end
