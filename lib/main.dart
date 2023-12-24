import 'package:flutter/material.dart';
import 'package:lmbanglapatente/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
          ),
          initialRoute: AppRoute.splashscreen,
          getPages: AppRoute.route,
          title: 'LM Bangla Patente',
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
