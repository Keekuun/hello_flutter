import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_proxy/shelf_proxy.dart';

//本地域名
const String localHost = 'localhost';

//本地端口
const int localPort = 5200;

//目标域名
const String targetUrl = 'https://jsonplaceholder.typicode.com';

Future main() async {
  var server = await shelf_io.serve(
    proxyHandler(targetUrl),
    localHost,
    localPort,
  );
  // 添加上跨域的这几个header
  server.defaultResponseHeaders.add('Access-Control-Allow-Origin', '*');
  server.defaultResponseHeaders.add('Access-Control-Allow-Credentials', true);

  print('Serving at http://${server.address.host}:${server.port}');
}
