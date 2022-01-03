import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:my_movie_app/models/movies.dart';
import 'package:my_movie_app/models/now_playing_response.dart';
import 'package:my_movie_app/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _api_key = '26f6006b82b2248d6e67631d0e8632ab';
  String _baseUrl = 'api.themoviedb.org';
  String _languaje = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];

  MoviesProvider() {
    print(' provider inicializado');
    this.getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(
        _baseUrl, endpoint, {'api_key': _api_key, 'lenguaje': _languaje, 'page': '$page'});
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    final jsonData = await this._getJsonData('3/movie/popular');
    final popularResponse = PopularResponse.fromJson(jsonData);
    onPopularMovies = popularResponse.results;
    notifyListeners();
  }
}
