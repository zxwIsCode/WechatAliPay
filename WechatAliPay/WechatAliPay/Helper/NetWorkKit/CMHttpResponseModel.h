//
//  CMHttpResponseModel.h
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMResponseDelegate.h"


typedef NS_ENUM(NSUInteger, CMReponseCodeState) {
    CMReponseCodeState_Success =1,  // 成功
    CMReponseCodeState_NoData, // 成功没数据
    CMReponseCodeState_NoParams,  // 成功，但是参数不完整
    CMReponseCodeState_Faild,  // 失败

};

@interface CMHttpResponseModel : NSObject<CMResponseDelegate>

//@property (nonatomic, assign, readonly) BOOL isSucc;   //结果
@property(nonatomic,assign,readonly) CMReponseCodeState state;// 根据返回的code值，包装返回的整体数据状态
@property (nonatomic, assign, readonly) NSInteger code;   //结果
@property (nonatomic, copy, readonly) NSString *alertMsg;   //提示信息
@property (nonatomic, assign, readonly) id data;   //数据
@property (nonatomic, strong, readonly) NSError *error;  //业务错误

@end
