//
//  CMHTTPSessionManager.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

//网络方面这样搭建的好处：
//1.不 care 错误的东西处理
//2.不 care每个请求都要么再写一个Post方法。要么无法控制请求
//3.未来如果需要对请求的先后顺序以及发出去请求的任务进行 cancle的时候，也可以实现

#import "CMHTTPSessionManager.h"
#import "AFHTTPSessionManager.h"

static CMHTTPSessionManager *_httpInstance = nil;


@implementation CMHTTPSessionManager

+ (instancetype)sharedHttpSessionManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _httpInstance = [[CMHTTPSessionManager alloc] init];
    });
    
    return _httpInstance;
}
-(instancetype)init {
    if (self = [super init]) {
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        // 防止返回Null的问题
        response.removesKeysWithNullValues = YES;
    }
    return self;
}

// 请求正常的Http
-(void)sendHttpRequestParam:(CMHttpRequestModel *)model {
  
    NSURLSessionDataTask *task = nil;
    NSString *urlStr;
    urlStr =[NSString stringWithFormat:@"%@%@",model.localHost,model.appendUrl];

    if (model.type ==CMHttpType_POST) {// POST 请求
        
        task = [self POST:urlStr
               parameters:model.paramDic
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task,
                            id  _Nonnull responseObject) {
                      [model requestFinishedCallback:responseObject];
                  }
                  failure:^(NSURLSessionDataTask * _Nonnull task,
                            NSError * _Nonnull error) {
                      [model requestErrorCallback:error];
                  }];
    }else { // GET 请求
        task = [self GET:urlStr
              parameters:model.paramDic
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task,
                           id  _Nonnull responseObject) {
                    [model requestFinishedCallback:responseObject];
                 } failure:^(NSURLSessionDataTask * _Nonnull task,
                             NSError * _Nonnull error) {
                     [model requestErrorCallback:error];
                 }];
    }
}

@end
