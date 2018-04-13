import React, {Component} from 'react';
import {
    NativeModules,
    NativeAppEventEmitter
  } from 'react-native';
var SFPay = NativeModules.SFAlipay
/**
 * @param app_id 支付宝支付id
 * @param rsaPrivateKey 秘钥
 * @param appScheme  白名单标识
 * @param seller_id  销售ID
 * @param subject 产品名称
 * @param body 产品内容
 * @param body 产品价格
 **/
export default class SFAlipay extends React.Component{
    // 注册
    static configure=(appid,partnerId,appScheme,seller_id)=>{
        SFPay.configure({
            'appid':appid,
            'partnerId':partnerId,
            'appScheme':appScheme,
            'seller_id':seller_id,
        })
    }
    // 调取支付
    static Pay=(subject,body,total_amount,callback)=>{
        SFPay.pay({
            'subject':subject,
            'body':body,
            'total_amount':total_amount
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