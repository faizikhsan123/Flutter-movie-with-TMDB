import 'package:get/get.dart';

class HomeController extends GetxController {
  // ─── Reactive Variables ────────────────────────────────────────

  /// Movie yang ditampilkan di Featured Banner (Trending Now)
  final featuredMovie = Rxn<dynamic>(); // ganti dynamic → MovieModel kamu

  /// List film di section "Now Playing" (horizontal scroll)
  final nowPlayingMovies = <dynamic>[].obs; // ganti dynamic → List<MovieModel>

  /// List film di section "Popular" (grid 2 kolom)
  final popularMovies = <dynamic>[].obs; // ganti dynamic → List<MovieModel>

  /// Loading state untuk seluruh halaman
  final isLoading = false.obs;

  // ─── Lifecycle ─────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    fetchNowPlaying();
    fetchPopular();
  }

  // ─── Methods ───────────────────────────────────────────────────

  /// Fetch film "Now Playing" dari TMDb
  Future<void> fetchNowPlaying() async {
    // TODO: panggil API TMDb /movie/now_playing
    // isLoading.value = true;
    // final result = await MovieService.getNowPlaying();
    // nowPlayingMovies.assignAll(result);
    // featuredMovie.value = result.isNotEmpty ? result.first : null;
    // isLoading.value = false;
  }

  /// Fetch film "Popular" dari TMDb
  Future<void> fetchPopular() async {
    // TODO: panggil API TMDb /movie/popular
    // final result = await MovieService.getPopular();
    // popularMovies.assignAll(result);
  }

  /// Toggle simpan/hapus film ke favorit
  void toggleFavorite(dynamic movie) {
    // TODO: panggil FavoriteController atau service
    // final favController = Get.find<FavoriteController>();
    // favController.toggleFavorite(movie);
  }
}