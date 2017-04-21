//
//  NSString+FAJson.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/3/6.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "NSString+FAJson.h"

@implementation NSString (FAJson)

/**
 *  字典转 json字符串
 *
 *  @return json字符串
 */
+(NSString *)dictionaryToJsonString:(NSDictionary *)dictionary
{
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error) {
        return nil;
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


@end
