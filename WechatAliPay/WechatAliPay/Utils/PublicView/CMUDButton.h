//
//  CMUDButton.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/22.
//  Copyright © 2016年 DaviD. All rights reserved.
//  上面图片下面文字的button

#import <UIKIt/UIKIt.h>

@interface CMUDButton : UIButton
// 传过来的image高度占button的比例值（取值范围0 --1）
@property(nonatomic,assign)float imagRatio;
+(instancetype )upDownButton;

@end
