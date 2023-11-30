import 'package:fiteens/src/util/utils.dart';
import 'package:flutter/material.dart';

const Color primary = Colors.white;//const Color(0xFF981f4f);
const Color primaryDark = const Color(0xFF9d1a6f);
const Color colorAccent = const Color(0xFF65BFA6);
const Color salmon = const Color(0xFFF47663);

const Color appBackground = Color(0xFF283F4D);
const Color secondaryThemeColor = Color(0xFF299fe0);// = createMaterialColor('#FEDE39');//yellow
const Color appForeground = Colors.white;
const Color effect = Color(0xFFFEDE39);
const Color buttonColorSecondary = Color(0xFF299fe0);
const Color buttonColorPrimary = Color(0xFFF47B6A);
final TextStyle captionStyle = TextStyle(color: Colors.grey[400]);
final TextStyle whiteBody = TextStyle(color: Colors.white);
final TextStyle inputLabel = TextStyle(color: Colors.white);

ThemeData appTheme = ThemeData(
  fontFamily: 'Nunito',
  // This is the theme of the application.
  //  brightness: Brightness.light,
  // brightness: Brightness.dark,
  canvasColor: appBackground,
  scaffoldBackgroundColor: appBackground,
  colorScheme: ColorScheme.dark().copyWith(
    brightness: Brightness.dark,
    //primaryContainer: canvasColor,
    primary: primary,
    //button backgrounds: orange
    secondary: secondaryThemeColor, // green
  ),
  unselectedWidgetColor: secondaryThemeColor,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor:
      buttonColorPrimary, // text button color: blue
    ),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateColor.resolveWith((states) => secondaryThemeColor)
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: appBackground,
    foregroundColor: appForeground,
  ),

  cardTheme: CardTheme(
    color: createMaterialColor('#283F4D'), // blue
  ),
  // primaryTextTheme: Typography.whiteHelsinki,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.black),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          width: 1, color: secondaryThemeColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          width: 1, color: createMaterialColor('#FF66b42c')),
    ),
    labelStyle: TextStyle(color: Colors.white),
    hintStyle: TextStyle(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        backgroundColor: buttonColorPrimary,
      )
  ),
  /* buttonTheme: ButtonThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              buttonColor: Colors.white,//HexColor.fromHex('#FFEDE30E'),

            ),*/
  // This makes the visual density adapt to the platform that you run
  // the app on. For desktop platforms, the controls will be smaller and
  // closer together (more dense) than on mobile platforms.
  visualDensity: VisualDensity.adaptivePlatformDensity,
);