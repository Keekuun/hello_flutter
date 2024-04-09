import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageDemo extends StatelessWidget {
  const ImageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    const netWorkImg =
        'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg';
    const localeImg = 'assets/images/logo.webp';

    return Column(children: [
      const ListTile(title: Text('Image.asset-本地图片')),
      Image.asset(localeImg, width: 200),
      const SizedBox(height: 20),
      const Divider(
        height: 20,
      ),
      const ListTile(title: Text('FadeInImage.assetNetwork-淡入效果')),
      FadeInImage.assetNetwork(
        width: 250,
        placeholder: localeImg,
        // 占位符图片
        image: netWorkImg,
        // 要显示的图片
        imageErrorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey,
          );
        },
        fit: BoxFit.fitWidth,
      ),
      const SizedBox(height: 20),
      const Divider(
        height: 20,
      ),
      const ListTile(title: Text('Image.network-网络图片')),
      Image.network(
        netWorkImg,
        width: 400,
        height: 200,
      ),
      const SizedBox(height: 20),
      const Divider(
        height: 20,
      ),
      const ListTile(title: Text('DecorationImage-背景图片')),
      Container(
        width: 400,
        height: 200,
        decoration: const BoxDecoration(
          color: Colors.lightGreenAccent,
          // 背景图片
          image: DecorationImage(
            image: NetworkImage(netWorkImg),
            fit: BoxFit.contain,
          ),
          // 背景图片的模糊效果
          backgroundBlendMode: BlendMode.clear,
        ),
        child: const Center(
            child: Text('背景图片',
                style: TextStyle(color: Colors.blue, fontSize: 20))),
      ),
      const SizedBox(height: 20),
      const Divider(
        height: 20,
      ),
      const ListTile(title: Text('ExtendedImage-外部图片')),
      GestureDetector(
        onTap: () async {
          // 使用内部webView打开
          // await launchUrl(Uri.parse('https://github.com/fluttercandies/extended_image'),mode: LaunchMode.inAppWebView);
          // 使用外部浏览器打开
          await launchUrl(Uri.parse('https://github.com/fluttercandies/extended_image'), mode: LaunchMode.externalNonBrowserApplication);
        },
        child: const Text(
          '使用第三方库：extended_image',
          style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              decoration: TextDecoration.underline,
              decorationColor: Colors.red),
        ),
      ),
      ExtendedImage.network(
        netWorkImg,
        width: 200,
        height: 200,
        fit: BoxFit.fill,
        cache: true,
        border: Border.all(color: Colors.green, width: 2),
        shape: BoxShape.circle,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
      ),
      GestureDetector(
        onTap: () async {
          // 使用外部浏览器打开
          await launchUrl(
              Uri.parse('https://juejin.cn/post/7194239516709191740'),
              mode: LaunchMode.inAppWebView);
        },
        child: const Text(
          '快速掌握 Flutter 图片开发核心技能',
          style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              decoration: TextDecoration.underline),
        ),
      ),
    ]);
  }
}
