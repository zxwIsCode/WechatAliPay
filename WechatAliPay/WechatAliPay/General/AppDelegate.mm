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

#warning 记住导入分享的第三方头库
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
//
////腾讯开放平台（对应QQ和QQ空间）SDK头文件
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//
////微信SDK头文件
//#import "WXApi.h"
//
////新浪微博SDK头文件
//#import "WeiboSDK.h"


#define IsFirstLaunch @"CFBundleVersion"


#warning 记住遵循微信支付的第三方代理
//@interface AppDelegate ()<WXApiDelegate>
@interface AppDelegate ()



@end

@implementation AppDelegate

#pragma mark - UIApplication Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[UINavigationBar appearance]setBarTintColor:RGBCOLOR(129, 188, 53)];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window =[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self initRootViewController];
    [self.window makeKeyAndVisible];
#warning 记得调用初始化分享或支付SDK的代码
//    // 初始化ShareSDK
//    [self initSharedKey];
//        
//    // 初始化微信支付
//    [self initWpay];
    

    return YES;
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

#warning 记得初始化分享或支付SDK

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
//- (BOOL)application:(UIApplication *)application
//      handleOpenURL:(NSURL *)url
//{
//    return [WXApi handleOpenURL:url delegate:self];
//}
//
//
//-(BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation {
//    
//    return [WXApi handleOpenURL:url delegate:self];
//    
//}
//
//
//
//#pragma mark - 初始化微信支付
//- (void)initWpay
//{
//    [WXApi registerApp:@"wxe9beac44b65d4815" withDescription:@"com.zzdlwx.com"];
//}





@end
