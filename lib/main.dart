import 'package:flutter/material.dart';
import 'package:my_movie_app/pages/home_page.dart';
import 'package:my_movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false)],
        child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie storm',
      initialRoute: 'home',
      routes: {'home': (_) => HomePage()},
      theme: ThemeData.dark().copyWith(backgroundColor: Color(0xFF000000)),
    );
  }
}
