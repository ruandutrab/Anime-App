import 'package:get/get.dart';
import 'package:anime_app/app/controller/home_anime_controller.dart';

class HomeAnimeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeAnimeController>(() => HomeAnimeController());
  }
}
