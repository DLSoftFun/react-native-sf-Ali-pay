import React, {Component} from 'react';
import {
    NativeModules,
  } from 'react-native';
var SFPay = NativeModules.SFAliPay
// /**  
//  * @param orderInfo 服务器返回支付码
//  * @param appScheme  白名单标识
//  **/
export default class SFAlipay extends React.Component{
    // 注册
    static registerApp=(appScheme)=>{                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
        SFPay.registerApp({
            'appScheme':appScheme
        })
    }
    // 调取支付
    static Pay=(orderInfo)=>{
        SFPay.pay({
            'orderInfo':orderInfo,
        })
    }


}