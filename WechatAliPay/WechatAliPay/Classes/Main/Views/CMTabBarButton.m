//
//  CMTabBarButton.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/12/2.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMTabBarButton.h"

@implementation CMTabBarButton

-(void)setItem:(UITabBarItem *)item {
    
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:UIColorFromHexValue(0xffff00) forState:UIControlStateSelected];
    
    self.titleLabel.font =[UIFont systemFontOfSize:15 *kAppScale];
}

-(void)setHighlighted:(BOOL)highlighted {

}
@end
