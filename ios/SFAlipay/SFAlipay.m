//
//  SFAlipay.m
//  SFzfb
//
//  Created by LZW on 2018/4/11.
//  Copyright © 2018年 LZW. All rights reserved.
//

#import "SFAlipay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APOrderInfo.h"
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
RCT_EXPORT_METHOD(configure:(NSDictionary*)dic){
  self.app_id = [dic objectForKey:@"appid"];
  self.rsaPrivateKey = [dic objectForKey:@"partnerId"];
  self.appScheme = [dic objectForKey:@"appScheme"];
  self.seller_id = [dic objectForKey:@"seller_id"];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
RCT_EXPORT_METHOD(pay:(NSDictionary *)property callback:(RCTResponseSenderBlock)callback){
    _callback = callback;
    NSString * Rpid = self.app_id;
    NSString * RPrivateKey = self.rsaPrivateKey;
    NSString * RappScheme = self.appScheme;
    NSString * Rseller_id = self.seller_id;
    NSString * Rsubject = [property objectForKey:@"subject"];
    NSString * Rbody = [property objectForKey:@"body"];
    NSString * Rtotal_amount = [property objectForKey:@"total_amount"];
  
    NSString *appID = Rpid ;

    NSString *rsa2PrivateKey = RPrivateKey;
    NSString *rsaPrivateKey = RPrivateKey;
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];

    // NOTE: app_id设置
    order.app_id = appID;
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";

    // NOTE: 参数编码格式
    order.charset = @"utf-8";

    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];

    // NOTE: 支付版本
    order.version = @"1.0";

    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";

    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = Rbody;
    order.biz_content.subject = Rsubject;
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = Rtotal_amount; //商品价格
    order.biz_content.seller_id=Rseller_id;
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);

    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }

    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = RappScheme;

        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];


        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }

  
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
