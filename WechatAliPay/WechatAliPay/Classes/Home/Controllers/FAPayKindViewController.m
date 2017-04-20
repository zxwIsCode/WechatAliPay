//
//  FAPayKindViewController.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "FAPayKindViewController.h"
#import "FAPayKindModel.h"

#import "FAPayKindTableCell.h"

#import "FAPayKindSelectedView.h"

//#import "RSADataSigner.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import "CMWechatPayManager.h"

@interface FAPayKindViewController ()

//@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)FAPayKindSelectedView *selectedTableView;

@property(nonatomic,strong)NSMutableArray *payArr;

@property(nonatomic,strong)UIButton *yesPayBtn;

@property(nonatomic,strong)UILabel *rightLable;

// 那个平台是选中状态
@property(nonatomic,assign)NSInteger indexKind;

@end

@implementation FAPayKindViewController

#pragma mark - Init

- (void)viewDidLoad {
    
    self.title =@"收银台";
    [super viewDidLoad];
    
    self.selectedTableView.indexKind =0;
    
    self.view.backgroundColor =[UIColor whiteColor];
    [self initAllPayKindDatas];
    
    CGFloat lableH =42 *kAppScale;
    CGFloat rightLableW =120 *kAppScale;
    
    UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100 *kAppScale,lableH)];
    lable.text =@"支付方式";
    lable.font =[UIFont systemFontOfSize:kShopping_MiddleTextFont];
    UILabel *rightLable =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -rightLableW -10, 0, rightLableW,lableH)];
    rightLable.text =[NSString stringWithFormat:@"还需支付:￥%ld",self.allMoneyPrice];
    rightLable.font =[UIFont systemFontOfSize:kShopping_MiddleTextFont];

    rightLable.textColor =kShopping_redTextColor;
    self.rightLable =rightLable;
    
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, lableH -2, SCREEN_WIDTH, 2)];
    lineView.backgroundColor =UIColorFromHexValue(0xf5f5f5);
   
    CGFloat yesPayBtnH =50 *kAppScale;
    CGFloat tableViewHeight = SCREEN_HEIGHT -yesPayBtnH -NavigationBar_BarHeight- lableH;
    
    self.selectedTableView.frame =CGRectMake(0, CGRectGetMaxY(lable.frame), SCREEN_WIDTH, tableViewHeight);
    self.selectedTableView.tableView.frame =CGRectMake(0, 0, SCREEN_WIDTH, tableViewHeight);

    
    self.yesPayBtn.frame =CGRectMake(0, SCREEN_HEIGHT -NavigationBar_BarHeight  -yesPayBtnH, SCREEN_WIDTH, yesPayBtnH);
    
    [self.view addSubview:lable];
    [self.view addSubview:rightLable];
    [self.view addSubview:lineView];
    
//    self.selectedTableView.backgroundColor =[UIColor yellowColor];
    
    [self.view addSubview:self.selectedTableView];
    [self.view addSubview:self.yesPayBtn];
    
    
   
    // Do any additional setup after loading the view.
}
#pragma mark - Private Methods

