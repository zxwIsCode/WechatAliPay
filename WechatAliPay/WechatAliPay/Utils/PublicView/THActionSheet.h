//
//  THActionSheet.h
//  SmallGowildClient
//
//  Created by Teehom on 16/4/7.
//  Copyright © 2016年 Teehom. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonCheckBlock) (NSInteger buttonIndex);
typedef void (^CancelButtonBlock) ();

@interface THActionSheet : UIView


@property (assign, nonatomic) NSInteger isDatePicker;//0不是 1是

@property (copy, nonatomic) ButtonCheckBlock buttonBlock;

@property (copy, nonatomic) CancelButtonBlock cancelBlock;

- (id)initWithTitle:(NSString *)title middleView:(id)middleView cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)titles isDatePicker:(NSInteger)datePicker;

- (void)showInView:(UIView *)mSuperView;

- (void)dismiss;



@end
