//
//  CMHomeViewController.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMHomeViewController.h"
#import "WAPayKindViewController.h"

@interface CMHomeViewController ()

@property(nonatomic,strong)NSArray *testArray;


@property(nonatomic,strong)UIButton *payBtn;


@end

@implementation CMHomeViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    self.view.backgroundColor =[UIColor blueColor];
    
    [self.view addSubview:self.payBtn];
    
    

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.payBtn.bounds =CGRectMake(0, 0, 200, 40);
    self.payBtn.center =CGPointMake(SCREEN_WIDTH *0.5, 200 *kAppScale);
    
    self.payBtn.backgroundColor =[UIColor redColor];
}
-(void)payBtnClick:(UIButton *)button {
    
    WAPayKindViewController *payKindVC =[[WAPayKindViewController alloc]init];
    [self.navigationController pushViewController:payKindVC animated:YES];
}
#pragma mark - 子类继承

-(CMNavType)getNavType {
    return CMNavTypeAll;
}

#pragma mark - Setter & Getter

-(UIButton *)payBtn {
    if (!_payBtn) {
        _payBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_payBtn setTitle:@"支付入口" forState:UIControlStateNormal];
        [_payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payBtn;
}

@end