-(void)initAllPayKindDatas {
    // 假数据处理
//    NSArray *kindStrArr =@[@"银联支付",@"支付宝支付",@"微信支付"];
//    NSArray * iconArr =@[@"icon_zhifuyl",@"icon_zhifuzhi",@"icon_zhifuwei"];
//    for (int index =0; index <3; index ++) {
//        FAPayKindModel *payModel =[[FAPayKindModel alloc]init];
//        payModel.payKindIcon =[iconArr objectAtIndex:index];
//        payModel.payKindStr =kindStrArr[index];
//        if (index ==0) {
//            payModel.isSelected =YES;
//        }else {
//            payModel.isSelected =NO;
//  
//        }
//        [self.payArr addObject:payModel];
//    }
//    // 传值
//    self.selectedTableView.payArr =self.payArr;
    
    
    CMHttpRequestModel *paramsModel =[[CMHttpRequestModel alloc]init];
    paramsModel.appendUrl =kCart_PayGetPayr;
    paramsModel.type =CMHttpType_GET;
    // 包装参数设置
    WS(ws);
    [[DisplayHelper shareDisplayHelper]showLoading:self.view noteText:@"加载中"];
    paramsModel.callback =^(CMHttpResponseModel *result, NSError *error) {
        
        if (result) {
            if (result.state == CMReponseCodeState_Success) {// 成功,做自己的逻辑
                DDLog(@"%@",result.data);
//                if (result.alertMsg) {
//                    [DisplayHelper displaySuccessAlert:result.alertMsg];
//                }else {
//                    [DisplayHelper displaySuccessAlert:@"支付方式获得成功哦！"];
//                }
                NSArray *payWayArr =(NSArray *)result.data;
                if (payWayArr.count)  {
                    for (NSDictionary *payDic in payWayArr) {
                        FAPayKindModel *payKindModel =[[FAPayKindModel alloc]init];
                        payKindModel.payKindStr =payDic[@"payname"];
                        payKindModel.payid =payDic[@"payid"];
                        payKindModel.payKindIcon =payDic[@"pimg"];
                        [ws.payArr addObject:payKindModel];

                    }
                    ws.selectedTableView.payArr =self.payArr;
                    [ws.selectedTableView.tableView reloadData];
                }
                
            }else {// 失败,弹框提示
                
                DDLog(@"%@",result.error);
                if (result.alertMsg) {
                    [DisplayHelper displayWarningAlert:result.alertMsg];
                    
                }else {
                    [DisplayHelper displayWarningAlert:@"请求成功,但没有数据哦!"];
                }
            }
        }else {
            
            [DisplayHelper displayWarningAlert:@"网络异常，请稍后再试!"];
        }
        [[DisplayHelper shareDisplayHelper]hideLoading:ws.view];

  
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:paramsModel];
    
}


#pragma mark - Action Methods

