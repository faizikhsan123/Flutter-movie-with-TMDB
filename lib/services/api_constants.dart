class ApiConstants {

  static const String apiKey = '4304be63f4459f18804c68af734fa3ce';

  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';

  static const String posterSizeSmall = 'w154';
  static const String posterSizeMedium = 'w342';
  static const String posterSizeLarge = 'w500';
  static const String backdropSize = 'w780';

 
  static const String nowPlaying = '/movie/now_playing';
  static const String popular = '/movie/popular';
  static const String trending = '/trending/movie/day';
  static const String searchMovie = '/search/movie';
  static const String movieDetail = '/movie'; // + /{id}

}

// Helper untuk bangun URL gambar
String buildImageUrl(String? path, {String size = ApiConstants.posterSizeMedium}) {
  if (path == null || path.isEmpty) return '';
  return '${ApiConstants.imageBaseUrl}/$size$path';
}
