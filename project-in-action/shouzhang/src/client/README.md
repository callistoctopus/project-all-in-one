<!--
 * @Author: gui-qi
 * @Date: 2022-10-29 03:31:37
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-11-28 10:41:55
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
-->
# client

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


flutter/packages/flutter_tools/lib/src/http_host_validator.dart
(1) 修改https://maven.google.com/为 google maven 的国内镜像http://maven.aliyun.com/repository/google/
(2) kPubDevHttpHost 改为 http://pub.flutter-io.cn/
(3) kgCloudHttpHost 改为 http://storage.flutter-io.cn/
(4) 进入到flutter\bin目录，删除cache目录下的flutter_tools.snapshot 文件
(5) 在终端输入flutter doctor

export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

fultter create client
flutter build web --base-href=/web/
docker run -itd \
     --rm \
     -p 80:8080 \
     -v /var/work/git/projects/project-in-action/shouzhang/src/client/build/web:/usr/local/tomcat/webapps/web \
     --name tomcat9 \
     tomcat:9.0

flutter pub add english_words
flutter pub add iconsax

flutter pub add intl
flutter pub add http
flutter pub add uuid
flutter pub add go_router
flutter pub add provider

flutter pub add hive
flutter pub add hive_flutter
flutter pub add json_annotation
flutter pub add fl_chart
flutter pub add syncfusion_flutter_charts
flutter pub add syncfusion_flutter_gauges
flutter pub add percent_indicator

flutter pub add hive_generator --dev
flutter pub add build_runner --dev
flutter pub add json_serializable --dev

flutter packages pub run build_runner build --delete-conflicting-outputs

flutter upgrade --force

flutter pub get

# 待做
// 输入密码时不可见
// 设置自动扣费
// 自动生成预算
// 年度选择使用下拉框
// 设置背景图
// 消费结构分析：食品烟酒，衣着消费，居住，生活用品及服务，交通通信，教育文化娱乐，医疗保健，其他用品及服务
// 日别，月别，周别，年别，消费分析，建议，警告 
// 日别，月别，周别，年别，预算分析，建议，警告
// 资产管理，资产类型，盘账
// 消费目标，预计达成时间
// 预算，周期，年度
// 会员

# 已做