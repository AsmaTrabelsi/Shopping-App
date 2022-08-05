import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode =ThemeMode.dark;
  bool get isDarkMode=> themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn){
    themeMode = isOn ? ThemeMode.dark:ThemeMode.light;
    notifyListeners();
  }
}
class MyThemes{
  static final darkTheme = ThemeData(
      fontFamily: 'Hind-Medium',
    scaffoldBackgroundColor: Colors.grey.shade900,
      primaryColor: Colors.white,
      appBarTheme:AppBarTheme(
        color: Colors.grey.shade800,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
          titleTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)

      ) ,
      scrollbarTheme: ScrollbarThemeData().copyWith(
        thumbColor: MaterialStateProperty.all(Colors.white),
      ),
    colorScheme: ColorScheme.dark(
        primary: Colors.pinkAccent,

    )
  );

  static final lightTheme = ThemeData(
      fontFamily: 'Hind-Medium',
    scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,
      appBarTheme:AppBarTheme(
        color: Colors.grey.shade200,
        iconTheme: IconThemeData(
            color: Colors.grey.shade700
        ),
        titleTextStyle: TextStyle(color: Colors.grey.shade700,fontWeight: FontWeight.w500)
      ) ,
      scrollbarTheme: ScrollbarThemeData().copyWith(
        thumbColor: MaterialStateProperty.all(Colors.grey.shade800),
      ),
    colorScheme: ColorScheme.light(
      primary: Colors.pinkAccent
    )
  );
}