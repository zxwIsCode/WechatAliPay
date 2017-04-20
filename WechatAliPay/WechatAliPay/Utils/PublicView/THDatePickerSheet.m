//
//  THDatePickerSheet.m
//  SmallGowildClient
//
//  Created by Teehom on 16/4/15.
//  Copyright © 2016年 Teehom. All rights reserved.
//

#import "THDatePickerSheet.h"


#define AppFrameheight           [[UIScreen mainScreen] bounds].size.height
#define AppFrameWidth           [[UIScreen mainScreen] bounds].size.width

static CGFloat THActionSheetButtonHeight = 44.0f;


@interface THDatePickerSheet () {
    UIControl *_mask;  //遮罩
    CGFloat offsetY;
    NSArray *titlesArray;
    UIButton *otherButton;
    NSInteger index;
}

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UILabel *titleLb;
@property (strong, nonatomic) UIButton *cancelButton;

@end

@implementation THDatePickerSheet

- (id)initWithTitle:(NSString *)title middleView:(UIView *)middleView cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)titles {
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(10, AppFrameheight, AppFrameWidth-20, 0)];
        [self setBackgroundColor:[UIColor clearColor]];
        titlesArray = titles;
        _mainView = [[UIView alloc] init];
        [_mainView.layer setCornerRadius:5.0];
        [_mainView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_mainView];
        
        offsetY = 10;
        if (title) {
            _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, offsetY, CGRectGetWidth(self.frame), 20)];
            [_titleLb setBackgroundColor:[UIColor clearColor]];
            [_titleLb setTextAlignment:NSTextAlignmentCenter];
//            [_titleLb setFont:[UIFont systemFontOfSize:14.0f]];
            [_titleLb setNewLigntFontWithSize:14.0f];

            [_titleLb setText:title];
            [_titleLb setTextColor:[[UIColor grayColor] colorWithAlphaComponent:0.8]];
            offsetY = CGRectGetMaxY(_titleLb.frame)+10;
            [_mainView addSubview:_titleLb];
        }
        
        if (middleView) {
            [middleView setFrame:CGRectMake(0, offsetY, CGRectGetWidth(middleView.frame), CGRectGetHeight(middleView.frame))];
            offsetY = CGRectGetMaxY(middleView.frame)+10;
            [_mainView addSubview:middleView];
        }
        
        index = 0;
        if (titles && titles.count>0) {
            for (int i = 0 ; i<titles.count; i++) {
                index = i;
                UIControl *line = [[UIControl alloc] initWithFrame:CGRectMake(0, offsetY+(0.5+THActionSheetButtonHeight)*i, CGRectGetWidth(self.frame), 0.5)];
                [line setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.5]];
                [_mainView addSubview:line];
                
                otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [otherButton setFrame:CGRectMake(0, offsetY+(0.5+THActionSheetButtonHeight)*i, CGRectGetWidth(self.frame), THActionSheetButtonHeight)];
                [otherButton setBackgroundColor:[UIColor clearColor]];
                [otherButton addTarget:self action:@selector(otherButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                [otherButton setTitle:titles[i] forState:UIControlStateNormal];
                [otherButton setTitleColor:DEFAULT_BLUE_COLOR forState:UIControlStateNormal];
                [otherButton setTag:index];
                [_mainView addSubview:otherButton];
                if (i == titles.count - 1) {
                    offsetY = CGRectGetMaxY(otherButton.frame);
                }
            }
        }
        
        [_mainView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), offsetY)];
        
        if (cancelButtonTitle) {
            _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_cancelButton setFrame:CGRectMake(0, CGRectGetMaxY(_mainView.frame)+10, CGRectGetWidth(self.frame), THActionSheetButtonHeight)];
            [_cancelButton setBackgroundColor:[UIColor whiteColor]];
            [_cancelButton setTitleColor:DEFAULT_BLUE_COLOR forState:UIControlStateNormal];
            [_cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [_cancelButton addTarget:self action:@selector(otherButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_cancelButton.layer setCornerRadius:5.0];
            [_cancelButton setTag:index+1];
            [self addSubview:_cancelButton];
            offsetY  = CGRectGetMaxY(_cancelButton.frame)+10;
        }
        [self setFrame:CGRectMake(10, AppFrameheight, AppFrameWidth-20, offsetY)];
    }
    return self;
}


- (void)otherButtonAction:(UIButton *)button{
    if (button.tag == index+1) {
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }else{
        if (self.buttonBlock) {
            self.buttonBlock(button.tag);
        }
    }
    [self dismiss];
}


@end
