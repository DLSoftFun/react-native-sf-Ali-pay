import React, {Component} from 'react';
import {
    NativeModules,
    NativeAppEventEmitter
  } from 'react-native';
var SFPay = NativeModules.SFAlipay
// /**
//  * @param app_id 支付宝支付id
//  * @param rsaPrivateKey 秘钥
//  * @param appScheme  白名单标识
//  * @param seller_id  销售ID
//  * @param subject 产品名称
//  * @param body 产品内容
//  * @param body 产品价格
//  **/
export default class SFAlipay extends React.Component{
    // 注册
    static configure=(appScheme)=>{                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
        SFPay.configure({
            'appScheme':appScheme
        })
    }
    // 调取支付
    static Pay=(orderInfo,callback)=>{
        SFPay.pay({
            'orderInfo':orderInfo,
        },(error,events)=>{
            if(error){
                console.error(error);
            }else{
                if(events==0){
                }else {
                    if(callback){
                        callback()
                    }
                }
            }
        })
    }


}