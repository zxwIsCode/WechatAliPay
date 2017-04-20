//
//  CMBaseViewController.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMBaseViewController.h"

@interface CMBaseViewController ()

@end

@implementation CMBaseViewController

#pragma mark - Init
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self dependOnKindToViewShow];
    self.view.backgroundColor =[UIColor whiteColor];
}
#pragma mark - Private Methods
-(void)dependOnKindToViewShow {
   CMNavType navType =[self getNavType];
    switch (navType) {
        case CMNavTypeNone:
            DDLog(@"没有navbar");
            self.navigationController.navigationBar.hidden =YES;
            break;
        case CMNavTypeOnlyTitle:
            DDLog(@"只有中间item有");
            self.navigationController.navigationBar.hidden =NO;
            [self customNavigationTitleView];

            break;
        case CMNavTypeNoRightItem:
            DDLog(@"右item没有");
            self.navigationController.navigationBar.hidden =NO;
            [self customNavigationLeftItem];
            [self customNavigationTitleView];

            break;
        case CMNavTypeAll:
            DDLog(@"左中右item都有");
            self.navigationController.navigationBar.hidden =NO;
            [self customNavigationTitleView];
            [self customNavigationRighItem];
            [self customNavigationLeftItem];
            break;
        case CMNavTypeNoLeftItem:
             self.navigationController.navigationBar.hidden =NO;
            [self customNavigationTitleView];
            [self customNavigationRighItem];

        default:
            DDLog(@"未知Nav状态");
            break;
    }
    
}


//定制导航栏上的titleView
- (void)customNavigationTitleView
{
    NSString *titleStr =[self customNavigationTitleViewTitleStr];
    UILabel *label = [CMCustomViewFactory createLabel:CGRectMake(Num_Zero, 5, 100, 34) title:titleStr color:[UIColor whiteColor] font:[UIFont systemFontOfSize:19 *kAppScale] textAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView = label;
}

//定制导航栏左边的按钮
- (void)customNavigationLeftItem
{
//    UIButton * leftButton = [CMCustomViewFactory  createButton:CGRectMake(0, 0, 60, 34) title:@"分类" backgourdImage:[UIImage imageNamed:@"icon_fanhui"]];
    UIButton *leftButton =[UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(-10, 0, 30, 34);
//    leftButton.backgroundColor =[UIColor redColor];
    [leftButton setImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(navigationLeftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//定制导航栏右边的按钮
- (void)customNavigationRighItem
{
    NSString *titleStr =[self customNavigationRightItemTitle];
    
    UIButton * rightButton = [CMCustomViewFactory  createButton:CGRectMake(Num_Zero, Num_Zero, Ten*6, Ten*3) title:titleStr backgourdImage:[UIImage imageNamed:@"icon_rightItemBg"]];
    rightButton.titleLabel.font =[UIFont systemFontOfSize:15 *kAppScale];
    [rightButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateHighlighted];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"icon_rightItemBg"] forState:UIControlStateHighlighted];
    [rightButton setAdjustsImageWhenDisabled:NO];
    [rightButton addTarget:self action:@selector(navigationRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 子类重写

-(CMNavType)getNavType {
    return CMNavTypeNoRightItem;
}

-(NSString *)customNavigationRightItemTitle {
    return @"设置";
}

-(NSString *)customNavigationTitleViewTitleStr {
    return self.title;
}
- (void)navigationLeftButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)navigationRightButtonClick:(id)sender
{
    
}
@end
