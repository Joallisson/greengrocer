import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/views/sign_in_screen.dart';
import 'package:greengrocer/src/pages/auth/views/sign_up_screen.dart';
import 'package:greengrocer/src/pages/base/base_screen.dart';
import 'package:greengrocer/src/pages/base/binding/navigation_binding.dart';
import 'package:greengrocer/src/pages/cart/binding/cart_binding.dart';
import 'package:greengrocer/src/pages/home/binding/home_binding.dart';
import 'package:greengrocer/src/pages/splash/splash_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: PagesRoutes.signInRoute,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: PagesRoutes.signUpRoute,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: PagesRoutes.baseRoute,
      page: () => const BaseScreen(),
      bindings: [
        NavigationBinding(),
        HomeBinding(),
        CartBinding(),
      ]
    ),
  ];
}

abstract class PagesRoutes{
  static const signInRoute = '/signin';
  static const signUpRoute = '/signup';
  static const splashRoute = '/splash';
  static const baseRoute = '/';
}
