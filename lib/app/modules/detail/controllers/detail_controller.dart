import 'package:get/get.dart';

class DetailController extends GetxController {
  // ─── Reactive Variables ────────────────────────────────────────

  /// Data movie yang sedang ditampilkan (diterima via Get.arguments)
  final movie = Rxn<dynamic>(); // ganti dynamic → MovieModel kamu

  /// Status loading saat fetch detail movie
  final isLoading = false.obs;

  /// Status apakah movie ini sudah difavoritkan user
  final isFavorite = false.obs;

  // ─── Lifecycle ─────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    // Ambil data movie dari arguments saat navigasi
    if (Get.arguments != null) {
      movie.value = Get.arguments;
      fetchMovieDetail(movie.value?.id);
      checkIsFavorite();
    }
  }

  // ─── Methods ───────────────────────────────────────────────────

  /// Fetch detail lengkap movie dari TMDb (genres, runtime, dll)
  Future<void> fetchMovieDetail(int? id) async {
    if (id == null) return;
    // TODO: panggil API TMDb /movie/{id}
    // isLoading.value = true;
    // final result = await MovieService.getDetail(id);
    // movie.value = result;
    // isLoading.value = false;
  }

  /// Cek apakah movie ini sudah ada di favorit
  void checkIsFavorite() {
    // TODO: cek dari local storage / FavoriteController
    // final favController = Get.find<FavoriteController>();
    // isFavorite.value = favController.isFavorited(movie.value?.id);
  }

  /// Toggle simpan/hapus dari favorit
  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    // TODO: simpan perubahan ke FavoriteController / local storage
    // final favController = Get.find<FavoriteController>();
    // isFavorite.value
    //   ? favController.addFavorite(movie.value)
    //   : favController.removeFavorite(movie.value);
  }

  /// Buka trailer movie (YouTube / WebView)
  void watchTrailer() {
    // TODO: fetch video key dari TMDb /movie/{id}/videos lalu buka player
  }
}