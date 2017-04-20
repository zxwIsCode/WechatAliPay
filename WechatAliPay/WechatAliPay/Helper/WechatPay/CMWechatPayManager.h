//
//  CMWechatPayManager.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/12/8.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "AFHTTPSessionManager.h"

// 微信支付
#import "WXApi.h"
#import "WXApiObject.h"
#import "CMWpaySearchResultDelegate.h"
@interface CMWechatPayManager : AFHTTPSessionManager<WXApiDelegate>

@property(nonatomic,weak)id<CMWpaySearchResultDelegate>  delegate;
+ (instancetype)sharedWpayManager;

// 请求微信订单参数的Http
-(void)sendWeChatRequestParam:(CMHttpRequestModel *)model;

@end
