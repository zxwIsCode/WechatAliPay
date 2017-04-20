//
//  THTipsView.m
//  SmallGowildClient
//
//  Created by Teehom on 16/4/8.
//  Copyright © 2016年 Teehom. All rights reserved.
//

#import "THTipsView.h"
#import "AppDelegate.h"

@implementation THTipsView


+ (void)showTips:(NSString *)message orginY:(CGFloat)aOrginY
{
    float scale = CurrentScreenScale();
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGSize size = CGSizeMake(SCREEN_WIDTH, 41*scale);
    CGSize retSize = [THTipsView boundingRectWithSize:size message:message];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - retSize.width - 40*(scale))/2.0f, aOrginY, retSize.width + 40*scale, 40.0f*scale)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = message;
    label.layer.cornerRadius = 6.0f;
    label.layer.borderColor = RGBACOLOR(0, 0, 0, 0.9).CGColor;
    label.layer.masksToBounds = YES;
//    label.font = [UIFont systemFontOfSize:15.0f];
    [label setNewLigntFontWithSize:15.0f];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = RGBACOLOR(0, 0, 0, 0.9);
    [window addSubview:label];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });
}


+ (CGSize)boundingRectWithSize:(CGSize)size message:(NSString *)msg
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
    
    CGSize retSize = [msg  boundingRectWithSize:size
                                             options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}


@end
