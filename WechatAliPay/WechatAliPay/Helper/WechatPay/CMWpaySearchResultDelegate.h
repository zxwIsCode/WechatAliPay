//
//  CMWpaySearchResultDelegate.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/12/8.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApiObject.h"
@class CMWechatPayManager;
@class WXApi;
@protocol CMWpaySearchResultDelegate <NSObject>

@required
// 微信支付完成后告诉客户端
-(void)Wpay:(CMWechatPayManager *)manager andPayResult:(int)code;

@optional

@end
