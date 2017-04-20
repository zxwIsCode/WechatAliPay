//
//  UIImage+ChangeColor.m
//  SmallGowildClient
//
//  Created by Teehom on 16/3/25.
//  Copyright © 2016年 Teehom. All rights reserved.
//

#import "UIImage+Color.h"


@implementation UIImage (Color)

//改变图片颜色
- (UIImage *)imageWithColor:(UIColor *)color
{

    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end