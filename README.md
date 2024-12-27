# cochat
Flutter 1v1 母包，开发前请先执行shell目录下的脚本修改文件名前缀、类名前缀、资源文件hash，
详见/shell/README.md, 执行完成后再开始您的新包开发, 祝你生活愉快。

## 开发环境：Flutter & Dart
Flutter 3.24.5 • channel stable • https://github.com/flutter/flutter.git
Framework • revision dec2ee5c1f (2 weeks ago) • 2024-11-13 11:13:06 -0800
Engine • revision a18df97ca5
Tools • Dart 3.5.4 • DevTools 2.37.3

## main入口配置
- main_develop.dart为开发环境，支持切换API接口域名
- main_production.dart为生产环境，仅供打包上架使用，编译命令见文件底部
``` iOS:
{
    "name": "cochat",
    "request": "launch",
    "type": "dart",
    "program": "lib/main_develop.dart",
}
```
``` Android:
- develop使用测试包名，production使用线上包名
{
    "name": "cochat",
    "request": "launch",
    "type": "dart",
    "program": "lib/main_develop.dart",
    "args":[
        "--flavor",
        "develop"
    ]
}
```

## 测试登录账号
- 主播 
74879488@Nanas.com
9999

## 混淆
- 详见同目录shell文件夹
/shell/README.md
/shell/prefix.py
/shell/hash.py

## 解决iOS提包云信framework包函bitcode问题
- 手动剥离BitCode
``` shell 
#方法1: 编译归档前：
pod install
cd Pods/YXAlog/YXAlog_iOS.framework/ 
xcrun bitcode_strip -r YXAlog_iOS -o YXAlog_iOS

# 方法2: 归档后：
cd Runner.xcarchive/Products/Applications/Runner.app/Frameworks/YXAlog_iOS.framework
xcrun bitcode_strip -r YXAlog_iOS -o YXAlog_iOS
```

## 编译命令

- 生成代码
``` shell
flutter packages pub run build_runner build --delete-conflicting-outputs
```

- Android打包：APK测试包
```shell
flutter build apk --flavor develop -t lib/main_develop.dart --shrink --obfuscate --split-debug-info=./mapping
```

- Android打包：AAB测试包
```shell
flutter build appbundle --flavor develop -t lib/main_develop.dart
```

- 上架Android打包：AAB正式包
```shell
flutter build appbundle --flavor production -t lib/main_production.dart --shrink --obfuscate --split-debug-info=./mapping
```

- 上架iOS打包：IPA正式包
```shell
flutter clean
flutter build ipa --release --obfuscate --split-debug-info=./symbols  --target=lib/main_production.dart 

- 提审方法1: 
- cd /build/ios/archive
- 双击打开Runner.xcarchive，使用XCode提审

- 提审方法2:
- Mac App Store下载Transporter并登录开发者账号
- cd /build/ios/ipa
- 使用Transporter上传 "{AppName}.ipa"

```