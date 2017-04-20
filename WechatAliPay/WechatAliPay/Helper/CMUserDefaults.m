//
//  CMUserDefaults.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/18.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMUserDefaults.h"

@implementation CMUserDefaults
// String 的本地读取和存储
+(void)saveLocalString:(NSString *)str andKey:(NSString *)key {
    [[self standardUserDefaults] setObject:str forKey:key];
    [[self standardUserDefaults]synchronize];
}
+(NSString *)getFromLocalString:(NSString *)key {
  id obj =  [[self standardUserDefaults] objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return (NSString *)obj;
    }
    return nil;
}

// Bool 的本地读取和存储
+(void)saveLocalBool:(BOOL )is andKey:(NSString *)key {
    [[self standardUserDefaults]setBool:is forKey:key];
    [[self standardUserDefaults]synchronize];
}
+(BOOL )getFromLocalBool:(NSString *)key {
    return [[self standardUserDefaults]boolForKey:key];
}
@end
