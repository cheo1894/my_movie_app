import 'package:flutter/material.dart';
import 'package:my_movie_app/pages/details_screen.dart';
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
      routes: {'home': (_) => HomePage(), 'details': (_) => DetailsScreen()},
      theme: myTheme(),
    );
  }

  ThemeData myTheme() {
    var textColor = 0xffffffff;
    var backGroundColor = 0xff0B85FF;
    return ThemeData(
        primaryColor: Color(backGroundColor),
        textTheme: TextTheme(
            bodyText1: TextStyle(color: Color(textColor)),
            bodyText2: TextStyle(color: Color(textColor))
            
            ),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Color(textColor)),
            //color: Color(backGroundColor),
            elevation: 0,
            backgroundColor: Color(backGroundColor),
            titleTextStyle: TextStyle(color: Color(textColor), fontSize: 22)),
        scaffoldBackgroundColor: Color(backGroundColor)
        );
  }
}
