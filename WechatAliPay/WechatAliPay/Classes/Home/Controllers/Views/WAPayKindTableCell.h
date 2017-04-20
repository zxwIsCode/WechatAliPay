//
//  FAPayKindTableCell.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WAPayKindModel.h"


@interface WAPayKindTableCell : UITableViewCell

typedef void(^PayKindTableCellBlock)(WAPayKindModel *payKindModel);

+(instancetype)updateWithTableView:(UITableView *)tableView;

@property(nonatomic,strong)WAPayKindModel *model;

@property(nonatomic,copy)PayKindTableCellBlock payKindBlock;

@end
