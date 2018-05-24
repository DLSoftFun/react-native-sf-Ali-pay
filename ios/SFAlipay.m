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
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payScuss) name:@"payScuss" object:nil];
  }
  return self;
}
-(void)payScuss{
  _callback(@[[NSNull null],@"1"]);
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
