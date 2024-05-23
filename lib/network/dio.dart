import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import './http.dart';

Dio initDio() {
  final dio = Dio();

  // 添加拦截器
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // 在请求发送前添加逻辑
      // 例如，添加一个自定义的请求头
      options.headers["Custom-Header"] = "custom-header";
      options.headers["Authorization"] = "Bearer 123456";
      // 继续执行请求
      return handler.next(options);
    },
    onResponse: (response, handler) {
      // 在响应返回后添加逻辑
      // 例如，打印响应数据
      print(response.data);
      // 继续执行响应
      return handler.next(response);
    },
    onError: (DioException e, handler) {
      // 在发生错误时添加逻辑
      // 例如，根据错误类型显示不同的错误信息
      print(e.message);
      // 继续执行错误处理
      return handler.next(e);
    },
  ));

  return dio;
}

final dio = initDio();

class DioDemo extends StatefulWidget {
  const DioDemo({super.key});

  @override
  State<DioDemo> createState() => _MyAppState();
}

getDemo() async {
  try {
    Response response = await dio.get('/todos',
        queryParameters: {
          'page': 1,
          'limit': 10,
          'status': 'completed',
          'title': 'foo',
          'userId': 1,
          'tags': ['foo', 'bar'],
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer 1234567890',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'X-Custom-Header': 'foo',
          },
        ));
    print(response);
  } on DioException catch (e) {
    print(e.message);
  }
}

postDemo() async {
  try {
    Response response = await dio.post('/todos',
        data: {
          'page': 1,
          'limit': 10,
          'status': 'completed',
          'title': 'foo',
          'userId': 1,
          'tags': ['foo', 'bar'],
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer 1234567890',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'X-Custom-Header': 'foo',
          },
        ));
    print(response);
  } on DioException catch (e) {
    print(e.message);
  }
}

handleErrorDemo() async {
  try {
    Response response = await dio.get("/user?id=123");
  } on DioException catch (e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        // 连接超时处理
        print('连接超时');
        break;
      case DioExceptionType.sendTimeout:
        // 发送超时处理
        print('发送超时');
        break;
      case DioExceptionType.receiveTimeout:
        // 接收超时处理
        print('接收超时');
        break;
      case DioExceptionType.badResponse:
        // 服务器响应错误处理
        print('服务器响应错误，状态码：${e.response?.statusCode}');
        break;
      case DioExceptionType.cancel:
        // 请求取消处理
        print('请求被取消');
        break;
      case DioExceptionType.connectionError:
        // 连接错误处理
        print('连接错误');
        break;
      case DioExceptionType.unknown:
      default:
        // 其他错误处理
        print('未知错误');
        break;
    }
  }
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
