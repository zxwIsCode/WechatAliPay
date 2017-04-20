//
//  FAPayKindModel.h
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAPayKindModel : NSObject

@property(nonatomic,copy)NSString *payKindStr;

@property(nonatomic,copy)NSString *payid;


@property(nonatomic,assign)BOOL isSelected;

// 为空时不需要图片
@property(nonatomic,copy)NSString *payKindIcon;

@end
