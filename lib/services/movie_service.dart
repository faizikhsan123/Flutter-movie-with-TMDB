import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';
import 'api_constants.dart';

class MovieService {
  Future<List<MovieModel>> getNowPlaying({int page = 1}) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.nowPlaying}'
      '?api_key=${ApiConstants.apiKey}&language=en-US&page=$page',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception(
        'Failed to load now playing movies: ${response.statusCode}',
      );
    }
  }

  Future<List<MovieModel>> getPopular({int page = 1}) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.popular}'
      '?api_key=${ApiConstants.apiKey}&language=en-US&page=$page',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load popular movies: ${response.statusCode}');
    }
  }

  Future<List<MovieModel>> getTrending() async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.trending}'
      '?api_key=${ApiConstants.apiKey}',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load trending movies: ${response.statusCode}');
    }
  }

  Future<List<MovieModel>> searchMovies(String query, {int page = 1}) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.searchMovie}'
      '?api_key=${ApiConstants.apiKey}&language=en-US'
      '&query=${Uri.encodeQueryComponent(query)}&page=$page',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search movies: ${response.statusCode}');
    }
  }

  Future<MovieModel> getMovieDetail(int id) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.movieDetail}/$id'
      '?api_key=${ApiConstants.apiKey}&language=en-US',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return MovieModel.fromJson(data);
    } else {
      throw Exception('Failed to load movie detail: ${response.statusCode}');
    }
  }
}
