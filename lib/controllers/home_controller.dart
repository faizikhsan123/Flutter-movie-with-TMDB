import 'package:get/get.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart';
import '../services/favorite_service.dart';

class HomeController extends GetxController {
  final MovieService _movieService = MovieService();
  final FavoriteService _favoriteService = FavoriteService();

  final featuredMovie = Rxn<MovieModel>();
  final nowPlayingMovies = <MovieModel>[].obs;
  final popularMovies = <MovieModel>[].obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllMovies();
  }

  Future<void> fetchAllMovies() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final results = await Future.wait([
        _movieService.getNowPlaying(),
        _movieService.getPopular(),
      ]);

      nowPlayingMovies.assignAll(results[0]);
      popularMovies.assignAll(results[1]);

      if (nowPlayingMovies.isNotEmpty) {
        featuredMovie.value = nowPlayingMovies.first;
      }
    } catch (e) {
      errorMessage.value = 'Failed to load movies. Check your connection.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshMovies() async {
    await fetchAllMovies();
  }

  Future<void> toggleFavorite(MovieModel movie) async {
    await _favoriteService.toggleFavorite(movie);

    nowPlayingMovies.refresh();
    popularMovies.refresh();
  }

  bool isFavorite(int movieId) {
    return _favoriteService.isFavorite(movieId);
  }
}
