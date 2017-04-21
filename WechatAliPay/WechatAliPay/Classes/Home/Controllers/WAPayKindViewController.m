//
//  FAPayKindViewController.m
//  FarmAndAnimal
//
//  Created by 李保东 on 17/1/13.
//  Copyright © 2017年 DaviD. All rights reserved.
//

#import "WAPayKindViewController.h"
#import "WAPayKindModel.h"

#import "WAPayKindTableCell.h"

#import "WAPayKindSelectedView.h"

#import "CMWechatAliPayManager.h"

@interface WAPayKindViewController ()

//@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)WAPayKindSelectedView *selectedTableView;

@property(nonatomic,strong)NSMutableArray *payArr;

@property(nonatomic,strong)UIButton *yesPayBtn;

@property(nonatomic,strong)UILabel *rightLable;

// 那个平台是选中状态
@property(nonatomic,assign)NSInteger indexKind;

@end

@implementation WAPayKindViewController

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
                        WAPayKindModel *payKindModel =[[WAPayKindModel alloc]init];
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

-(void)yesPayBtnClick:(UIButton *)button {
    
    CMHttpRequestModel *paramsModel =[[CMHttpRequestModel alloc]init];
    // 1. 传递参数的准备
    if (self.selectedTableView.payArr.count >self.selectedTableView.indexKind) {
        WAPayKindModel *model = self.selectedTableView.payArr[self.selectedTableView.indexKind];
        
        DDLog(@"您点击了%@平台的确认支付",model.payKindStr);
        [paramsModel.paramDic setValue:model.payid forKey:@"payid"];
    }

    
    // 2.订单处理的参数包装：
    paramsModel.appendUrl =kCart_OrderPlaceOrder;
    // 用户收货地址id
    [paramsModel.paramDic setValue:@(4) forKey:@"addid"];

    [paramsModel.paramDic setValue:@(1) forKey:@"userid"];
    
    // 是否使用积分（ 1是 2不是）
    [paramsModel.paramDic setValue:@(2) forKey:@"isuseintl"];
        
    NSMutableDictionary *orderDic =[NSMutableDictionary dictionary];
    [orderDic setValue:@(3) forKey:@"goodsid"];
    [orderDic setValue:@(4) forKey:@"bid"];
    [orderDic setValue:@"测试" forKey:@"msg"];
    [orderDic setValue:@(1) forKey:@"way"];
    
    [orderDic setValue:@(0) forKey:@"jf"];
    [orderDic setValue:@(8) forKey:@"spid"];
    
    [orderDic setValue:@(1) forKey:@"gnum"];
    
    NSMutableDictionary *allSingleDic =[NSMutableDictionary dictionary];
    
    [allSingleDic setValue:orderDic forKey:@"order"];
    NSString *jsonStr =[NSString dictionaryToJsonString:allSingleDic];
    
    [paramsModel.paramDic setValue:jsonStr forKey:@"single"];
    
    // 3.发送的网络请求
    
    if (self.selectedTableView.indexKind==0) {// 支付宝支付
        [[CMWechatAliPayManager sharedWpayManager] sendWeChatAliPayRequestParam:paramsModel];
    }else if (self.selectedTableView.indexKind==1) {// 微信支付
        // 充值直接调微信充值
        CMHttpRequestModel *model =[[CMHttpRequestModel alloc]init];
        model.localHost = @"http://php.adwtp.com/index.php/";
        model.appendUrl = kSendTask_GetWechatPayParams;
        
        [model.paramDic setValue:@(1) forKey:@"userid"];
        [model.paramDic setValue:@(50) forKey:@"beanum"];

        
        
        model.callback = ^(CMHttpResponseModel * result, NSError *error) {
            if (result.state ==CMReponseCodeState_Success) {
                
            }else {
                [CMHttpStateTools showHtttpStateView:result.state];
                
            }
            
        };
        
        [[CMWechatAliPayManager sharedWpayManager] sendWeChatAliPayRequestParam:model];
    }else {// 银联支付
        
    }
   
   
}


#pragma mark - CMWpaySearchResultDelegate
-(void)Wpay:(CMWechatAliPayManager *)manager andPayKind:(WAPayKind)payKind andPayResult:(int)code {
    DDLog(@"走到回调的地方了");
    if (payKind ==WAPayKindWechat) {
        switch (code) {
            case WXSuccess:
                
                // 1. 包装对应查询参数
                [DisplayHelper displaySuccessAlert:@"微信支付成功!"];
                // 2. 发送查询的是否成功的请求
                break;
                
            default:
                
                break;
        }
    }else {
        switch (code) {
            case 9000:// 成功
                [DisplayHelper displaySuccessAlert:@"支付宝支付成功!"];

                break;
            case 6001:// 取消
                break;
            default:
                break;
        }
    }
    
   
}

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

-(WAPayKindSelectedView *)selectedTableView {
    if (!_selectedTableView) {
        _selectedTableView =[[WAPayKindSelectedView alloc]init];
    }
    return _selectedTableView;
}

@end
