//
//  CMHTTPSessionManager.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "CMHttpRequestModel.h"




@interface CMHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedHttpSessionManager;
// 请求正常的Http
-(void)sendHttpRequestParam:(CMHttpRequestModel *)model;





@end
