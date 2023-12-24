import 'package:get/get_navigation/src/routes/get_route.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/splash.dart';

class AppRoute {

  static const String splashscreen = "/splash_screen";
  static const String homeScreen = "/home_screen";


  static List<GetPage> route = [
    GetPage(name: splashscreen, page: () => const SplashScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
  ];
}