//-(void)yesPayBtnClick:(UIButton *)button {
//    
//    CMHttpRequestModel *paramsModel =[[CMHttpRequestModel alloc]init];
//    // 1. 传递参数的准备
//    if (self.selectedTableView.payArr.count >self.selectedTableView.indexKind) {
//        FAPayKindModel *model = self.selectedTableView.payArr[self.selectedTableView.indexKind];
//        
//        DDLog(@"您点击了%@平台的确认支付",model.payKindStr);
//        [paramsModel.paramDic setValue:model.payid forKey:@"payid"];
//
//        
//    }
//
//    
//    // 2.订单处理的参数包装：
//    paramsModel.appendUrl =kCart_OrderPlaceOrder;
//    // 用户收货地址id
//    FAAddressModel *addressModel =[FAUserTools UserAddress];
//    if (!addressModel) {
//        [DisplayHelper displayWarningAlert:@"您还没有收获地址哦！"];
//        return ;
//    }
//    
//    [paramsModel.paramDic setValue:self.addressModel.address_id forKey:@"addid"];
//
//    FAUserModel *userModel =[FAUserTools UserAccount];
//    if (!userModel.user_id) {
//        [DisplayHelper displayWarningAlert:@"请登录后再试下哦!"];
//        return ;
//    }
//    [paramsModel.paramDic setValue:userModel.user_id forKey:@"userid"];
//    
//    // 是否使用积分（ 1是 2不是）
//    [paramsModel.paramDic setValue:@(self.integralKind) forKey:@"isuseintl"];
//    
//    NSInteger totalIntegral = [userModel.integral integerValue];
//
//   
//    if (self.shoppingKind ==FAShoppingKindMore) { // 购物车结算
//        NSMutableArray *allOrderArr =[NSMutableArray array];
//        for (FAShoppingSectionModel *sectionModel in self.allDataSource) {
//            NSArray *cartArr =sectionModel.allItemArray;
//            if (cartArr.count) {
//                NSMutableDictionary *backOrderDic =[NSMutableDictionary dictionary];
//                NSMutableArray *backCartArr =[NSMutableArray array];
//                for (FACommotidyModel *commotidyModel in cartArr) {
//                    NSMutableDictionary *itemDic =[NSMutableDictionary dictionary];
//                    [itemDic setValue:commotidyModel.gctid forKey:@"id"];
//                    
//                    // 积分处理的问题
//                    if (totalIntegral) { // 有积分
//                        if (self.integralKind  && [commotidyModel.isintpay integerValue]) { // 可以使用积分
//                            if (totalIntegral<commotidyModel.reallyIntegral) { // 剩余积分比较少
//                                commotidyModel.reallyIntegral = totalIntegral;
//                                totalIntegral =0;
//                            }else { // 剩余积分比较多
//                                totalIntegral =totalIntegral - commotidyModel.reallyIntegral;
//                            }
//                            [itemDic setValue:@(commotidyModel.reallyIntegral) forKey:@"jf"];
//                        }else {
//                            [itemDic setValue:@(0) forKey:@"jf"];
//                        }
//
//                    }
//                    
//                    
//                    [backCartArr addObject:itemDic];
//                }
//                [backOrderDic setValue:sectionModel.sellerid forKey:@"bid"];
//                if (!sectionModel.shipWayModel.sellerMessage) {
//                    [backOrderDic setValue:@"" forKey:@"msg"];
//                }else {
//                    [backOrderDic setValue:sectionModel.shipWayModel.sellerMessage forKey:@"msg"];
//                }
//                // 如果为空的话，就默认用第一种配送方式
//                if (!sectionModel.shipWayModel.odyid) {
//                    sectionModel.shipWayModel.odyid =@"1";
//                }
//                [backOrderDic setValue:sectionModel.shipWayModel.odyid forKey:@"way"];
//                
//                [backOrderDic setValue:backCartArr forKey:@"cart"];
//                [allOrderArr addObject:backOrderDic];
//            }
//            
//            
//        }
//        NSMutableDictionary *cartDic =[NSMutableDictionary dictionary];
//        [cartDic setValue:allOrderArr forKey:@"cart"];
//        NSString *jsonStr =[NSString dictionaryToJsonString:cartDic];
//        
//        [paramsModel.paramDic setValue:jsonStr forKey:@"single"];
//
//    }else if (self.shoppingKind ==FAShoppingKindSingle) { // 单个商品结算
//        if (self.allDataSource.count) {
//          
//            FAShoppingSectionModel *sectionModel =self.allDataSource[0];
//            if (sectionModel.allItemArray.count) {
//                FACommotidyModel *itmeModel = sectionModel.allItemArray[0];
//                NSMutableDictionary *orderDic =[NSMutableDictionary dictionary];
//                [orderDic setValue:itmeModel.gid forKey:@"goodsid"];
//                [orderDic setValue:itmeModel.bid forKey:@"bid"];
//                [orderDic setValue:sectionModel.shipWayModel.sellerMessage forKey:@"msg"];
//                [orderDic setValue:sectionModel.shipWayModel.odyid forKey:@"way"];
//                
//                if (totalIntegral) { // 有积分
//                    if (self.integralKind  && [itmeModel.isintpay integerValue]) { // 可以使用积分
//                        if (totalIntegral<[itmeModel.intlpay integerValue]) { // 剩余积分比较少
//                            itmeModel.reallyIntegral = totalIntegral;
//                            totalIntegral =0;
//                        }else { // 剩余积分比较多
//                            totalIntegral =totalIntegral - itmeModel.reallyIntegral;
//                        }
//                        [orderDic setValue:@(itmeModel.reallyIntegral) forKey:@"jf"];
//                    }else {
//                        [orderDic setValue:@(0) forKey:@"jf"];
//                    }
//                    
//                }
//                if (itmeModel.sc.count >itmeModel.goodsFormatCount) {
//                    FAShopingItemFormatModel *itemFormatModel =itmeModel.sc[itmeModel.goodsFormatCount];
//                    [orderDic setValue:itemFormatModel.gsid forKey:@"spid"];
//                    
//                }
//                
//                [orderDic setValue:@(itmeModel.gnum) forKey:@"gnum"];
//
//                NSMutableDictionary *allSingleDic =[NSMutableDictionary dictionary];
//                
//                [allSingleDic setValue:orderDic forKey:@"order"];
//                NSString *jsonStr =[NSString dictionaryToJsonString:allSingleDic];
//                
//                [paramsModel.paramDic setValue:jsonStr forKey:@"single"];
//
//            }
//            
//            
//        }
//    }
//    
//    
//    // 3.发送的网络请求
//    
//    if (self.selectedTableView.indexKind==0) {// 支付宝支付
//        [self requestAliPayMoney:paramsModel];
//    }else if (self.selectedTableView.indexKind==1) {// 微信支付
//        // 充值直接调微信充值
//        CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
//        model.appendUrl = kCart_OrderPlaceOrder;
//        model.paramDic =paramsModel.paramDic;
//        
//        
//        model.callback = ^(CMHttpResponseModel * result, NSError *error) {
//            if (result.state ==CMReponseCodeState_Success) {
//                
//            }else {
//                [CMHttpStateTools showHtttpStateView:result.state];
//                
//            }
//            
//        };
//        
//        [[CMWechatPayManager sharedWpayManager] sendWeChatRequestParam:model];
//    }else {// 银联支付
//        
//    }
//   
//   
//}


