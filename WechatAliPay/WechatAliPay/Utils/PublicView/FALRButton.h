//
//  FALRButton.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/16.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FALRButton : UIButton
// 传过来的image宽度度占button的比例值（取值范围0 --1）
@property(nonatomic,assign)float imagRatio;
+(instancetype )leftRightButton;
@end
