//
//  THButton.m
//  TeehomLibs
//
//  Created by Teehom on 10/15/15.
//  Copyright © 2015 Teehom. All rights reserved.
//

#import "THButton.h"
#import "UIView+Frame.h"

@implementation THButton


/**
 *  layoutSubviews在以下情况下会被调用：
     1、init初始化不会触发layoutSubviews
     2、addSubview会触发layoutSubviews
     3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
     4、滚动一个UIScrollView会触发layoutSubviews
     5、旋转Screen会触发父UIView上的layoutSubviews事件
     6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 *
 */

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5f;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font =[UIFont systemFontOfSize:14];

}

@end
