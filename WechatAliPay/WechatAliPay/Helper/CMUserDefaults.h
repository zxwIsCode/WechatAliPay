//
//  CMUserDefaults.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/18.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMUserDefaults : NSUserDefaults
// String 的本地读取和存储
+(void)saveLocalString:(NSString *)str andKey:(NSString *)key;
+(NSString *)getFromLocalString:(NSString *)key;

// Bool 的本地读取和存储
+(void)saveLocalBool:(BOOL )is andKey:(NSString *)key;
+(BOOL )getFromLocalBool:(NSString *)key;

@end
