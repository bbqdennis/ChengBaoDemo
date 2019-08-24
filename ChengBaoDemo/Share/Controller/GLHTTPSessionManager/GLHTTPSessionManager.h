//
//  GLHTTPSessionManager.h
//  GirlDaily
//
//  Created by Dennis on 4/9/2018.
//  Copyright © 2018 Dennis. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface GLHTTPSessionManager : AFHTTPSessionManager

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;


@end
