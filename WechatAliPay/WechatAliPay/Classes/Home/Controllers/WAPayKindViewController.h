//
//  FAPayKindViewController.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//  选择支付方式界面

#import "CMBaseViewController.h"


@interface WAPayKindViewController : CMBaseViewController

// 所有的数据源
@property(nonatomic,strong)NSMutableArray *allDataSource;


// 是否使用积分 1：使用 2：不使用
@property(nonatomic,assign)NSInteger integralKind;


// 总价格
@property(nonatomic,assign)NSInteger allMoneyPrice;

@end
