import 'package:anime_app/app/bindings/home_anime_binding.dart';
import 'package:anime_app/app/bindings/home_binding.dart';
import 'package:anime_app/app/bindings/login_binding.dart';
import 'package:anime_app/app/ui/android/pages/home_anime.dart';
import 'package:anime_app/app/ui/android/pages/home_page.dart';
import 'package:anime_app/app/ui/android/pages/login_page.dart';
import 'package:anime_app/app/ui/android/pages/register_page.dart';
import 'package:anime_app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPage {
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.ANIMEPAGE,
      page: () => HomeAnime(),
      binding: HomeAnimeBinding(),
    ),
  ];
}
