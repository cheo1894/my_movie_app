import 'package:flutter/material.dart';
import 'package:my_movie_app/providers/movies_provider.dart';
import 'package:my_movie_app/search/search_delegate.dart';
import 'package:my_movie_app/widgets/appbar.dart';
import 'package:my_movie_app/widgets/card_swipter.dart';
import 'package:my_movie_app/widgets/movie_slider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            title: Text(
              'Movie storm',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                  onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
                  icon: Icon(Icons.search_outlined))
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              CardSwiper(
                movies: moviesProvider.onDisplayMovies,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: moviesProvider.cardColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      MovieSlider(
                        movies: moviesProvider.onPopularMovies,
                        nameCategory: 'Populares',
                      ),
                      MovieSlider(
                        movies: moviesProvider.onTopRatedMovies,
                        nameCategory: 'Mejor valoradas',
                      ),
                      MovieSlider(
                        movies: moviesProvider.onUpcomingMovies,
                        nameCategory: 'Proximanete en cines',
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )),
            ],
          ),
        ));
  }
}
