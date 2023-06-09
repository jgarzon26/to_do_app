import 'package:flutter/material.dart';
import 'package:to_do_app/constants.dart';

class DefaultTheme {
  static ThemeData buildThemeData() {
    return ThemeData(
      scaffoldBackgroundColor: kBackgroundLightColor,
      fontFamily: 'PT Sans',
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          height: 1.5,
        ),
      ),
      appBarTheme: _buildAppBarThemeData(),
      listTileTheme: _buildListTileTheme(),
      inputDecorationTheme: _buildInputDecorationTheme(),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
    );
  }

  static AppBarTheme _buildAppBarThemeData() {
    return const AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        fontFamily: 'PT Sans',
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  static ListTileThemeData _buildListTileTheme() {
    return const ListTileThemeData(
      contentPadding: EdgeInsets.all(defaultPadding),
      visualDensity: VisualDensity.comfortable,
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
