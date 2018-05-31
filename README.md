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
* 1.0 将支付宝demo里面的alipaySdk-20160223.jar拷贝到我们工程的libs下，并添加到依赖中
* 2.0 配置
```
<!--权限-->

<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<!-- activity配置 -->

<activity
android:name="com.alipay.sdk.app.H5PayActivity"
android:configChanges="orientation|keyboardHidden|navigation"
android:exported="false"
android:screenOrientation="behind">
</activity>
<activity
android:name="com.alipay.sdk.auth.AuthActivity"
android:configChanges="orientation|keyboardHidden|navigation"
android:exported="false"
android:screenOrientation="behind">
</activity>
```
# Methods
|  Methods  |  Params  |  Param Types  |   description  |  Example  |
|:-----|:-----|:-----|:-----|:-----|
|registerApp|string|string|支付宝IOS白名单|SFAlipay.registerApp('IOS白名单标识')|
|Pay|dictionary|dictionary|需要传递的参数|SFAlipay.Pay('服务端获取支付字符串',()=>{'支付成功回调'})|
