//
//  UIImage+Size.h
//  SmallGowildClient
//
//  Created by Teehom on 16/4/9.
//  Copyright © 2016年 Teehom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Size)

- (UIImage *) scaleToSize: (CGSize)size;


- (UIImage*)transformWidth:(CGFloat)width
                    height:(CGFloat)height;

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

+ (UIImage *)resizedImageWithName:(NSString *)name;

//等比例缩放UIImage
+ (UIImage*)scaleImage:(UIImage*)img toSize:(CGSize)size;
@end
