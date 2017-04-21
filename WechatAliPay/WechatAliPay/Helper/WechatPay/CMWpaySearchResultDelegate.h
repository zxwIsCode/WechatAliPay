//
//  CMWpaySearchResultDelegate.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/12/8.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WAPayKind) {
    WAPayKindWechat =0,      //微信支付
    WAPayKindAliPay =1        //支付宝支付
};

@class WXApi;
@class CMWechatAliPayManager;
@protocol CMWpaySearchResultDelegate <NSObject>

@required
// 微信支付完成后告诉客户端
-(void)Wpay:(CMWechatAliPayManager *)manager andPayKind:(WAPayKind)payKind andPayResult:(int)code;

@optional

@end
