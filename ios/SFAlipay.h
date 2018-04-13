//
//  SFAlipay.h
//  SFzfb
//
//  Created by LZW on 2018/4/11.
//  Copyright © 2018年 LZW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTBridgeModule.h>
@interface SFAlipay : NSObject<RCTBridgeModule>
@property (nonatomic,strong) RCTResponseSenderBlock callback;
@property (nonatomic,strong) NSString *app_id;
@property (nonatomic,strong) NSString *rsaPrivateKey;
@property (nonatomic,strong) NSString *appScheme;
@property (nonatomic,strong) NSString *seller_id;
@end
