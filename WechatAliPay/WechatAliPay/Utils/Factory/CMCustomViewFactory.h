//
//  CMCustomViewFactory.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//  生产自定义View的工厂

#import <Foundation/Foundation.h>

@interface CMCustomViewFactory : NSObject

// 快速生产出button
+ (UIButton*)createButton:(CGRect)frame title:(NSString*)title backgourdImage:(UIImage*)backgroundImage;
+ (UIButton*)createButton:(CGRect)frame title:(NSString*)title normalImage:(UIImage*)normalImage selectImage:(UIImage *)selectImage;
// 快速生产出lable
+ (UILabel*)createLabel:(CGRect)frame title:(NSString*)title color:(UIColor*)color font:(UIFont*)font textAlignment:(NSTextAlignment)alignment;
+ (CGSize)autoSizeFrame:(CGSize)sizeFrame withFont:(UIFont*)font withText:(NSString *)text;
@end
