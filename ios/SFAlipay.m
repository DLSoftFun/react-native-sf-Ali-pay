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
                                                     body:@{@"errCode ": @"支付成功",@"errMessage": @"9000"}];
    }else if([notification.userInfo[@"respCode"]integerValue]==6001){
        NSLog(@"用户中途取消");
        [self.bridge.eventDispatcher sendAppEventWithName:@"AliResp"
                                                     body:@{@"errCode ": @"用户中途取消",@"errMessage": @"6001"}];
    }else if([notification.userInfo[@"respCode"]integerValue]==6002){
        NSLog(@"网络连接出错");
        [self.bridge.eventDispatcher sendAppEventWithName:@"AliResp"
                                                     body:@{@"errCode ": @"网络连接错误",@"errMessage": @"6002"}];
    }else if([notification.userInfo[@"respCode"]integerValue]==4000){
        NSLog(@"支付订单失败");
        [self.bridge.eventDispatcher sendAppEventWithName:@"AliResp"
                                                     body:@{@"errCode ": @"支付订单失败",@"errMessage": @"4000"}];
    }
}
RCT_EXPORT_METHOD(registerApp:(NSDictionary*)dic){
  self.appScheme = [dic objectForKey:@"appScheme"];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
RCT_EXPORT_METHOD(pay:(NSDictionary *)property callback:(RCTResponseSenderBlock)callback){
    _callback = callback;
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:[property objectForKey:@"orderInfo"] fromScheme:self.appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
}

  

#pragma mark   ==============产生随机订单号==============

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
@end
