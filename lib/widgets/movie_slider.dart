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
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      height: size.width * 0.68,
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Text(
                  widget.nameCategory,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                controller: controller,
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (_, int index) {
                  final movie = widget.movies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'details', arguments: widget.movies[index]);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: size.width * 1.40,
                        width: size.width * 0.30,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xff000000).withOpacity(0.5),
                                        offset: Offset(0, 3),
                                        blurRadius: 3)
                                  ]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: FadeInImage(
                                  fit: BoxFit.cover,
                                  height: MediaQuery.of(context).size.height * 0.20,
                                  width: double.infinity,
                                  image: NetworkImage(movie.fullPosterImg),
                                  placeholder: AssetImage('assets/no-image.jpg'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              width: double.infinity,
                              child: Text(
                                movie.title,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
