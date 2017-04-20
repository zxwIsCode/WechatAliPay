//
//  FAPayKindSelectedView.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/2/21.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAPayKindSelectedView.h"
#import "FAPayKindModel.h"
#import "FAPayKindTableCell.h"

@implementation FAPayKindSelectedView

+(instancetype)SelectedTableView {
    
    return [[self alloc]init];
    
}
-(instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
//        self.tableView.backgroundColor =[UIColor brownColor];
//        self.payWayLable.backgroundColor =[UIColor yellowColor];
        [self addSubview:self.payWayLable];
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - Private Methods

-(void)cancleAllSelected {
    NSMutableArray *payOriginalArr =self.payArr;
    for (FAPayKindModel *model in payOriginalArr) {
        model.isSelected =NO;
    }
    self.payArr =payOriginalArr;
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.payArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FAPayKindTableCell *cell =[FAPayKindTableCell updateWithTableView:tableView];
    if (cell) {
        if (self.payArr.count) {
            FAPayKindModel *model =self.payArr[indexPath.row];
            if (indexPath.row ==_indexKind) { // 如果当前初始化的cell的下标与处于选择状态的一致，则界面必定处于选择状态
                model.isSelected =YES;
            }else {
                model.isSelected =NO;
 
            }
            cell.model =model;
            
        }
        
    }
    WS(ws);
    cell.payKindBlock = ^(FAPayKindModel *model) {
        // 所有的取消选择状态
        [ws cancleAllSelected];
        
        // 确定点击的是哪一个
        if ([self.payArr containsObject:model]) {
            _indexKind =[self.payArr indexOfObject:model] ;
        }
        [ws.tableView reloadData];
    };
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50 *kAppScale;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
//    _indexKind =indexPath.row;
}


- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        //        _tableView.rowHeight = 55;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}

//-(void)setPayArr:(NSMutableArray *)payArr {
//    _payArr =payArr;
//    [self.tableView reloadData];
//}

-(void)setIndexKind:(NSInteger)indexKind {
    _indexKind =indexKind;
    [self.tableView reloadData];
    
}

-(UILabel *)payWayLable {
    if (!_payWayLable) {
        _payWayLable =[[UILabel alloc]init];
    }
    return _payWayLable;
}


@end
