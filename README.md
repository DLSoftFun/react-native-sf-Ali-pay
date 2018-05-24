# react-native-sf-Ali-pay
# 安装
* npm  i react-native-sf-ali-pay
* react-native link react-native-sf-ali-pay
## IOS 端配置
### 支付宝SDK依赖的库
* https://img.alicdn.com/top/i1/LB1PlBHKpXXXXXoXXXXXXXXXXXX
* 以下文件需要手动添加到项目工程内:
* node_modules/react-native-sf-ali-pay/ios/SDK/AlipaySDK.bundle
* node_modules/react-native-sf-ali-pay/ios/SDK/AlipaySDK.framework (此文件也会自动添加到Link Binary With Libraries里)
* 在Build Settings中的Framework Search Paths中,增加:
* $(SRCROOT)/../node_modules/react-native-sf-ali-pay/ios
