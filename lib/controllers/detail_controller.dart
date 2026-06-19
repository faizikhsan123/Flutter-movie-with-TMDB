import 'package:get/get.dart';
import '../models/movie_model.dart';
import '../services/movie_service.dart';
import '../services/favorite_service.dart';

class DetailController extends GetxController {
  final MovieService _movieService = MovieService();
  final FavoriteService _favoriteService = FavoriteService();

  final movie = Rxn<MovieModel>();
  final isLoading = false.obs;
  final isFavorite = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is MovieModel) {
      movie.value = Get.arguments as MovieModel;
      isFavorite.value = _favoriteService.isFavorite(movie.value!.id);

      fetchMovieDetail(movie.value!.id);
    }
  }

  Future<void> fetchMovieDetail(int id) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _movieService.getMovieDetail(id);
      movie.value = result;
    } catch (e) {
      errorMessage.value = 'Failed to load movie detail.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite() async {
    if (movie.value == null) return;

    await _favoriteService.toggleFavorite(movie.value!);
    isFavorite.value = _favoriteService.isFavorite(movie.value!.id);
  }
}
