import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../controllers/regis_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/detail_controller.dart';
import '../controllers/cari_controller.dart';
import '../controllers/favorite_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class RegisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisController>(() => RegisController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());
  }
}

class CariBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CariController>(() => CariController());
  }
}

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(() => FavoriteController());
  }
}
