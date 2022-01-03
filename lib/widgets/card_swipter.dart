import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:my_movie_app/models/movies.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.80,
      width: double.infinity,
      child: Swiper(
        layout: SwiperLayout.DEFAULT,
        autoplay: true,
        autoplayDelay: 10000,
        duration: 2000,
        itemCount: movies.length,
        itemHeight: size.height * 0.62,
        itemWidth: size.width,
        itemBuilder: (_, int index) {
      
          return GestureDetector(
            onTap: () {},
            child: FadeInImage(
              fit: BoxFit.cover,
              image: NetworkImage(movies[index].fullPosterImg),
              placeholder: AssetImage('assets/no-image.jpg'),
            ),
          );
        },
      ),
    );
  }
}
