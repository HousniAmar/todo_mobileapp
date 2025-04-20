import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class ThemeController {
  static ThemeData getLightTheme() {
    String mainFont = GoogleFonts.syne().fontFamily ?? 'Syne';

    return FlexThemeData.light(
      textTheme: TextTheme(
        bodyLarge: const TextStyle(color: Colors.blue),
        titleLarge: TextStyle(
            fontFamily: mainFont, fontWeight: FontWeight.w600, fontSize: 40),
        titleMedium: TextStyle(
            fontFamily: mainFont, fontWeight: FontWeight.w600, fontSize: 20),
        titleSmall: TextStyle(
            fontFamily: mainFont, fontWeight: FontWeight.w600, fontSize: 14),
        labelLarge: TextStyle(
            fontFamily: mainFont, fontWeight: FontWeight.w500, fontSize: 13),
        labelSmall: TextStyle(
            fontFamily: mainFont, fontWeight: FontWeight.w500, fontSize: 12),
        labelMedium: TextStyle(
            fontFamily: mainFont, fontWeight: FontWeight.w700, fontSize: 15),
        bodySmall: TextStyle(
            fontFamily: mainFont, fontWeight: FontWeight.w500, fontSize: 14),
        displayLarge: TextStyle(
            fontFamily: mainFont, fontWeight: FontWeight.w700, fontSize: 13),
        displayMedium: TextStyle(
            fontFamily: mainFont, fontWeight: FontWeight.w700, fontSize: 16),
        headlineSmall: TextStyle(
            fontFamily: mainFont, fontWeight: FontWeight.w500, fontSize: 9),
        headlineMedium: TextStyle(
            fontFamily: mainFont, fontWeight: FontWeight.w500, fontSize: 10),
      ),
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.blue,
        onPrimary: Colors.blue,
        secondary: Colors.white,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.red,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
    ).copyWith(
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.blue,
          fontSize: 20,
        ),
        surfaceTintColor: Colors.transparent,
      ),
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (BuildContext context) => Icon(
          Icons.arrow_back,
          size: 24.0,
          color: Colors.black,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.grey,
          fontSize: 14,
        ),
        prefixIconColor: Colors.blue,
        iconColor: Colors.blue,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(17)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(17)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(17),
        ),
      ),
    );
  }
}
