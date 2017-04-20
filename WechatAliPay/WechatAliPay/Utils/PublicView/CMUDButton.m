//
//  CMUDButton.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/22.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMUDButton.h"

@interface CMUDButton ()


@end

@implementation CMUDButton

// ImageRatio 传过来的image高度占button的比例值（取值范围0 --1）
+(instancetype )upDownButton {
    return [[self alloc]init];
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:12 *kAppScale];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;

    }
    return self;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW =contentRect.size.width;
    if (!_imagRatio) {
        _imagRatio =0.6;
    }
    CGFloat imageH =contentRect.size.height *_imagRatio;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    if (!_imagRatio) {
        _imagRatio =0.6;
    }
    CGFloat titleY = contentRect.size.height *_imagRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height -titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
-(void)setImagRatio:(float)imagRatio {
    _imagRatio =imagRatio;
}
-(void)layoutSubviews {
    
    [super layoutSubviews];
}


@end
