import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:wallpaper_app/screens/category_screen.dart';
import 'package:wallpaper_app/screens/home_screen.dart';
import 'package:wallpaper_app/screens/full_screen_image.dart';
import 'package:wallpaper_app/screens/search_screen.dart';
import 'package:wallpaper_app/components/theme.dart';
import 'package:wallpaper_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: appThemes,
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => GetMaterialApp(
            enableLog: true,
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.themeOf(themeContext).data,
            initialRoute: '/splash',
            navigatorKey: Get.key,
            routingCallback: (route) {
              log("current route is ${route?.current.toString()}");
              // Fluttertoast.showToast(
              //     msg: "The current troute is ${route?.current.toString()}",
              //     toastLength: Toast.LENGTH_SHORT,
              //     gravity: ToastGravity.CENTER,
              //     timeInSecForIosWeb: 1,
              //     backgroundColor: Colors.red,
              //     textColor: Colors.white,
              //     fontSize: 16.0);
            },
            getPages: [
              GetPage(
                name: '/home',
                page: () => HomeScreen(),
              ),
              GetPage(
                name: '/splash',
                page: () => SplashScreen(),
              ),
              GetPage(
                name: '/image',
                page: () => FullScreenImage(),
              ),
              GetPage(
                name: '/search',
                page: () => SearchScreen(),
              ),
              GetPage(
                name: '/category',
                page: () => CategoryScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