//#pragma mark - CMWpaySearchResultDelegate
//// 微信支付完成后告诉客户端
//-(void)Wpay:(CMWechatPayManager *)manager andPayResult:(int)code {
//    
//    switch (code) {
//        case WXSuccess:
//            
//            // 1. 包装对应查询参数
//            [DisplayHelper displaySuccessAlert:@"微信支付成功!"];
//            // 2. 发送查询的是否成功的请求
//            
//            break;
//            
//        default:
//            
//            break;
//    }
//}

-(void)requestAliPayMoney:(CMHttpRequestModel *)paramsModel {
    paramsModel.callback =^(CMHttpResponseModel *result, NSError *error) {
        
        if (result) {
            if (result.state == CMReponseCodeState_Success) {// 成功,做自己的逻辑
                DDLog(@"%@",result.data);
                
                if ([result.data isKindOfClass:[NSString class]]) {
                    // NOTE: 调用支付结果开始支付
                    //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
                    NSString *appScheme = @"FarmAA";
                    
                    
//                    [[AlipaySDK defaultService] payOrder:result.data fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//                        NSLog(@"reslut = %@",resultDic);
//                    }];
                }
//                else { // 微信和银联支付
//                    if (result.alertMsg) {
//                        [DisplayHelper displaySuccessAlert:result.alertMsg];
//                    }else {
//                        [DisplayHelper displaySuccessAlert:@"商品结算成功哦！"];
//                    }
//                }
                
                
            }else {// 失败,弹框提示
                
                DDLog(@"%@",result.error);
                if (result.alertMsg) {
                    [DisplayHelper displayWarningAlert:result.alertMsg];
                    
                }else {
                    [DisplayHelper displayWarningAlert:@"请求成功,但没有数据哦!"];
                }
            }
        }else {
            
            [DisplayHelper displayWarningAlert:@"网络异常，请稍后再试!"];
        }
        
    };
    [[CMHTTPSessionManager sharedHttpSessionManager] sendHttpRequestParam:paramsModel];
}


#pragma mark - Setter & Getter

-(NSMutableArray *)payArr {
    if (!_payArr) {
        _payArr =[NSMutableArray array];
    }
    return _payArr;
}
-(UIButton *)yesPayBtn {
    if (!_yesPayBtn) {
        _yesPayBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_yesPayBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        _yesPayBtn.backgroundColor =kShopping_redColor;
        [_yesPayBtn addTarget:self action:@selector(yesPayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yesPayBtn;
}

-(FAPayKindSelectedView *)selectedTableView {
    if (!_selectedTableView) {
        _selectedTableView =[[FAPayKindSelectedView alloc]init];
    }
    return _selectedTableView;
}

@end
