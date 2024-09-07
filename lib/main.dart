import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hello_flutter/stores/store.dart';

import 'my_bloc.dart';
import 'routes.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
  Bloc.observer = MyBlocObserver();

  await Store.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.transparent,
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade200,
          onSurface: Colors.black,
          primary: Colors.redAccent,
          secondary: Colors.green,
          onPrimary: Colors.white,
        ),
        useMaterial3: true,
      ),
      routes: routes,
      builder: EasyLoading.init(),
    );
  }
}
