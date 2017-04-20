//
//  WidgetInitObject.h
//  SmallGowildClient
//
//  Created by Teehom on 16/3/28.
//  Copyright © 2016年 Teehom. All rights reserved.
//  方便控件初始化控件

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WidgetInitObject : NSObject

/**
 *  初始化textField
 *
 *  @param placeholder 默认显示
 *  @param rect        位置
 *  @param aColor      颜色
 *  @param size        字体大小
 *
 *  @return UITextField *
 */
+ (UITextField *)textFieldWidgetInit:(NSString *)placeholder
                               frame:(CGRect)rect
                            textClor:(UIColor *)aColor
                            fontSize:(float)size;

/**
 *  初始化Label
 *
 *  @param rect   位置
 *  @param aColor 字体颜色
 *
 *  @return UILabel *
 */
+ (UILabel *)labelWidgetInit:(CGRect)rect
              textColor:(UIColor *)aColor
                    font:(UIFont *)aFont;

/**
 *  初始化UIImageView
 *
 *  @param rect      位置
 *  @param imageName 图片名称
 *
 *  @return UIImageView *
 */
+ (UIImageView *)imageViewWidgetInit:(CGRect)rect imageName:(NSString *)imageName;

/**
 *  初始化按钮(背景图片使用资源图片)
 *
 *  @param rect       位置
 *  @param nImageName 默认图片
 *  @param hImageName 高亮图片
 *
 *  @return UIButton *
 */
+ (UIButton *)buttonWidgetInit:(CGRect)rect
               normalImageName:(NSString *)nImageName
              hightedImageName:(NSString *)hImageName
                         title:(NSString *)atitle;


/**
 *  初始化按钮(背景图片，经过处理的资源图片)
 *
 *  @param rect       位置
 *  @param nImage 默认图片
 *  @param hImage 高亮图片
 *
 *  @return UIButton *
 */
+ (UIButton *)buttonWidgetInit:(CGRect)rect
               normalImage:(UIImage *)nImage
              hightedImage:(UIImage *)hImage
                     title:(NSString *)atitle;




@end
