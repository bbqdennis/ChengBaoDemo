//
//  ViewController.h
//  ChengBaoDemo
//
//  Created by ChengDennis on 23/8/2019.
//  Copyright © 2019 ChengDennis. All rights reserved.
//

#import <UIKit/UIKit.h>

// Constants
static NSInteger const kHTTPErrorNotFoundCode = 404;

// API
static NSString * const kAPIOne = @"https://www.dropbox.com/s/fte5xia72qvrnuy/fake_api_one.json?dl=1";
static NSString * const kAPITwo = @"https://www.dropbox.com/s/7oyuoqtn4ve7hyh/fake_api_two.json?dl=1";
static NSString * const kAPIThree = @"https://www.dropbox.com/s/n8e9hpjdtwfke1t/fake_api_three.json?dl=1";
static NSString * const kAPI404 = @"https://www.dropbox.com/404";

typedef void (^GLRequestSuccessBlock)(NSDictionary *dict);
typedef void (^GLRequestFailureBlock)(NSError *error, NSUInteger httpStatusErrorCode);

@interface ViewController : UIViewController


-(NSURLSessionDataTask *)customCallAPIWithPath:(NSString *)postPath
                                withParameters:(id)parameters
                                withHTTPMethod:(NSString *)httpMethod
                                       success:(GLRequestSuccessBlock)success
                                       failure:(GLRequestFailureBlock)failure;

@end

