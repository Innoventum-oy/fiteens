import 'dart:developer';

import 'package:core/core.dart';
import 'package:fiteens/src/views/calendar/calendarscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // important
import 'package:fiteens/src/views/achievements.dart';
import 'package:fiteens/src/views/dashboard/dashboard.dart';
import 'package:fiteens/src/views/webpage/pagelist.dart';
import 'package:fiteens/src/views/user/loginform.dart';
import 'package:fiteens/src/views/user/register.dart';
import 'package:fiteens/src/views/user/passwordform.dart';
import 'package:fiteens/src/util/utils.dart';
import 'package:fiteens/src/views/user/validatecontact.dart';
import 'package:core/core.dart' as core;
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  /*
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  final targetEnvironment = await Settings().getServerName();
  await Hive.initFlutter("${appDocumentDirectory.path}/$targetEnvironment");
*/
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => core.AuthProvider()),
          ChangeNotifierProvider(create: (_) => core.BadgeProvider()),
          ChangeNotifierProvider(create: (_) => core.UserProvider()),
          ChangeNotifierProvider(create: (_) => core.WebPageProvider()),
          ChangeNotifierProvider(create: (_) => core.ActivityProvider()),
          ChangeNotifierProvider(create: (_) => core.ActivityClassProvider()),
          ChangeNotifierProvider(create: (_) => core.ActivityVisitProvider()),
          ChangeNotifierProvider(create: (_) => core.ImageProvider()),
          ChangeNotifierProvider(create: (_) => core.RoutineProvider()),
          ChangeNotifierProvider(create: (_) => core.RoutineItemProvider()),
        ],
        child:Fiteens()
      ),
  );
}


class Fiteens extends StatelessWidget {
  // This widget is the root of Fiteens  application.

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      log('build called for application (main.dart)');
    }

    Future<User> getUserData() async {
      if(kDebugMode){
        log('getUserData() called for FutureBuilder in main');
      }
      return await Provider.of<AuthProvider>(context).user;
    }

        return  MaterialApp(
          title: 'Fiteens',
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService.navigatorKey,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,

          theme: ThemeData(
            fontFamily: 'Nunito',
            // This is the theme of the application.
            //  brightness: Brightness.light,
            // brightness: Brightness.dark,
            canvasColor: createMaterialColor('#283F4D'),//Colors.black,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    createMaterialColor('#FF299fe0'), // text button color: blue
              ),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: createMaterialColor('#FF000000'),
              foregroundColor: createMaterialColor('#ffffffff'),
            ),
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  brightness: Brightness.dark,

                  primary: createMaterialColor('#283F4D'),
                  //button backgrounds: orange
                  secondary: createMaterialColor('#FDED46FF'), // green
                ),
            cardTheme: CardTheme(
              color: createMaterialColor('#283F4D'), // blue
            ),
           // primaryTextTheme: Typography.whiteHelsinki,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.black),
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: createMaterialColor('#FFee962b')),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: createMaterialColor('#FF66b42c')),
              ),
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                    //  foregroundColor:MaterialStateProperty.all(Colors.black),
                    )),
            /* buttonTheme: ButtonThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              buttonColor: Colors.white,//HexColor.fromHex('#FFEDE30E'),

            ),*/
            // This makes the visual density adapt to the platform that you run
            // the app on. For desktop platforms, the controls will be smaller and
            // closer together (more dense) than on mobile platforms.
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FutureBuilder(
              initialData: User(),
              future: getUserData(),
              builder: (context, snapshot) {
                if (kDebugMode) {
                  log("main.dart: snapshot connectionState: ${snapshot.connectionState.toString()}");
                }
                log('Locales in use: ${AppLocalizations.supportedLocales}; Current locale: ${Localizations.localeOf(context)}');
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Container(
                          color: Colors.red,
                          child: Padding(
                              padding:
                                  EdgeInsets.only(top: 50, left: 20, right: 20),
                              child: Text(
                                  'Error occurred: ${snapshot.error} :: ${snapshot.stackTrace}\n Sorry! x(',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      decoration: TextDecoration.none))));
                    else if (snapshot.hasData) //(userdata.token == null)
                    {
                      print("User from snapshot:" + snapshot.toString());
                      core.User userdata = snapshot.data as core.User;
                      if (userdata.token != null) {
                        Provider.of<core.UserProvider>(context, listen: false)
                            .setUserSilent(userdata);
                        log('Opening dashboard');
                        return DashBoard();
                      }
                      return Login();
                    } else
                      core.UserPreferences.removeUser();
                    // print("Snapshot: "+ snapshot.data);
                    return Login(); //Welcome(user: snapshot.data as User);
                }
              }),
          routes: {
            // '/gameboard' : (context) => Gameboard(),
            '/resources': (context) => VerticalPageList(),
            '/dashboard': (context) => DashBoard(),
            '/login': (context) => Login(),
            '/calendar' :(context) =>CalendarScreen(),
            '/register': (context) => Register(),
            '/reset-password': (context) => ResetPassword(),
            '/validatecontact': (context) => ValidateContact(),
            '/achievements': (context) => AchievementsView(),
          }
    );
  }
}
