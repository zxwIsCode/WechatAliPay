//
//  CMHttpStateTools.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/12/21.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMHttpStateTools : NSObject

// 每次网络请求没有数据或者失败的弹框
+(void)showHtttpStateView:(CMReponseCodeState)state;
@end
