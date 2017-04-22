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
    
    [self.view addSubview:self.selectedTableView];
    [self.view addSubview:self.yesPayBtn];
    
}
#pragma mark - Private Methods

-(void)initAllPayKindDatas {
    
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
                if (result.alertMsg) {
                    [DisplayHelper displaySuccessAlert:result.alertMsg];
                }else {
                    [DisplayHelper displaySuccessAlert:@"支付方式获得成功哦！"];
                }
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
    paramsModel.localHost =kTestHttpHost;
    paramsModel.appendUrl =kPay_topay;
    // 参数设置

    [paramsModel.paramDic setValue:@"e1370e6a9995a7010ded1596308acfc6" forKey:@"token"];
    [paramsModel.paramDic setValue:@"Z20170421114853LK8pc" forKey:@"orderid"];
    
    
    // 3.发送的网络请求
    
    if (self.selectedTableView.indexKind==0) {// 支付宝支付
        [paramsModel.paramDic setValue:@(3) forKey:@"paytype"];

    }else if (self.selectedTableView.indexKind==1) {// 微信支付
        [paramsModel.paramDic setValue:@(4) forKey:@"paytype"];

    }else {// 银联支付
        
    }
    [[CMWechatAliPayManager sharedWpayManager] sendWeChatAliPayRequestParam:paramsModel];
   
}


#pragma mark - CMWpaySearchResultDelegate
-(void)Wpay:(CMWechatAliPayManager *)manager andPayKind:(WAPayKind)payKind andPayResult:(int)code {
    DDLog(@"走到回调的地方了");
    if (payKind ==WAPayKindWechat) { // 微信
        switch (code) {
            case WXSuccess:
                
                // 1. 包装对应查询参数
                [DisplayHelper displaySuccessAlert:@"微信支付成功!"];
                // 2. 发送查询的是否成功的请求
                break;
                
            default:
                
                break;
        }
    }else { // 支付宝
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
