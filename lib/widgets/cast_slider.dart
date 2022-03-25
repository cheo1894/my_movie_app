import 'package:flutter/material.dart';
import 'package:my_movie_app/models/creditsResponse.dart';
import 'package:my_movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastSlider extends StatefulWidget {
  final int movieId;
  const CastSlider(this.movieId);

  @override
  State<CastSlider> createState() => _CastSliderState();
}

class _CastSliderState extends State<CastSlider> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: moviesProvider.getMovieCast(widget.movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
         if (!snapshot.hasData) {
           return Center(
             child: Container(
                 margin: EdgeInsets.symmetric(vertical: 40), child: CircularProgressIndicator()),
           );
         }

        final List<Cast> cast = snapshot.data!;

        
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
                      'Actores',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: cast.length,
                    itemBuilder: (_, int index) {
                      //final movie = widget.movies[index];
                      return _CastCard(cast[index]);
                    }),
              )
            ],
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
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
                  image: NetworkImage(actor.fullProfilePath),
                  placeholder: AssetImage('assets/no-image.jpg'),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(right: 5),
              width: double.infinity,
              child: Text(
                actor.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: Color(0xffB9B9B9),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
