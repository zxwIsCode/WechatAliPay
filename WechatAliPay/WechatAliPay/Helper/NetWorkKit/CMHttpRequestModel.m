//
//  CMHttpRequestModel.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/15.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMHttpRequestModel.h"
#import "CMHttpResponseModel.h"

@implementation CMHttpRequestModel

@synthesize flag = _flag;
@synthesize callback = _callback;

-(instancetype)init {
    if (self =[super init]) {
        self.type =CMHttpType_POST;
#warning 服务器iP地址
//        self.localHost =kHttpHost;
    }
    return self;
}
- (NSDictionary *)reqParamDic {
    return nil;
}

- (void)requestFinishedCallback:(id)result {
    
//    NSNumber *isSuccess =result[@"type"];
    if ([result isKindOfClass:[NSDictionary class]]) {
        CMHttpResponseModel *reponse = [self getResponseWithInfo:result err:nil];// 对callBack进行数据包装，方便判断
        DDLog(@"服务器返回成功");
        if (self.callback) {
            self.callback(reponse,nil);
        }
    }else {
        NSError *error =[NSError errorWithDomain:@"未知数据类型" code:-1 userInfo:nil];
        if (self.callback) {
            self.callback(nil,error);
        }
    }


}
- (void)requestErrorCallback:(NSError *)error {
    
    self.callback(nil,error);

}
- (id<CMResponseDelegate>)getResponseWithInfo:(id)result
                                          err:(NSError *)err {
    CMHttpResponseModel *reponse =[[CMHttpResponseModel alloc]initWithData:result err:err];
    return reponse;
}
-(NSMutableDictionary *)paramDic {
    if (!_paramDic) {
        _paramDic =[NSMutableDictionary dictionary];
    }
    return _paramDic;
}

@end
