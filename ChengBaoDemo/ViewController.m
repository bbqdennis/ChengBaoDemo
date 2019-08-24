//
//  ViewController.m
//  ChengBaoDemo
//
//  Created by ChengDennis on 23/8/2019.
//  Copyright © 2019 ChengDennis. All rights reserved.
//

#import "ViewController.h"

// Controllers
#import "AFNetworking.h"
#import "GLHTTPSessionManager.h"

@interface ViewController ()
{
}

@end

@implementation ViewController

#pragma mark - Helper

-(GLHTTPSessionManager *)getRenewedManager
{
    GLHTTPSessionManager *manager = [GLHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //ps. we add @"application/binary" for DropBox API call
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"application/binary", nil];
    return manager;
}

-(NSInteger)getHTTPStatusCodeWithError:(NSError *)error
{
    NSHTTPURLResponse *aNSHTTPURLResponse = [[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey];
    NSLog(@"getHTTPStatusCodeWithError httpStatusCode %ld", (long)aNSHTTPURLResponse.statusCode);
    return aNSHTTPURLResponse.statusCode;
}

-(NSInteger)handleNetworkError:(NSError *)error
{
    NSLog(@"handleNetworkError %@ error.code %ld userInfo %@", error, (long)error.code, error.userInfo);
    NSUInteger httpStatusErrorCode = [self getHTTPStatusCodeWithError:error];
    NSLog(@"getHTTPStatusCodeWithError %ld", (long)[self getHTTPStatusCodeWithError:error]);
    
    if (httpStatusErrorCode == kHTTPErrorNotFoundCode) {
        
        NSLog(@"handleNetworkError httpStatusErrorCode %ld error.localizedDescription %@", (long)httpStatusErrorCode, error.localizedDescription);
        
        // For 404 not found, do something
    }
    return httpStatusErrorCode;
}


#pragma mark - Common

-(void)handleCallAPIWithPath:(NSString *)postPath
              withParameters:(id)parameters
          withResponseObject:(id)responseObject
                     success:(GLRequestSuccessBlock)success
                     failure:(GLRequestFailureBlock)failure
{
    NSLog(@"handleCallAPIWithPath %@ responseObject %@", postPath, responseObject);

    if (success) {
        
        success(responseObject);
    }
}


#pragma mark - API Call

-(NSURLSessionDataTask *)customCallAPIWithPath:(NSString *)postPath
                                withParameters:(id)parameters
                                withHTTPMethod:(NSString *)httpMethod
                                       success:(GLRequestSuccessBlock)success
                                       failure:(GLRequestFailureBlock)failure
{
    NSLog(@"customCallAPIWithPath %@ parameters %@", postPath, parameters);
    NSMutableDictionary *postParameters = parameters;
    NSURLSessionDataTask *aNSURLSessionDataTask = [[self getRenewedManager] dataTaskWithHTTPMethod:httpMethod
                                                                         URLString:postPath
                                                                        parameters:postParameters
                                                                    uploadProgress:nil
                                                                  downloadProgress:nil
                                                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                               
                                                                               NSLog(@"customCallAPIWithPath %@ responseObject %@", postPath, responseObject);
                                                                               [self handleCallAPIWithPath:postPath withParameters:parameters withResponseObject:responseObject success:success failure:failure];
                                                                     
                                                                           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                               
                                                                               NSLog(@"customCallAPIWithPath %@ FAIL error %@", postPath, error.localizedDescription);
                                                                               NSUInteger httpStatusErrorCode = [self handleNetworkError:error];
                                                                               failure(error, httpStatusErrorCode);
                                                                           }];
    [aNSURLSessionDataTask resume];
    return aNSURLSessionDataTask;
}


#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self customCallAPIWithPath:kAPI404 withParameters:nil withHTTPMethod:@"GET" success:^(NSDictionary *dict) {
        
        NSLog(@"customCallAPIWithPath dict %@", dict);
        
    } failure:^(NSError *error, NSUInteger httpStatusErrorCode) {
        
        NSLog(@"customCallAPIWithPath error %@ httpStatusErrorCode %ld", error.localizedDescription, (long)httpStatusErrorCode);
    }];
}


@end
