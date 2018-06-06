# react-native-sf-Ali-pay
# 安装
* npm  i react-native-sf-ali-pay
* react-native link react-native-sf-ali-pay
## IOS 端配置
### URL Schemes
* 配置白名单 URL Schemes (例如:RNGZFB):
### 支付宝SDK依赖的库
* https://img.alicdn.com/top/i1/LB1PlBHKpXXXXXoXXXXXXXXXXXX
* 以下文件需要手动添加到项目工程内(已存在则不需要手动添加):
* node_modules/react-native-sf-ali-pay/ios/SDK/AlipaySDK.bundle
* node_modules/react-native-sf-ali-pay/ios/SDK/AlipaySDK.framework (此文件也会自动添加到Link Binary With Libraries里)
* Build Phases 添加支付宝SDK node_modules/react-native-sf-ali-pay/ios/SDK/AlipaySDK
* 在Build Settings中的Framework Search Paths中,增加:
* $(SRCROOT)/../node_modules/react-native-sf-ali-pay/ios/SDK
## Android 端
* 1.0 .将alipaySdk-xxxxxxxx.jar包放入商户应用工程的libs目录下
* 1.1 进入商户应用工程的“Project Structure”，在app module下选择“File dependency”，将libs目录下的alipaySDK-xxxxxxxx.jar导入
* 1.2 或者在app module下的build.gradle下手动添加依赖，如下代码所示：
```
dependencies {
......
compile files('libs/alipaySdk-20170725.jar')
......
}
```
* 2.0 修改Manifest
* 2.1 在商户应用工程的AndroidManifest.xml文件里面添加声明：
```
<!--权限-->
<activity
android:name="com.alipay.sdk.app.H5PayActivity"
android:configChanges="orientation|keyboardHidden|navigation|screenSize"
android:exported="false"
android:screenOrientation="behind"
android:windowSoftInputMode="adjustResize|stateHidden" >
</activity>
<activity
android:name="com.alipay.sdk.app.H5AuthActivity"
android:configChanges="orientation|keyboardHidden|navigation"
android:exported="false"
android:screenOrientation="behind"
android:windowSoftInputMode="adjustResize|stateHidden" >
</activity>
```
* 2.11和权限声明
```
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```
* 3.0 添加混淆规则
* 3.01 在商户应用工程的proguard-project.txt里添加以下相关规则：
```
-keep class com.alipay.android.app.IAlixPay{*;}
-keep class com.alipay.android.app.IAlixPay$Stub{*;}
-keep class com.alipay.android.app.IRemoteServiceCallback{*;}
-keep class com.alipay.android.app.IRemoteServiceCallback$Stub{*;}
-keep class com.alipay.sdk.app.PayTask{ public *;}
-keep class com.alipay.sdk.app.AuthTask{ public *;}
-keep class com.alipay.sdk.app.H5PayCallback {
<fields>;
<methods>;
}
-keep class com.alipay.android.phone.mrpc.core.** { *; }
-keep class com.alipay.apmobilesecuritysdk.** { *; }
-keep class com.alipay.mobile.framework.service.annotation.** { *; }
-keep class com.alipay.mobilesecuritysdk.face.** { *; }
-keep class com.alipay.tscenter.biz.rpc.** { *; }
-keep class org.json.alipay.** { *; }
-keep class com.alipay.tscenter.** { *; }
-keep class com.ta.utdid2.** { *;}
-keep class com.ut.device.** { *;}
```
 ## IOS Appdelegate 添加监听
 ```
 // NOTE: 9.0以后使用新API接口
 - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
 {
 if ([url.host isEqualToString:@"safepay"]) {
 // 支付跳转支付宝钱包进行支付，处理支付结果
 [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
 //
 NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",[[resultDic objectForKey:@"resultStatus"] intValue]],@"respCode",nil];
 NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:nil userInfo:dic];
 [[NSNotificationCenter defaultCenter] postNotification:notification];
 
 }];
 }
 return YES;
 }
 
 
 - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 {
 if ([url.host isEqualToString:@"safepay"]) {
 // 支付跳转支付宝钱包进行支付，处理支付结果
 [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
 NSDictionary * dic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%d",[[resultDic objectForKey:@"resultStatus"] intValue]],@"respCode",nil];
 NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:nil userInfo:dic];
 [[NSNotificationCenter defaultCenter] postNotification:notification];
 
 }];
 
 }
 return YES;
 }
 
 ```
  ## react 添加监听方法
  ```
  import { NativeAppEventEmitter } from 'react-native';
  NativeAppEventEmitter.addListener(
  'AliResp',
  (content) => {
  //数据内容
  }
  }
  );
  this.listener && this.listener.remove();
  
  回调中errCode值列表：
 errCode     errMessage
  名称       描述
 9000       成功
 6001       中途退出
 6002       网络连接错误
 4000       支付订单失败
  
 ```
# Methods
|  Methods  |  Params  |  Param Types  |   description  |  Example  |
|:-----|:-----|:-----|:-----|:-----|
|registerApp|string|string|支付宝IOS白名单|SFAlipay.registerApp('IOS白名单标识')|
|Pay|dictionary|dictionary|需要传递的参数|SFAlipay.Pay('服务端获取支付字符串',()=>{'支付成功回调'})|
