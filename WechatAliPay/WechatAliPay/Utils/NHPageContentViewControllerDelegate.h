//
//  GWPageContentViewController.h
//  GowildXB
//
//  Created by Charse on 16/7/23.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NHPageContentViewControllerDelegate <NSObject>

@optional
@property (nonatomic, copy) void (^viewDidLoadCallback)(void);
@property (nonatomic, copy) void (^viewWillAppearCallback)(void);
@property (nonatomic, copy) void (^viewWillDisapearCallback)(void);

@end
