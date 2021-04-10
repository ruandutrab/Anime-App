import 'package:flutter/material.dart';

class Style extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(),
    );
  }

  static Color primary([double opacity = 1]) =>
      Colors.blue[500].withOpacity(opacity);
  static Color primaryLight([double opacity = 1]) =>
      Color(0xff6ec6ff).withOpacity(opacity);
  static Color primaryDark([double opacity = 1]) =>
      Color(0xff0069c0).withOpacity(opacity);

  static Color secondary([double opacity = 1]) =>
      Color(0xff303f9f).withOpacity(opacity);
  static Color secondaryLight([double opacity = 1]) =>
      Color(0xff666ad1).withOpacity(opacity);
  static Color secondaryDark([double opacity = 1]) =>
      Color(0xff001970).withOpacity(opacity);

  static Color light([double opacity = 1]) =>
      Color.fromRGBO(230, 230, 230, opacity);
  static Color dark([double opacity = 1]) => primaryDark(opacity);
}
