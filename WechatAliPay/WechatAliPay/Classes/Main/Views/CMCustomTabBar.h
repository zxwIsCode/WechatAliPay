//
//  CMCustomTabBar.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/12/2.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CMCustomTabBar;
@protocol CMCustomTabBarDelegate <NSObject>

-(void)tabBar:(CMCustomTabBar *)tabBar didSelectVC:(NSInteger)lastIndex andNext:(NSInteger)nextIndex;

@end

@interface CMCustomTabBar : UIImageView

@property(nonatomic,weak)id<CMCustomTabBarDelegate> delegate;
-(void)creatAllTabBarSubViews:(UITabBarItem *)item andIndex:(NSInteger)index;
@end
