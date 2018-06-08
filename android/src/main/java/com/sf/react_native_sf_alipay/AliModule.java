package com.sf.react_native_sf_alipay;

import android.annotation.SuppressLint;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.widget.Toast;

import com.alipay.sdk.app.PayTask;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.util.Map;


/**
 * Created by Administrator on 2018-04-18.
 */

public class AliModule extends ReactContextBaseJavaModule {
    private static String APPID = "";
    public static String RSA2_PRIVATE = "";
    public static String RSA_PRIVATE = "";
    private static final int SDK_PAY_FLAG = 1;
    private Handler mHandler;
    public AliModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "SFAlipay";
    }
    @ReactMethod
    public void registerApp(ReadableMap appid) {

    }
    @SuppressLint("HandlerLeak")
    @ReactMethod
    public void pay(ReadableMap data){
//        if(data.hasKey("rsa_private")){
//            RSA_PRIVATE = data.getString("rsa_private");
//        }
//        if(data.hasKey("rsa2_private")){
//            RSA2_PRIVATE = data.getString("rsa2_private");
//        }
//        if (TextUtils.isEmpty(APPID) || (TextUtils.isEmpty(RSA2_PRIVATE) && TextUtils.isEmpty(RSA_PRIVATE))) {
//            new AlertDialog.Builder(getReactApplicationContext()).setTitle("警告").setMessage("需要配置APPID | RSA_PRIVATE")
//                    .setPositiveButton("确定", new DialogInterface.OnClickListener() {
//                        public void onClick(DialogInterface dialoginterface, int i) {
//                            //
//                            getCurrentActivity().finish();
//                        }
//                    }).show();
//            return;
//        }
//        boolean rsa2 = (RSA2_PRIVATE.length() > 0);
//        String total_amount = "";
//        String body = "";
//        String tradeNo = "";
//        String timestamp = "";
//        if(data.hasKey("total_amount")){
//            total_amount = data.getString("total_amount");
//        }else{
//            total_amount = "0.01";
//        }
//        if(data.hasKey("body")){
//            body = data.getString("body");
//        }else{
//            body = "测试";
//        }
//        if(data.hasKey("tradeNo")){
//            tradeNo = data.getString("tradeNo");
//        }else{
//            tradeNo = null;
//        }
//        if(data.hasKey("timestamp")){
//            timestamp = data.getString("timestamp");
//        }else{
//            timestamp = null;
//        }
//        Map<String, String> params = OrderInfoUtil2_0.buildOrderParamMap(APPID,total_amount,body,tradeNo,timestamp, rsa2);
//        String orderParam = OrderInfoUtil2_0.buildOrderParam(params);
//
//        String privateKey = rsa2 ? RSA2_PRIVATE : RSA_PRIVATE;
//        String sign = OrderInfoUtil2_0.getSign(params, privateKey, rsa2);
        mHandler = new Handler() {
            @SuppressWarnings("unused")
            public void handleMessage(Message msg) {
                switch (msg.what) {
                    case SDK_PAY_FLAG: {
                        @SuppressWarnings("unchecked")
                        PayResult payResult = new PayResult((Map<String, String>) msg.obj);
                        /**
                         对于支付结果，请商户依赖服务端的异步通知结果。同步通知结果，仅作为支付结束的通知。
                         */
                        String resultInfo = payResult.getResult();// 同步返回需要验证的信息
                        String resultStatus = payResult.getResultStatus();
                        // 判断resultStatus 为9000则代表支付成功
                        if (TextUtils.equals(resultStatus, "9000")) {
                            // 该笔订单是否真实支付成功，需要依赖服务端的异步通知。
                            Toast.makeText(getReactApplicationContext(), "支付成功", Toast.LENGTH_SHORT).show();
                            WritableMap map = Arguments.createMap();
                            map.putInt("errCode", 9000);
                            map.putString("errMessage", "支付成功");
                            getReactApplicationContext()
                                    .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                                    .emit("AliResp", map);
                        } else if(TextUtils.equals(resultStatus, "6001")){
                            // 该笔订单真实的支付结果，需要依赖服务端的异步通知。
                            Toast.makeText(getReactApplicationContext(), "用户中途取消", Toast.LENGTH_SHORT).show();
                            WritableMap map = Arguments.createMap();
                            map.putInt("errCode", 6001);
                            map.putString("errMessage", "用户中途取消");
                            getReactApplicationContext()
                                    .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                                    .emit("AliResp", map);

                        }else if(TextUtils.equals(resultStatus, "6002")){
                            // 该笔订单真实的支付结果，需要依赖服务端的异步通知。
                            Toast.makeText(getReactApplicationContext(), "网络连接错误", Toast.LENGTH_SHORT).show();
                            WritableMap map = Arguments.createMap();
                            map.putInt("errCode", 6002);
                            map.putString("errMessage", "网络连接错误");
                            getReactApplicationContext()
                                    .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                                    .emit("AliResp", map);

                        }else if(TextUtils.equals(resultStatus, "4000")){
                            // 该笔订单真实的支付结果，需要依赖服务端的异步通知。
                            Toast.makeText(getReactApplicationContext(), "支付订单失败", Toast.LENGTH_SHORT).show();
                            WritableMap map = Arguments.createMap();
                            map.putInt("errCode", 4000);
                            map.putString("errMessage", "支付订单失败");
                            getReactApplicationContext()
                                    .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                                    .emit("AliResp", map);
                        }else{
                            Toast.makeText(getReactApplicationContext(), "支付失败", Toast.LENGTH_SHORT).show();
                            WritableMap map = Arguments.createMap();
                            map.putInt("errCode", -100);
                            map.putString("errMessage", "支付失败");
                            getReactApplicationContext()
                                    .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                                    .emit("AliResp", map);

                        }
                        break;
                    }
                    default:
                        break;
                }
            };
        };
        final String orderInfo = data.getString("orderInfo");

        Runnable payRunnable = new Runnable() {

            @Override
            public void run() {
                PayTask alipay = new PayTask(getCurrentActivity());
                Map<String, String> result = alipay.payV2(orderInfo, true);
                Message msg = new Message();
                msg.what = SDK_PAY_FLAG;
                msg.obj = result;
                mHandler.sendMessage(msg);
            }
        };
        // 必须异步调用
        Thread payThread = new Thread(payRunnable);
        payThread.start();
    }
}
