// To parse this JSON data, do
//
//     final popularResponse = popularResponseFromMap(jsonString);

import 'dart:convert';

import 'package:my_movie_app/models/movies.dart';

class PopularResponse {
    PopularResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;//se cambió no el nombre del tipo de lista al igual que en nowPlayingResponse
    int totalPages;
    int totalResults;

    factory PopularResponse.fromJson(String str) => PopularResponse.fromMap(json.decode(str));



    factory PopularResponse.fromMap(Map<String, dynamic> json) => PopularResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );


}

// La clase Movie ya existe por lo que se borro de este archivo...