import 'package:flutter/material.dart';
import 'package:my_movie_app/models/creditsResponse.dart';
import 'package:my_movie_app/models/movies.dart';
import 'package:my_movie_app/models/now_playing_response.dart';
import 'package:my_movie_app/models/popular_response.dart';
import 'package:my_movie_app/models/top_rated_response.dart';
import 'package:my_movie_app/models/upcoming_response.dart';
import 'package:my_movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    var backgroundColor = Color(0xff335765);
    var textColor = Color(0xffB9B9B9);
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
          fillColor: backgroundColor,
          hintStyle: TextStyle(color: textColor),
          filled: true,
          counterStyle: TextStyle(color:  textColor),
          
          focusColor: textColor,
          hoverColor: textColor
          
          
          
          
          
          
          
          ),
      textTheme: TextTheme(
          caption: TextStyle(color: textColor),
          subtitle1: TextStyle(color: textColor),
          bodyText1: TextStyle(color: textColor),
          bodyText2: TextStyle(color: textColor)),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: textColor),
          foregroundColor: backgroundColor,
          //color: Color(backGroundColor),
          elevation: 0,
          backgroundColor: backgroundColor,
          titleTextStyle: TextStyle(color: textColor, fontSize: 22)),
    );
  }

  String? get searchFieldLabel => 'Buscar Pelicula';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResult');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return _emptyContainer();

    print('buscando');

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem(movies[index]),
        );
      },
    );
  }
}

Widget _emptyContainer() {
  return Center(
    child: Container(
      child: Icon(
        Icons.movie_creation_outlined,
        size: 130,
      ),
    ),
  );
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(movie.fullPosterImg),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
