//
//  ChengBaoDemoTests.m
//  ChengBaoDemoTests
//
//  Created by ChengDennis on 23/8/2019.
//  Copyright © 2019 ChengDennis. All rights reserved.
//

#import <XCTest/XCTest.h>

// Controller
#import "ViewController.h"

// Macro
#define API_ARRAY [NSArray arrayWithObjects:kAPIOne, kAPITwo, kAPIThree, kAPI404, nil]

@interface ChengBaoDemoTests : XCTestCase
{
    ViewController *myViewController;
}

@end

@implementation ChengBaoDemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    myViewController = [ViewController new];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    for (NSString *api in API_ARRAY) {
        
        [myViewController customCallAPIWithPath:api
                                 withParameters:nil
                                 withHTTPMethod:@"GET"
                                        success:^(NSDictionary *dict) {
                                            NSLog(@"%@ API should be fine!", api);
                                        }
                                        failure:^(NSError *error, NSUInteger httpStatusErrorCode) {
                                            
                                            XCTAssert(httpStatusErrorCode != kHTTPErrorNotFoundCode, @"httpStatusErrorCode ERROR 404 FOUND!!");
                                        }];
    }
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
