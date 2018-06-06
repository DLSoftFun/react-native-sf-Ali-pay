import React, {Component} from 'react';
import {
    NativeModules,
    NativeAppEventEmitter
  } from 'react-native';
var SFPay = NativeModules.SFAlipay
// /**
//  * @param orderInfo 服务器返回支付码
//  * @param appScheme  白名单标识
//  **/
var nativeBridge = NativeModules.SFAlipay;//你的类名
const NativeModule = new NativeEventEmitter(nativeBridge);
export default class SFAlipay extends React.Component{
    // 注册
    static registerApp=(appScheme)=>{                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
        SFPay.registerApp({
            'appScheme':appScheme
        })
        this.subscription = NativeModule.addListener('AliResp',(data)=>this._getNotice(data));
    }
    // 调取支付
    static Pay=(orderInfo)=>{
        SFPay.pay({
            'orderInfo':orderInfo,
        })
    }


}