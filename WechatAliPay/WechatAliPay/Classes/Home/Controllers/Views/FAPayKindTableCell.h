//
//  FAPayKindTableCell.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAPayKindModel.h"


@interface FAPayKindTableCell : UITableViewCell

typedef void(^PayKindTableCellBlock)(FAPayKindModel *payKindModel);

+(instancetype)updateWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)FAPayKindModel *model;

@property(nonatomic,copy)PayKindTableCellBlock payKindBlock;

@end
