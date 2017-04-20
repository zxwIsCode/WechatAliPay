//
//  UILabel+Font.m
//  SmallGowildClient
//
//  Created by Teehom on 16/5/2.
//  Copyright © 2016年 Teehom. All rights reserved.
//

#import "UILabel+Font.h"
#import <objc/runtime.h>

#import <objc/message.h>

@implementation UILabel (Font)




/**
 *  设置为 SourceHanSansCN-Light
 *
 *  @param fontsize 字体大小
 */
- (void)setNewLigntFontWithSize:(float)fontsize
{
    UIFont *font = [UIFont fontWithName:@"SourceHanSansCN-Light" size:fontsize];
    [self setFont:font];
}


/**
 *  设置为 SourceHanSansCN-Normal
 *
 *  @param fontsize 字体大小
 */
- (void)setNewNormalFontWithSize:(float)fontsize
{
    UIFont *font = [UIFont fontWithName:@"SourceHanSansCN-Normal" size:fontsize];
    [self setFont:font];
}

/**
 *  设置为 SourceHanSansCN-Bold
 *
 *  @param fontsize 字体大小
 */
- (void)setNewBlodFontWithSize:(float)fontsize
{
    UIFont *font = [UIFont fontWithName:@"SourceHanSansCN-Bold_0" size:fontsize];
    [self setFont:font];
}


/**
 *  设置为 Helvetica
 *
 *  @param fontsize 字体大小
 */
- (void)setNewHelveticaFontWithSize:(float)fontsize
{
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:fontsize];
    [self setFont:font];
}



@end
