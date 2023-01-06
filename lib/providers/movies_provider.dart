import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:my_movie_app/helpers/debouncer.dart';
import 'package:my_movie_app/models/movies.dart';
import 'package:my_movie_app/models/now_playing_response.dart';
import 'package:my_movie_app/models/popular_response.dart';
import 'package:my_movie_app/models/creditsResponse.dart';
import 'package:my_movie_app/models/search_response.dart';
import 'package:my_movie_app/models/top_rated_response.dart';
import 'package:my_movie_app/models/upcoming_response.dart';

class MoviesProvider extends ChangeNotifier {
  Color _cardColor = Color(0xff0F73D4);
  get cardColor => _cardColor;
  String _api_key = '26f6006b82b2248d6e67631d0e8632ab';
  String _baseUrl = 'api.themoviedb.org';

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];
  List<Movie> onTopRatedMovies = [];
  List<Movie> onUpcomingMovies = [];

  Map<int, List<Cast>> movieCast = {};

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionsStreamController = StreamController.broadcast();

  Stream <List<Movie>> get suggestionsStream => this._suggestionsStreamController.stream;

  MoviesProvider() {
    print(' provider inicializado');
    this.getOnDisplayMovies();
    getPopularMovies();
    getTopRatedMovies();
    getUpcomingMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url =
        Uri.https(_baseUrl, endpoint, {'api_key': _api_key, 'language': 'es-ES', 'page': '$page'});
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

  getTopRatedMovies() async {
    final jsonData = await this._getJsonData('3/movie/top_rated');
    final topRatedResponse = TopRatedResponse.fromJson(jsonData);
    onTopRatedMovies = topRatedResponse.results;
    notifyListeners();
  }

  getUpcomingMovies() async {
    final jsonData = await this._getJsonData('3/movie/upcoming');
    final upcomingResponse = UpcomingResponse.fromJson(jsonData);
    onUpcomingMovies = upcomingResponse.results;
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieCast)) {
      return movieCast[movieId]!;
    }

    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

 Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _api_key, 'language': 'es-ES', 'query': query});

    final response = await http.get(url); //respuesta http

    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results; //retorno de la respuesta
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final result = await this.searchMovie(value);
      this._suggestionsStreamController.add(result);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
