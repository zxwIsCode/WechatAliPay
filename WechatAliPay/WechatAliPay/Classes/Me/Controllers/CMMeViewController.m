//
//  CMMeViewController.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMMeViewController.h"

@interface CMMeViewController ()

@end

@implementation CMMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.view.backgroundColor =[UIColor yellowColor];

    // Do any additional setup after loading the view.
}
#pragma mark - 子类继承

-(CMNavType)getNavType {
    return CMNavTypeOnlyTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
