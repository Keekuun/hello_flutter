import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import './http.dart';

final dio = Dio();

class DioDemo extends StatefulWidget {
  const DioDemo({super.key});

  @override
  State<DioDemo> createState() => _MyAppState();
}

// 定义一个 fetchPost() 方法
// 将HTTP响应转换为 Post 类实例
Future<Post> fetchPost([int id = 1]) async {
  final response = await dio.get('http://localhost:5200/posts/$id');

  if (response.statusCode == 200) {
    return Post.fromJson(response.data);
  } else {
    throw Exception('Failed to load post');
  }
}

// 定义一个 MyApp 类
class _MyAppState extends State<DioDemo> {
  late Future<Post> post;
  int id = 1;

  @override
  void initState() {
    super.initState();
    post = fetchPost(id); // called inside initState()
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<Post>(
            future: post, // 调用 fetchPost() 方法
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data!.title,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            // SystemChannels.textInput
                            //     .invokeMethod('TextInput.show');
                            setState(() {
                              post = fetchPost(id++);
                            });
                          },
                          child: const Icon(
                            Icons.navigate_next,
                            size: 30,
                          ))
                    ]);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            }));
  }
}
