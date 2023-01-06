import 'package:flutter/material.dart';
import 'package:my_movie_app/models/movies.dart';
import 'package:my_movie_app/providers/movies_provider.dart';
import 'package:my_movie_app/widgets/cast_slider.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            centerTitle: false,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x000000).withOpacity(0.5),
                            offset: Offset(0, 2),
                            blurRadius: 3)
                      ]),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: FadeInImage(
                          fit: BoxFit.cover,
                          placeholder: AssetImage('assets/no-image.jpg'),
                          image: NetworkImage(movie.fullPosterImg))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      movie.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    movie.originalTitle != movie.title
                        ? Text(
                            movie.originalTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  infoIcons(movie.voteAverage.toString(), Icons.rate_review, moviesProvider),
                  infoIcons(movie.popularity.toString(), Icons.star, moviesProvider),
                  infoIcons(movie.originalLanguage.toUpperCase(), Icons.language, moviesProvider)
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  movie.overview,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(
                height: 20,
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
                      CastSlider(movie.id),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )),
            ],
          ),
        ));
  }

  Column infoIcons(data, icon, moviesProvider) {
    return Column(
      children: [
        Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: Color(0xff000000).withOpacity(0.5), offset: Offset(0.5, 1), blurRadius: 3)
            ], color: moviesProvider.cardColor, borderRadius: BorderRadius.circular(18)),
            child: Center(child: Icon(icon, color: Colors.white))),
        SizedBox(
          height: 8,
        ),
        Text(
          data,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
