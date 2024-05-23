import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpDemo extends StatefulWidget {
  const HttpDemo({super.key});

  @override
  State<HttpDemo> createState() => _MyAppState();
}

// 定义一个 Post 类
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  // 将 JSON 数据转换为 Post 实例
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

// 定义一个 fetchPost() 方法
// 将HTTP响应转换为 Post 类实例
Future<Post> fetchPost([int id = 1]) async {
  const bool inProduction = bool.fromEnvironment("dart.vm.product");
  var url = kIsWeb == true || !inProduction
      ? 'http://localhost:5200/posts/$id'
      : 'https://jsonplaceholder.typicode.com/posts/$id';

  final response = await http
      // .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
      .get(Uri.parse(url));

  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

// 定义一个 MyApp 类
class _MyAppState extends State<HttpDemo> {
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
