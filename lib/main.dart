// ignore_for_file: empty_catches, depend_on_referenced_packages

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopshy/Bloc/Login/Login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopshy/Repository/Login_repository.dart';
import 'package:shopshy/Screens/HomeScreen.dart';
import 'package:shopshy/Screens/LoginScreen.dart';
import 'package:shopshy/Screens/Splashscreen.dart';

void main() {
  final LoginRepository authRepository = LoginRepository();
  runApp(MyApp(authRepository: authRepository));
}

late Widget? showFirstScreen;

class MyApp extends StatefulWidget {
  final LoginRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getInitialScreen().whenComplete(() => setState(() {
          isFirstLoad = false;
        }));
  }

  bool isFirstLoad = true;

  Future<void> getInitialScreen() async {
    String? userToken = '';

    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      userToken = preferences.getString('userToken') ?? '';
    } catch (e) {
      print("Error${e}");
    }

    showFirstScreen = userToken!.isNotEmpty ? HomePage() : LoginPage();
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () async {
      String? userToken = '';
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        userToken = preferences.getString('userToken') ?? '';
      } catch (e) {
        print("Error${e}");
      }

      showFirstScreen = userToken!.isNotEmpty ? HomePage() : LoginPage();
    });
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
            )),
        title: 'shopshy',
        home: BlocProvider(
          create: (context) => LoginBloc(authRepository: widget.authRepository),
          child: isFirstLoad ? SplashScreen() : showFirstScreen,
        ));
  }
}
