//
//  CMWechatPayManager.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/12/8.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMWechatPayManager.h"
#import "CMHttpRequestModel.h"
//#import "CMUserTools.h"
//#import "CMWechatUser.h"
static CMWechatPayManager *_WpayInstance = nil;
@interface CMWechatPayManager ()

// 临时记录返回的参数，为支付成功后去商户查询订单做好准备
@property(nonatomic,strong)CMHttpRequestModel *paramsModel;

@end

@implementation CMWechatPayManager

+ (instancetype)sharedWpayManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _WpayInstance = [[CMWechatPayManager alloc] init];
    });
    
    return _WpayInstance;
}
-(instancetype)init {
    if (self = [super init]) {
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    }
    return self;
}
// 请求微信订单参数的Http
-(void)sendWeChatRequestParam:(CMHttpRequestModel *)model {
    NSURLSessionDataTask *task = nil;
    WS(ws);
    NSString *urlStr =[NSString stringWithFormat:@"%@%@",model.localHost,model.appendUrl];
    if (model.type ==CMHttpType_POST) {// POST 请求
        
        task = [self POST:urlStr
               parameters:model.paramDic
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task,
                            id  _Nonnull responseObject) {
                      // 0.解析返回的参数
                      NSDictionary *response =(NSDictionary *)responseObject;
                      if ([[response allKeys]containsObject:@"code"] && [[response allKeys]containsObject:@"info"]) {
                          NSNumber *code =response[@"code"];
                          NSDictionary *infoDic =response[@"info"];
                          if ([code intValue] ==200 && infoDic) {
                              // 服务器返回正确的业务逻辑处理
                              // 1.判断自己的服务器的产生的订单参数返回是否正确
                              PayReq *payReq =[ws isWpayParamsIsCorrect:infoDic];
                              if (!payReq) {
                                  return ;
                              }
                              // 2.临时记录发送的参数
                              ws.paramsModel =model;
                              
                              [DisplayHelper displaySuccessAlert:@"请求微信支付订单成功!"];

                              // 3.调用微信APIpayReq对应的参数
//                              [WXApi sendReq:payReq];
                              return ;
                          }
                      }
                      [DisplayHelper displayWarningAlert:@"请求微信支付订单服务器返回有误!"];
                      
                      
                     
                      
                  }
                  failure:^(NSURLSessionDataTask * _Nonnull task,
                            NSError * _Nonnull error) {
                      [model requestErrorCallback:error];
                  }];
    }
}
// 判断自己的服务器的产生的订单参数返回是否正确,并返回包装好的参数
-(PayReq *)isWpayParamsIsCorrect:(NSDictionary *)params {
    
    if ([params allKeys].count >=6) {
        PayReq *req =[[PayReq alloc]init];
#warning 微信支付的订单参数，不要忘记传了

//        CMWechatUser *wUser =[CMUserTools Wechat];
//        req.openID =wUser.uid;
//        req.partnerId =params[@"partnerid"];
//        req.prepayId =params[@"prepayid"];
//        req.nonceStr =params[@"noncestr"];
//        req.timeStamp =[params[@"timestamp"] intValue];
//        req.package =params[@"package"];
//        req.sign =params[@"sign"];
        return req;
    }
    return nil;
}

#pragma mark - 微信支付成功后返回

-(void) onResp:(BaseResp*)resp {
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        if ([self.delegate respondsToSelector:@selector(Wpay:andPayResult:)]) {
            [self.delegate Wpay:self andPayResult:resp.errCode];
        }

       
    }
}
@end
