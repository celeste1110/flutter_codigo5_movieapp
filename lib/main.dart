import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_codigo5_movieapp/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     statusBarColor: Colors.redAccent,
  //     systemNavigationBarColor: Colors.indigo,
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieApp',
      // theme: ThemeData(
      //   textTheme:GoogleFonts.poppins(),
      // ),
      home: HomePage(),
    );
  }
}
