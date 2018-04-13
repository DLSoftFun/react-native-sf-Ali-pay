/**
 * Copyright (c) 2015-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"
#import "SFAlipayVc.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <AlipaySDK/AlipaySDK.h>


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSURL *jsCodeLocation;

  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];

  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                      moduleName:@"SFAlipay"
                                               initialProperties:nil
                                                   launchOptions:launchOptions];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  
  
  SFAlipayVc * SF = [SFAlipayVc new];
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
  if ([url.host isEqualToString:@"safepay"]) {
    // 支付跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
      if ([[resultDic objectForKey:@"resultStatus"] intValue]==9000) {
        NSLog(@"支付成功");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"payScuss" object:nil];
      }else if([[resultDic objectForKey:@"resultStatus"] intValue]==6001){
        NSLog(@"用户中途取消");
      }else if([[resultDic objectForKey:@"resultStatus"] intValue]==6002){
        NSLog(@"网络连接出错");
      }else if([[resultDic objectForKey:@"resultStatus"] intValue]==4000){
        NSLog(@"支付订单失败");
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
  return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
  if ([url.host isEqualToString:@"safepay"]) {
    // 支付跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
      if ([[resultDic objectForKey:@"resultStatus"] intValue]==9000) {
        NSLog(@"支付成功");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"payScuss" object:nil];
      }else if([[resultDic objectForKey:@"resultStatus"] intValue]==6001){
        NSLog(@"用户中途取消");
      }else if([[resultDic objectForKey:@"resultStatus"] intValue]==6002){
        NSLog(@"网络连接出错");
      }else if([[resultDic objectForKey:@"resultStatus"] intValue]==4000){
        NSLog(@"支付订单失败");
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
  return YES;
}

@end
