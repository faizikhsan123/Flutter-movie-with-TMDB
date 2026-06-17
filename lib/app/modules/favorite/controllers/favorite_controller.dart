import 'package:get/get.dart';

class FavoriteController extends GetxController {
  // ─── Reactive Variables ────────────────────────────────────────

  /// List semua movie yang sudah difavoritkan user
  final favoriteMovies = <dynamic>[].obs; // ganti dynamic → List<MovieModel>

  // ─── Lifecycle ─────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  // ─── Methods ───────────────────────────────────────────────────

  /// Load data favorit dari local storage (SharedPreferences / GetStorage)
  Future<void> loadFavorites() async {
    // TODO: baca dari local storage
    // final stored = await LocalStorage.getFavorites();
    // favoriteMovies.assignAll(stored);
  }

  /// Cek apakah movie sudah difavoritkan berdasarkan id
  bool isFavorited(int? id) {
    return favoriteMovies.any((m) => m?.id == id);
  }

  /// Tambah movie ke favorit
  void addFavorite(dynamic movie) {
    if (!isFavorited(movie?.id)) {
      favoriteMovies.add(movie);
      saveFavorites();
    }
  }

  /// Hapus movie dari favorit (dipanggil dari tombol ❤️ di FavoriteView)
  void removeFavorite(dynamic movie) {
    favoriteMovies.removeWhere((m) => m?.id == movie?.id);
    saveFavorites();
  }

  /// Toggle: kalau sudah fav → hapus, belum fav → tambah
  void toggleFavorite(dynamic movie) {
    if (isFavorited(movie?.id)) {
      removeFavorite(movie);
    } else {
      addFavorite(movie);
    }
  }

  /// Simpan list favorit ke local storage
  Future<void> saveFavorites() async {
    // TODO: simpan ke local storage
    // await LocalStorage.saveFavorites(favoriteMovies);
  }
}