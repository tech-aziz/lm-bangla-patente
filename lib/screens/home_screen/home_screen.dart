import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lmbanglapatente/global_widgets/custom_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../config/app_string.dart';
import '../../config/colors.dart';

class HomeScreen extends StatefulWidget {
  static String route = "/home_screen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WebViewController _controller = WebViewController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) => {
          print('URL loading progress $progress'),
        },
        onPageStarted: (url) => {
          EasyLoading.instance
          ..indicatorType = EasyLoadingIndicatorType.fadingCircle
          ..loadingStyle = EasyLoadingStyle.light,
          EasyLoading.show(status: 'Please wait!')
        },
        onPageFinished: (url) => {
          EasyLoading.dismiss(),
        },
      ))
      ..loadRequest(Uri.parse('https://lmbanglapatente.com/'));
  }

  @override
  Widget build(BuildContext context) {
    //user will exit or not
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                elevation: 10,
                contentPadding: const EdgeInsets.all(20.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                alignment: Alignment.center,
                content: Text(AppString.exitMessage,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.9)),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            exit(0);
                          },
                          child: customButton(
                            textColor: Colors.black,
                            btnName: 'Yes',
                            borderColor: AppColors.primary,
                            context: context,
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            Get.back();
                          },
                          child: customButton(
                              textColor: Colors.black,
                              btnName: 'No',
                              borderColor: AppColors.primary,
                              context: context),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ) ??
          false;
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: WillPopScope(
              onWillPop: () async {
                if (await _controller.canGoBack()) {
                  _controller.goBack();

                  return false;
                } else {
                  showExitPopup();
                  return true;
                }
              },
              child: WebViewWidget(
                controller: _controller,
              ))),
    );
  }
}
