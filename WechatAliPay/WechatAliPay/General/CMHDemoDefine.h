//
//  CMHDemoDefine.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 李保东. All rights reserved.
//


/*************Test测试HTTP**************/

#define kHttpHost @"http://www.nongmut.com/index.php"
#define kTestHttpHost @"http://192.168.3.199/payback/index.php/Mobile"


UIKIT_EXTERN NSString *const kTestQQGetNickNameURL;  //根据QQ号查询昵称
UIKIT_EXTERN NSString *const kTestDonationGetListURL;  //查询爱心捐款列表
UIKIT_EXTERN NSString *const kTestDonationGetPersonURL;  //查询爱心捐款人的列表


#define kTabBarButtonBaseTag 100

UIKIT_EXTERN NSString *const kCart_PayGetPayr; // 支付方式的获取


/*************支付有关的接口**************/
UIKIT_EXTERN NSString *const kPay_topay; //支付下订单的接口
