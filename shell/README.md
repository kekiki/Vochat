
# 快捷修改工具
主要就是修改文件名前缀、类名前缀、资源文件hash值

## prefix.py
修改文件名前缀、类名前缀

``` shell
sudo python3 prefix.py
```

### prefix eg:
sudo python3 /Users/mac/Desktop/vochat/shell/prefix.py
请输入项目绝对路径: /Users/mac/Desktop/vochat 
请输入旧文件前缀: vochat
请输入新文件前缀: manda

start ...
/Users/mac/Desktop/vochat/lib/home/vochat_home_page.dart ------> /Users/mac/Desktop/vochat/lib/home/manda_home_page.dart
/Users/mac/Desktop/vochat/lib/splash/vochat_splash_controller.dart ------> /Users/mac/Desktop/vochat/lib/splash/manda_splash_controller.dart
........

end ...


## hash.py
修改资源文件hash

``` shell
sudo python3 hash.py
```

### hash eg:
sudo python3 /Users/mac/Desktop/vochat/shell/hash.py
请输入项目绝对路径: /Users/mac/Desktop/vochat 

start ...
/Users/mac/Desktop/vochat/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_16.png ... 完成
/Users/mac/Desktop/vochat/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_1024.png ... 完成
/Users/mac/Desktop/vochat/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_256.png ... 完成
/Users/mac/Desktop/vochat/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_64.png ... 完成
/Users/mac/Desktop/vochat/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_512.png ... 完成
/Users/mac/Desktop/vochat/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_128.png ... 完成
/Users/mac/Desktop/vochat/macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_32.png ... 完成
........

end ...