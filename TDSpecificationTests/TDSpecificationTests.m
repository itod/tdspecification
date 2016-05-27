//
//  TDSpecificationTests.m
//  TDSpecificationTests
//
//  Created by Todd Ditchendorf on 5/26/16.
//  Copyright © 2016 Celestial Teapot. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TDSpecification.h"
#import "GenderSpecification.h"
#import "AgeSpecification.h"
#import "Person.h"

@interface TDSpecificationTests : XCTestCase

@end

@implementation TDSpecificationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

- (void)testSatisfies_Gender {
    id male = [GenderSpecification male];
    id bob = [Person personWithGender:PersonGenderMale age:40];
    
    XCTAssert([male isSatisfiedBy:bob]);
}

- (void)testNotSatisfies_Gender {
    id female = [GenderSpecification female];
    id bob = [Person personWithGender:PersonGenderMale age:40];
    
    XCTAssert(![female isSatisfiedBy:bob]);
}

- (void)testSatisfies_Age {
    id neg1 = [AgeSpecification specificationWithAge:-1];
    id _0 = [AgeSpecification specificationWithAge:0];
    id _1 = [AgeSpecification specificationWithAge:1];
    id _18 = [AgeSpecification specificationWithAge:18];
    id _39 = [AgeSpecification specificationWithAge:39];
    id _40 = [AgeSpecification specificationWithAge:40];
    id _41 = [AgeSpecification specificationWithAge:41];
    id bob = [Person personWithGender:PersonGenderMale age:40];
    
    XCTAssert([neg1 isSatisfiedBy:bob]); // ??
    XCTAssert([_0 isSatisfiedBy:bob]);
    XCTAssert([_1 isSatisfiedBy:bob]);
    XCTAssert([_18 isSatisfiedBy:bob]);
    XCTAssert([_39 isSatisfiedBy:bob]);
    XCTAssert([_40 isSatisfiedBy:bob]);
    XCTAssert(![_41 isSatisfiedBy:bob]);
}

- (void)testSubsumes_AND {
    id male = [GenderSpecification male];
    id eighteen = [AgeSpecification specificationWithAge:18];
    id combat = [male and:eighteen];
    
    XCTAssert([combat subsumes:male]);
    XCTAssert([combat subsumes:eighteen]);
    XCTAssert(![male subsumes:combat]);
    XCTAssert(![eighteen subsumes:combat]);
    XCTAssert(![male subsumes:eighteen]);
    XCTAssert(![eighteen subsumes:male]);
}

- (void)testSatisfies_AND {
    id male = [GenderSpecification male];
    id eighteen = [AgeSpecification specificationWithAge:18];
    id combat = [male and:eighteen];
    
    id bob = [Person personWithGender:PersonGenderMale age:20];
    
    XCTAssert([combat isSatisfiedBy:bob]);
}

@end
