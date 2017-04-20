//
//  CMHttpStateTools.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/12/21.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMHttpStateTools.h"

@implementation CMHttpStateTools

+(void)showHtttpStateView:(CMReponseCodeState)state {

    if (state ==CMReponseCodeState_NoParams) {// 参数不完整的情况   //返回code =205
        [DisplayHelper displaySuccessAlert:@"请求成功，但是参数传递有误!"];
        return ;
    }else if (state ==CMReponseCodeState_NoData) {// 请求成功，数据为空  //返回code =204
        [DisplayHelper displaySuccessAlert:@"虽然请求成功，但没有数据了!"];
        return;
    }else   {// 请求失败,网络错误（还有state为空，即没有走包装返回参数的情况也是网络错误） //网络请求失败
        [DisplayHelper displayWarningAlert:@"网络请求失败，请稍后再试！"];
        return ;
    }
    
}

@end
