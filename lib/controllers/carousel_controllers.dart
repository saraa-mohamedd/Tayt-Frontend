import 'package:get/get.dart';

class CustomCarouselController extends GetxController {
  final currentIndex = 0.obs;

  static CustomCarouselController get instance => Get.find();

  void updateIndex(index) => currentIndex.value = index;
}

class RecommendedCarouselController extends GetxController {
  final currentIndex = 0.obs;

  static RecommendedCarouselController get instance => Get.find();

  void updateIndex(index) => currentIndex.value = index;
}
