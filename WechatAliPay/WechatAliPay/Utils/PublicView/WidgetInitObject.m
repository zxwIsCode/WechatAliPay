//
//  WidgetInitObject.m
//  SmallGowildClient
//
//  Created by Teehom on 16/3/28.
//  Copyright © 2016年 Teehom. All rights reserved.
//

#import "WidgetInitObject.h"

@implementation WidgetInitObject




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
                            fontSize:(float)size
{
    UITextField *textField = [[UITextField alloc]initWithFrame:rect];
    textField.placeholder = placeholder;
    [textField  setNewLigntFontWithSize:size];
    if (aColor) {
        [textField setTextColor:aColor];
    }
    return textField;
}


/**
 *  初始化Label
 *
 *  @param rect   位置
 *  @param aColor 字体颜色
 *  @param font   字体
 *
 *  @return UILabel *
 */
+ (UILabel *)labelWidgetInit:(CGRect)rect
                   textColor:(UIColor *)aColor
                        font:(UIFont *)aFont
{
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    label.textColor = aColor;
    label.font = aFont;
    
    return label;
}

/**
 *  初始化UIImageView
 *
 *  @param rect      位置
 *  @param imageName 图片名称
 *
 *  @return UIImageView *
 */
+ (UIImageView *)imageViewWidgetInit:(CGRect)rect imageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    imageView.image = ImageNamed(imageName);
    return imageView;
}

/**
 *  初始化按钮
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
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (nImageName) {
        [button setBackgroundImage:ImageNamed(nImageName) forState:UIControlStateNormal];
    }
    if (hImageName) {
        [button setBackgroundImage:ImageNamed(hImageName) forState:UIControlStateHighlighted];
    }
    if (atitle) {
        [button setTitle:atitle forState:UIControlStateNormal];
    }
    button.frame = rect;
    return button;
}

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
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (nImage) {
        [button setBackgroundImage:nImage forState:UIControlStateNormal];
    }
    if (hImage) {
        [button setBackgroundImage:hImage forState:UIControlStateHighlighted];
    }
    if (atitle) {
        [button setTitle:atitle forState:UIControlStateNormal];
    }
    button.frame = rect;
    return button;
}

@end
