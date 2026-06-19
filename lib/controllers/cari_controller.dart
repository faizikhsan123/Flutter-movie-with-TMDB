import 'package:get/get.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart';
import '../services/favorite_service.dart';

class CariController extends GetxController {
  final MovieService _movieService = MovieService();
  final FavoriteService _favoriteService = FavoriteService();

  final query = ''.obs;
  final searchResults = <MovieModel>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Worker? _debounceWorker;

  @override
  void onInit() {
    super.onInit();

    _debounceWorker = debounce(query, (String value) {
      if (value.trim().isNotEmpty) {
        searchMovies(value.trim());
      } else {
        searchResults.clear();
      }
    }, time: const Duration(milliseconds: 500));
  }

  @override
  void onClose() {
    _debounceWorker?.dispose();
    super.onClose();
  }

  void onSearchChanged(String value) {
    query.value = value;
  }

  void clearSearch() {
    query.value = '';
    searchResults.clear();
  }

  Future<void> searchMovies(String keyword) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final results = await _movieService.searchMovies(keyword);
      searchResults.assignAll(results);
    } catch (e) {
      errorMessage.value = 'Failed to search movies.';
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite(MovieModel movie) async {
    await _favoriteService.toggleFavorite(movie);
    searchResults.refresh();
  }

  bool isFavorite(int movieId) {
    return _favoriteService.isFavorite(movieId);
  }
}
