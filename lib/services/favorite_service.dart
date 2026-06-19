import 'package:get_storage/get_storage.dart';
import '../models/movie_model.dart';
import 'storage_keys.dart';
import 'auth_service.dart';

class FavoriteService {
  final GetStorage _box = GetStorage();
  final AuthService _authService = AuthService();

  String _getFavoriteKey() {
    final user = _authService.getCurrentUser();
    final email = user?.email ?? 'guest';
    return '${StorageKeys.favorites}_$email';
  }

  List<MovieModel> getFavorites() {
    final List? raw = _box.read(_getFavoriteKey());
    if (raw == null) return [];
    return raw
        .map((e) => MovieModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> _saveFavorites(List<MovieModel> movies) async {
    final raw = movies.map((m) => m.toJson()).toList();
    await _box.write(_getFavoriteKey(), raw);
  }

  bool isFavorite(int movieId) {
    final favorites = getFavorites();
    return favorites.any((m) => m.id == movieId);
  }

  Future<void> addFavorite(MovieModel movie) async {
    final favorites = getFavorites();
    if (!favorites.any((m) => m.id == movie.id)) {
      favorites.add(movie);
      await _saveFavorites(favorites);
    }
  }

  Future<void> removeFavorite(int movieId) async {
    final favorites = getFavorites();
    favorites.removeWhere((m) => m.id == movieId);
    await _saveFavorites(favorites);
  }

  Future<void> toggleFavorite(MovieModel movie) async {
    if (isFavorite(movie.id)) {
      await removeFavorite(movie.id);
    } else {
      await addFavorite(movie);
    }
  }
}
