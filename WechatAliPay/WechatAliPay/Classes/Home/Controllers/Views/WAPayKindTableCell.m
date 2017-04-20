//
//  FAPayKindTableCell.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "WAPayKindTableCell.h"

@interface WAPayKindTableCell ()

@property(nonatomic,strong)UIImageView *payImage;

@property(nonatomic,strong)UILabel *lable;

@property(nonatomic,strong)UIButton *selectedBtn;

@property(nonatomic,strong)UIView *lineView;

@end

@implementation WAPayKindTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)updateWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"kFAPayKindTableCelld";
    WAPayKindTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WAPayKindTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 1.初始化
        self.payImage =[[UIImageView alloc]init];
        self.lable =[[UILabel alloc]init];
        self.selectedBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        self.lineView =[[UIView alloc]init];
        
        // 2.设置frame
        CGFloat selfH =50 *kAppScale;
        CGFloat payImageWH =24 *kAppScale;
        CGFloat cellItemSpacing =10 *kAppScale;
        self.payImage.center =CGPointMake(25 *kAppScale, selfH *0.5);
        self.payImage.bounds =CGRectMake(0, 0, payImageWH, payImageWH);
        
        self.lable.frame =CGRectMake(CGRectGetMaxX(self.payImage.frame) +cellItemSpacing, 0, 100 *kAppScale, selfH);
        CGFloat selectedBtnWH =selfH;
        self.selectedBtn.frame =CGRectMake(SCREEN_WIDTH -selectedBtnWH, 0, selectedBtnWH, selectedBtnWH);
        
        self.lineView.frame =CGRectMake(cellItemSpacing, selfH -2, SCREEN_WIDTH -2 *cellItemSpacing, 2);
        
        // 属性设置
        [self.selectedBtn setImage:[UIImage imageNamed:@"icon_xuanzhong"] forState:UIControlStateNormal];
        [self.selectedBtn setImage:[UIImage imageNamed:@"icon_xuanzhongb"] forState:UIControlStateHighlighted];
        [self.selectedBtn setImage:[UIImage imageNamed:@"icon_xuanzhongb"] forState:UIControlStateSelected];
        [self.selectedBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.lineView.backgroundColor =UIColorFromHexValue(0xf5f5f5);

        // 测试颜色
//        self.payImage.backgroundColor =[UIColor redColor];
//        self.lable.backgroundColor =[UIColor blueColor];
//        self.selectedBtn.backgroundColor =[UIColor orangeColor];
        
        // 添加到父View
        [self.contentView addSubview:self.payImage];
        [self.contentView addSubview:self.lable];
        [self.contentView addSubview:self.selectedBtn];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}
-(void)setModel:(WAPayKindModel *)model {
    _model =model;
//    self.payImage.backgroundColor =[UIColor yellowColor];
    self.lable.text =model.payKindStr;
    self.selectedBtn.selected =model.isSelected;
    if (model.payKindIcon) {
        [self.payImage sd_setImageWithURL:[NSURL URLWithString:model.payKindIcon]];
    }
}
-(void)buttonClick:(UIButton *)btn {
    btn.selected =!btn.selected;
    if (self.payKindBlock) {
        self.payKindBlock(_model);
    }
}



@end
