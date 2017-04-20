//
//  GWTextField.m
//  GowildXB
//
//  Created by Charse on 16/7/29.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWTextField.h"

@implementation GWTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - overload methods
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.contentOffset.x, self.contentOffset.y);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.contentOffset.x, self.contentOffset.y);
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.contentOffset.x, self.contentOffset.y);
}
//
//
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    
    CGRect textRect = [super leftViewRectForBounds:bounds];
    textRect.origin.x += (bounds.size.height/4);
    return textRect;
}
//
//- (CGRect)rightViewRectForBounds:(CGRect)bounds {
//    
//    CGRect textRect = [super rightViewRectForBounds:bounds];
//    textRect.origin.x -= 10;
//    return textRect;
//}

@end
