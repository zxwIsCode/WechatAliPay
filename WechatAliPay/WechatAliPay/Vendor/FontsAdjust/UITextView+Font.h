//
//  UITextView+Font.h
//  SmallGowildClient
//
//  Created by Teehom on 16/5/2.
//  Copyright © 2016年 Teehom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Font)

/**
 *  设置为 SourceHanSansCN-Light
 *
 *  @param fontsize 字体大小
 */
- (void)setNewLigntFontWithSize:(float)fontsize;


/**
 *  设置为 SourceHanSansCN-Normal
 *
 *  @param fontsize 字体大小
 */
- (void)setNewNormalFontWithSize:(float)fontsize;

/**
 *  设置为 SourceHanSansCN-Bold
 *
 *  @param fontsize 字体大小
 */
- (void)setNewBlodFontWithSize:(float)fontsize;



@end
