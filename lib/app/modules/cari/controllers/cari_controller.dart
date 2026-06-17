import 'package:get/get.dart';

class CariController extends GetxController {
  // ─── Reactive Variables ────────────────────────────────────────

  /// Text yang sedang diketik user di search bar
  final query = ''.obs;

  /// Hasil pencarian dari TMDb
  final searchResults = <dynamic>[].obs; // ganti dynamic → List<MovieModel>

  /// Loading state saat sedang fetch hasil search
  final isLoading = false.obs;

  // ─── Debounce helper ───────────────────────────────────────────
  Worker? _debounceWorker;

  // ─── Lifecycle ─────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    // Debounce: tunggu 500ms setelah user berhenti ngetik baru fetch
    _debounceWorker = debounce(
      query,
      (String value) {
        if (value.trim().isNotEmpty) {
          searchMovies(value.trim());
        } else {
          searchResults.clear();
        }
      },
      time: const Duration(milliseconds: 500),
    );
  }

  @override
  void onClose() {
    _debounceWorker?.dispose();
    super.onClose();
  }

  // ─── Methods ───────────────────────────────────────────────────

  /// Dipanggil setiap kali isi TextField berubah (onChanged)
  void onSearchChanged(String value) {
    query.value = value;
  }

  /// Reset search bar dan hasil
  void clearSearch() {
    query.value = '';
    searchResults.clear();
  }

  /// Fetch hasil pencarian dari TMDb /search/movie
  Future<void> searchMovies(String keyword) async {
    // TODO: panggil API TMDb /search/movie?query=keyword
    // isLoading.value = true;
    // final result = await MovieService.searchMovies(keyword);
    // searchResults.assignAll(result);
    // isLoading.value = false;
  }

  /// Toggle favorit dari halaman search
  void toggleFavorite(dynamic movie) {
    // TODO: panggil FavoriteController
    // final favController = Get.find<FavoriteController>();
    // favController.toggleFavorite(movie);
  }
}