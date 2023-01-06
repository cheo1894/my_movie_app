import 'package:flutter/material.dart';
import 'package:my_movie_app/models/movies.dart';
import 'package:my_movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    var backgroundColor = Color(0xff0B85FF);
    var textColor = Color(0xffffffff);
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(

          floatingLabelStyle: TextStyle(color: Colors.red),
          fillColor: backgroundColor,
          hintStyle: TextStyle(color: textColor),
          filled: true,
          counterStyle: TextStyle(color: textColor),
          focusColor: textColor,
          hoverColor: textColor,

          focusedBorder:
              OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent, )),
          enabledBorder:
              OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent))),
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
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Icon(
            Icons.movie_filter_outlined,
            size: 130,
            color: Colors.white,
          ),
          Text(
            'No hay resultados',
            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Text('Por favor, ingrese un nombre en la barra de búsqueda'),
          Expanded(
            flex: 2,
            child: Container(),
          ),
        ],
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
