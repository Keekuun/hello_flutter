# hello_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Flutter third-party dependencies recommendations

+ flutter_bloc – this state management package handles the possible states
  of your application in a really easy way.

+ flutter_hooks – a Flutter implementation of React hooks.

+ freezed – a scalable code generator for data classes, unions, pattern-matching,
  and cloning.

+ flutter_launches_icons – a package that makes adding icons for all platforms
  take less than 5 minutes

+ flutter_native_splash – similar to the previous one, but it’s about the splash
  screen.

+ package_info_plus – a useful package that provides an API for querying
  information about an application package.

+ in_app_review – a package to show an adaptive review pop-up where users
  can leave a review for your application.


+ flutter_screenutil — a package for adapting screen and font size.
  animations – an effortless package for beautiful transition effects.
  equatable – a helpful package used to compare Dart objects

+ animations – an effortless package for beautiful transition effects.

+ equatable – a helpful package used to compare Dart objects.

## build apk

https://flutter-ko.dev/deployment/android

```
输入密钥库口令:  hello world
您的名字与姓氏是什么?
  [Chou]:  Chou
您的组织单位名称是什么?
  [XL]:  XL
您的组织名称是什么?
  [XL]:  XL
您所在的城市或区域名称是什么?
  [SZ]:  SZ
您所在的省/市/自治区名称是什么?
  [SZ]:  SZ
该单位的双字母国家/地区代码是什么?
  [HK]:  HK

```

`key.properties`

```
storePassword=hello world
keyPassword=hello world
keyAlias=upload
storeFile=C:\\flutter\\sign\\upload-keystore.jks
```

```bash
# 生成
keytool -genkey -v -keystore  C:\flutter\sign\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# 迁移
keytool -importkeystore -srckeystore C:\flutter\sign\upload-keystore.jks -destkeystore C:\flutter\sign\upload-keystore.jks -deststoretype pkcs12
```

```bash
flutter build apk

flutter build appbundle
```

## Flutter tools

+ https://dartj.web.app/

## learning

+ https://www.fullstackaction.com/pages/61cc74/
+ https://flutter.dev/learn
+ https://flutter.github.io/samples/web/animations/
+ https://github.com/flutter/codelabs
+ https://hussainmustafa.com/tutorials-source-code/

## favorites

+ https://fluttergems.dev/
+ https://pub.dev/packages
+ https://github.com/flutter/packages
+ https://github.com/flutter/flutter

## error to fix

+ irondash_engine_context - build failed

```
\hello_flutter\build\irondash_engine_context\build\build_tool"
Failed to decode data using encoding 'utf-8', path = '.\pubspec.yaml'
Error: Couldn't resolve the package 'build_tool' in 'package:build_tool/build_tool.dart'.
bin/build_tool_runner.dart:1:8: Error: Not found: 'package:build_tool/build_tool.dart'
import 'package:build_tool/build_tool.dart' as build_tool;
       ^
bin/build_tool_runner.dart:3:15: Error: Method not found: 'runMain'.
   build_tool.runMain(args);
              ^^^^^^^
Bad state: Generating kernel failed!
Could not find a command named "bin\build_tool_runner.dill".
```

+ shared_preferences - init error

```
SharedPreferences init error: PlatformException(channel-error, Unable to establish connection on channel: "dev.flutter.pigeon.shared_preferences_android.SharedPreferencesApi.getAll"., null, null)
```

+ share_plus - error

```
[ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: MissingPluginException(No implementation found for method share on channel dev.fluttercommunity.plus/share)
```