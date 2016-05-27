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

- (void)testSubsumes_Combat {
    TDSpecification *male = [GenderSpecification male];
    TDSpecification *eighteen = [AgeSpecification specificationWithAge:18];
    TDSpecification *combat = [male and:eighteen];
    
    XCTAssert([combat subsumes:male]);
    XCTAssert([combat subsumes:eighteen]);
    XCTAssert(![male subsumes:combat]);
    XCTAssert(![eighteen subsumes:combat]);
    XCTAssert(![male subsumes:eighteen]);
    XCTAssert(![eighteen subsumes:male]);
}

@end
