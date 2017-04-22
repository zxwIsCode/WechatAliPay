//
//  AppDelegate.m
//  ComeMoneyHere
//
//  Created by 李保东 on 16/11/14.
//  Copyright © 2016年 李保东. All rights reserved.
//

#import "AppDelegate.h"
#import "CMMainTabBarViewController.h"
#import "CMNewFetureViewController.h"

//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
//
////腾讯开放平台（对应QQ和QQ空间）SDK头文件
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>


// 微信SDK头文件
#import "WXApi.h"
// 支付宝SDK
#import  <AlipaySDK/AlipaySDK.h>

////新浪微博SDK头文件
//#import "WeiboSDK.h"


#define IsFirstLaunch @"CFBundleVersion"

@interface AppDelegate ()<WXApiDelegate>


@end

@implementation AppDelegate

#pragma mark - UIApplication Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[UINavigationBar appearance]setBarTintColor:RGBCOLOR(129, 188, 53)];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window =[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self initRootViewController];
    [self.window makeKeyAndVisible];

//    // 初始化ShareSDK
//    [self initSharedKey];
//

    // 初始化微信支付
    [self initWpay];
    

    return YES;
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            NSString *resultStatus = resultDic[@"resultStatus"];
            switch (resultStatus.integerValue) {
                case 9000:// 成功
                    break;
                case 6001:// 取消
                    break;
                default:
                    break;
            }
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return [WXApi handleOpenURL:url delegate:self];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - Private Methods
- (void)initRootViewController
{
//    CMNewFetureViewController *newFeture =[[CMNewFetureViewController alloc]init];
//    [self.window setRootViewController:newFeture];
    // 获得最后一次保存的版本号
    NSString *lastVersion =  [CMUserDefaults getFromLocalString:IsFirstLaunch];
    // 获得当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[IsFirstLaunch];
    
    if (![lastVersion isEqualToString:currentVersion]) {
        
        CMNewFetureViewController *newFeture =[[CMNewFetureViewController alloc]init];
        [self.window setRootViewController:newFeture];
        // 保存新的版本号
        [CMUserDefaults saveLocalString:currentVersion andKey:IsFirstLaunch];
    }
    else
    {
        self.window.rootViewController =[[CMMainTabBarViewController alloc]init];
    }
}

//- (void)initSharedKey
//{
//    /**
//     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
//     *  在将生成的AppKey传入到此方法中。
//     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
//     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
//     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
//     */
//    [ShareSDK registerApp:@"191d8fe07c604"
//     
//          activePlatforms:@[
//                            @(SSDKPlatformTypeWechat),
//                            @(SSDKPlatformTypeQQ),
//                            @(SSDKPlatformTypeSinaWeibo)]
//                 onImport:^(SSDKPlatformType platformType)
//     {
//         switch (platformType)
//         {
//             case SSDKPlatformTypeWechat:
//                 [ShareSDKConnector connectWeChat:[WXApi class]];
//                 break;
//             case SSDKPlatformTypeQQ:
//                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                 break;
//             case SSDKPlatformTypeSinaWeibo:
//                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                 break;
//             default:
//                 break;
//         }
//     }
//          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
//     {
//         switch (platformType)
//         {
//             case SSDKPlatformTypeSinaWeibo://暂未申请（无法申请）
//                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
//                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                                         redirectUri:@"http://www.zzdlwx.com"
//                                            authType:SSDKAuthTypeBoth];
//                 break;
//
//             case SSDKPlatformTypeWechat:
//                 [appInfo SSDKSetupWeChatByAppId:@"wx685a5f98e4497044"
//                                       appSecret:@"d4accb5f0fdd93ea8c63144d7f06dc91"];
//                 break;
//             case SSDKPlatformTypeQQ:
//                 [appInfo SSDKSetupQQByAppId:@"1105825782"
//                                      appKey:@"NgJBRCXRqEitVdar"
//                                    authType:SSDKAuthTypeBoth];
//                 break;
//
//             default:
//                 break;
//         }
//
//     }];
//}




#pragma mark - 初始化微信支付
- (void)initWpay
{
    #warning 记得更改微信Appid为您的
    [WXApi registerApp:@"wx685a5f98e4497044" withDescription:@"com.zzdlwx.com"];
}





@end
