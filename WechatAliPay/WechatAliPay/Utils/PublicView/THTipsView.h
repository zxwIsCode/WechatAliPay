//
//  THTipsView.h
//  SmallGowildClient
//
//  Created by Teehom on 16/4/8.
//  Copyright © 2016年 Teehom. All rights reserved.
//  背景黑色，带白色提示语的view

#import <UIKit/UIKit.h>

@interface THTipsView : UIView

+ (void)showTips:(NSString *)message orginY:(CGFloat)aOrginY;

@end
