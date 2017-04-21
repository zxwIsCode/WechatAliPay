//
//  CMWechatPayManager.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/12/8.
//  Copyright © 2016年 DaviD. All rights reserved.
//

#import "CMWechatAliPayManager.h"
#import "CMHttpRequestModel.h"

#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

static CMWechatAliPayManager *_WpayInstance = nil;
@interface CMWechatAliPayManager ()

// 临时记录返回的参数，为支付成功后去商户查询订单做好准备
@property(nonatomic,strong)CMHttpRequestModel *paramsModel;

@end

@implementation CMWechatAliPayManager

+ (instancetype)sharedWpayManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _WpayInstance = [[CMWechatAliPayManager alloc] init];
    });
    
    return _WpayInstance;
}
-(instancetype)init {
    if (self = [super init]) {
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    }
    return self;
}
// 请求微信或则支付宝订单参数的Http
-(void)sendWeChatAliPayRequestParam:(CMHttpRequestModel *)model {
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
                      #warning 根据下订单返回的具体参数处理（替换成您与后台商量的情景）
                      if ([[response allKeys]containsObject:@"code"] && [[response allKeys]containsObject:@"body"]) {
                          NSNumber *code =response[@"code"];
                          id infoId =response[@"body"];
                          if ([infoId isKindOfClass:[NSString class]]) {// 支付宝支付
                              NSString *infoStr =(NSString *)infoId;
#warning 支付宝支付应用支付过程中返回应用唯一标示不要忘记改了，还有info中的urlScheme不要忘了加
                              NSString *appScheme = @"WAPay";
                              
                              // 调用支付宝的支付接口
                              [[AlipaySDK defaultService] payOrder:infoStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                                  NSLog(@"reslut = %@",resultDic);
                                  NSString *resultStatus = resultDic[@"resultStatus"];
                                  [ws.delegate Wpay:ws andPayKind:WAPayKindAliPay andPayResult:[resultStatus intValue]];

                              }];
                              return ;


                          }else if([infoId isKindOfClass:[NSDictionary class]]){ // 微信支付
                              NSDictionary *infoDic =(NSDictionary *)infoId;

                              if ([code longValue] ==1 && infoDic) {
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
                                  [WXApi sendReq:payReq];
                                  return ;
                              }
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
#warning 微信支付的订单参数（AppId等），不要忘记更改了
        req.openID =@"wxe9beac44b65d4815";
        req.partnerId =params[@"partnerid"];
        req.prepayId =params[@"prepayid"];
        req.nonceStr =params[@"noncestr"];
        req.timeStamp =[params[@"timestamp"] intValue];
        req.package =params[@"package"];
        req.sign =params[@"sign"];
        return req;
    }
    return nil;
}

#pragma mark - 微信支付成功后返回

-(void) onResp:(BaseResp*)resp {
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        if ([self.delegate respondsToSelector:@selector(Wpay:andPayKind:andPayResult:)]) {
            [self.delegate Wpay:self andPayKind:WAPayKindWechat andPayResult:resp.errCode];
        }

       
    }
}
@end
