//
//  CMHttpRequestModel.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMRequestDelegate.h"


typedef NS_ENUM(NSUInteger, CMHttpType) {
    CMHttpType_POST =1,
    CMHttpType_GET,
};

@interface CMHttpRequestModel : NSObject<CMRequestDelegate>

@property(nonatomic,assign)CMHttpType type;// 默认是POST请求

@property(nonatomic,copy)NSString *localHost;// 请求的接口地址默认为 kHttpHost

@property(nonatomic,copy)NSString *appendUrl;//请求的拼接URL

@property(nonatomic,strong)NSMutableDictionary *paramDic;// 请求的参数

@end
