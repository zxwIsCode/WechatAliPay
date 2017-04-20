//
//  FALRButton.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/16.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FALRButton.h"

@implementation FALRButton

// 传过来的image宽度度占button的比例值（取值范围0 --1）
+(instancetype )leftRightButton; {
    return [[self alloc]init];
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:12 *kAppScale];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.titleLabel.backgroundColor =[UIColor darkGrayColor];
//        self.imageView.backgroundColor =[UIColor brownColor];
        
    }
    return self;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageH =contentRect.size.height;
    if (!_imagRatio) {
        _imagRatio =0.8;
    }
    CGFloat imageW =contentRect.size.width *_imagRatio;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    if (!_imagRatio) {
        _imagRatio =0.2;
    }
    CGFloat titleX = contentRect.size.width *_imagRatio;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleW = contentRect.size.width -titleX;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
-(void)setImagRatio:(float)imagRatio {
    _imagRatio =imagRatio;
}
-(void)layoutSubviews {
    
    [super layoutSubviews];
}

@end
