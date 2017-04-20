//
//  CMBaseViewController.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//  所有的父类

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CMNavType) {
    CMNavTypeAll =0,      //左中右item都有
    CMNavTypeNoRightItem ,//右item没有
    CMNavTypeOnlyTitle ,  //只有中间item有
    CMNavTypeNone,        //没有navbar
    CMNavTypeNoLeftItem// 左item没有
};
@interface CMBaseViewController : UIViewController
{
    NSNotificationCenter *defaultCenter;
}

//@property(nonatomic,assign)CMNavType navType;

-(CMNavType)getNavType;

//定制导航栏上的titleView
- (void)customNavigationTitleView;

//定制导航栏左边的按钮
- (void)customNavigationLeftItem;

//定制导航栏右边的按钮
- (void)customNavigationRighItem;


// 子类优先重写以下的方法
-(NSString *)customNavigationRightItemTitle;
// 如果只有标题和左返回键的话，不需要重写这个方法，只需要在ViewDidlod中写下如下：
/*
 - (void)viewDidLoad {
 self.title =@"提现规则";
 [super viewDidLoad];
 // Do any additional setup after loading the view.
 }
 */
//self.title =@"提现规则";必须在 [super viewDidLoad];方法之前，因为先设置值，再写父类的方法
-(NSString *)customNavigationTitleViewTitleStr;

- (void)navigationLeftButtonClick:(id)sender;
- (void)navigationRightButtonClick:(id)sender;
@end
