import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

// 假设这些辅助函数已经定义好
bool isImageBase64(String source) {
  // 检查字符串是否为Base64编码的图像
  try {
    final bytes = base64Decode(source);
    final image = img.decodeImage(bytes);
    return image != null;
  } catch (_) {
    return false;
  }
}

bool isHttpBasedUrl(String source) {
  // 检查字符串是否为HTTP/HTTPS URL
  return source.startsWith('http://') || source.startsWith('https://');
}

class ImageWidget extends StatelessWidget {
  final String imageSource;
  final String assetsPrefix;
  final double width;
  final double height;

  const ImageWidget({
    super.key,
    required this.imageSource,
    this.assetsPrefix = 'assets/images/',
    this.width = 200,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider getImageProvider() {
      if (isImageBase64(imageSource)) {
        return MemoryImage(base64.decode(imageSource));
      }

      if (isHttpBasedUrl(imageSource)) {
        return NetworkImage(imageSource);
      }

      if (imageSource.startsWith(assetsPrefix)) {
        return AssetImage(imageSource);
      }

      if (kIsWeb) {
        return NetworkImage(imageSource);
      }

      return FileImage(File(imageSource));
    }

    return Image(
      image: getImageProvider(),
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
