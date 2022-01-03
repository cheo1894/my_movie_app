import 'package:flutter/material.dart';
import 'package:my_movie_app/providers/movies_provider.dart';
import 'package:my_movie_app/widgets/appbar.dart';
import 'package:my_movie_app/widgets/card_swipter.dart';
import 'package:my_movie_app/widgets/movie_slider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              CardSwiper(
                movies: moviesProvider.onDisplayMovies,
              ),
              MovieSlider(
                movies: moviesProvider.onPopularMovies,
                nameCategory: 'Populares',
              ),
             
            ],
          ),
          Appbar(),
        ],
      ),
    ));
  }
}
