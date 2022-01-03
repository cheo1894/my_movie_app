import 'package:flutter/material.dart';
import 'package:my_movie_app/models/movies.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String nameCategory;
  const MovieSlider({Key? key, required this.nameCategory, required this.movies}) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * 0.48,
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Text(
                  widget.nameCategory,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                controller: controller,
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (_, int index) {
               final movie = widget.movies[index];
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.50,
                    width: MediaQuery.of(context).size.width * 0.40,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInImage(
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: double.infinity,
                          image: NetworkImage(movie.fullPosterImg),
                          placeholder: AssetImage('assets/no-image.jpg'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          movie.title,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
