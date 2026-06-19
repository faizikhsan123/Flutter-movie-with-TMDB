import 'package:get/get.dart';
import '../models/movie_model.dart';
import '../services/favorite_service.dart';

class FavoriteController extends GetxController {
  final FavoriteService _favoriteService = FavoriteService();

  final favoriteMovies = <MovieModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  @override
  void onReady() {
    super.onReady();
    loadFavorites();
  }

  void loadFavorites() {
    final stored = _favoriteService.getFavorites();
    favoriteMovies.assignAll(stored);
  }

  Future<void> removeFavorite(MovieModel movie) async {
    await _favoriteService.removeFavorite(movie.id);
    favoriteMovies.removeWhere((m) => m.id == movie.id);
  }
}
