import 'package:anime_app/app/services/youtube_convert_service.dart';
import 'package:get/get.dart';

class Youtube extends GetxController {
  final productList = [].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    var products = await YoutubeConvertService.convertLinkYoutube(
        'https://www.youtube.com/watch?v=oSlU4qXU3gY');
    if (products != null) {
      productList.assignAll(products);
    }
  }
}
