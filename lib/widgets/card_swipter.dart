import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:my_movie_app/models/movies.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CardSwiper extends StatefulWidget {
  final List<Movie> movies;
  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  int indexTab = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (widget.movies.isEmpty) {
      return Container(
          height: size.width * 0.70,
          width: double.infinity,
          child: Center(
            child: CircularProgressIndicator(),
          ));
    }
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Container(
                height: size.width * 0.60,
                width: double.infinity,
                child: CarouselSlider.builder(
                    itemCount: widget.movies.length,
                    itemBuilder: (_, int index, realIndex) {
                      return imageSlider(context, index, size);
                    },
                    options: CarouselOptions(
                        height: size.width * 0.60,
                        viewportFraction: 0.94,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            indexTab = index;
                          });
                        },
                        autoPlayInterval: Duration(seconds: 4)))),
            // Container(
            //   height: size.width * 0.66,
            //   width: double.infinity,
            //   child: Swiper(
            //     layout: SwiperLayout.DEFAULT,
            //     autoplay: true,
            //     autoplayDelay: 10000,
            //     duration: 2000,
            //     itemCount: widget.movies.length,
            //     itemHeight: size.height * 0.60,
            //     itemWidth: size.width,
            //     onIndexChanged: (value) {
            //       setState(() {
            //         indexTab = value;
            //       });
            //     },
            //     itemBuilder: (_, int index) {
            //       return imageSlider(context, index, size);
            //     },
            //   ),
            // ),

            //SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: size.width * 0.55),
              child: Container(
                width: double.infinity,
                child: Text(
                  widget.movies[indexTab].title,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }

  GestureDetector imageSlider(BuildContext context, int index, Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: widget.movies[index]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
            color: Colors.transparent,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(widget.movies[index].fullBackdropPath)
                ),
              ],
            )),
      ),
    );
  }
}
