//
//  SFAlipay.m
//  SFzfb
//
//  Created by LZW on 2018/4/11.
//  Copyright © 2018年 LZW. All rights reserved.
//

#import "SFAlipay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APRSASigner.h"

@implementation SFAlipay
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE();

- (instancetype)init{
  if (self = [super init]) {
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payScuss) name:@"ORDER_PAY_NOTIFICATION" object:nil];
  }
  return self;
}
-(void)payScuss:(NSNotification *)notification{
    if ([notification.userInfo[@"respCode"]integerValue]==9000) {
        NSLog(@"支付成功");
        [self.bridge.eventDispatcher sendAppEventWithName:@"AliResp"
                                                     body:@{@"errCode ": @"9000",@"errMessage": @"支付成功"}];
    }else if([notification.userInfo[@"respCode"]integerValue]==6001){
        NSLog(@"用户中途取消");
        [self.bridge.eventDispatcher sendAppEventWithName:@"AliResp"
                                                     body:@{@"errCode ": @"6001",@"errMessage": @"用户中途取消"}];
    }else if([notification.userInfo[@"respCode"]integerValue]==6002){
        NSLog(@"网络连接出错");
        [self.bridge.eventDispatcher sendAppEventWithName:@"AliResp"
                                                     body:@{@"errCode ": @"6002",@"errMessage": @"网络连接错误"}];
    }else if([notification.userInfo[@"respCode"]integerValue]==4000){
        NSLog(@"支付订单失败");
        [self.bridge.eventDispatcher sendAppEventWithName:@"AliResp"
                                                     body:@{@"errCode ": @"4000",@"errMessage": @"支付订单失败"}];
    }
}
RCT_EXPORT_METHOD(registerApp:(NSDictionary*)dic){
  self.appScheme = [dic objectForKey:@"appScheme"];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
RCT_EXPORT_METHOD(pay:(NSDictionary *)property{
    _callback = callback;
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:[property objectForKey:@"orderInfo"] fromScheme:self.appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
}

  

@end
