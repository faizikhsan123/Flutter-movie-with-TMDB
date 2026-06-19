import 'package:get/get.dart';
import '../views/login_view.dart';
import '../views/regis_view.dart';
import '../views/home_view.dart';
import '../views/detail_view.dart';
import '../views/cari_view.dart';
import '../views/favorite_view.dart';
import 'app_bindings.dart';

class AppRoutes {
  static const login = '/login';
  static const regis = '/regis';
  static const home = '/home';
  static const detail = '/detail';
  static const cari = '/cari';
  static const favorite = '/favorite';

  static final pages = [
    GetPage(
      name: login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: regis,
      page: () => const RegisView(),
      binding: RegisBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: detail,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: cari,
      page: () => const CariView(),
      binding: CariBinding(),
    ),
    GetPage(
      name: favorite,
      page: () => const FavoriteView(),
      binding: FavoriteBinding(),
    ),
  ];
}
