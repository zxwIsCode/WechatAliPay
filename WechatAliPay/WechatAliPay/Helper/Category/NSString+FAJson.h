//
//  NSString+FAJson.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/3/6.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FAJson)

/**
 *  字典转 json字符串
 *
 *  @return json字符串
 */
+(NSString *)dictionaryToJsonString:(NSDictionary *)dictionary;

@end
