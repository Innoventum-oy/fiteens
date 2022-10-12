import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // important
import 'package:luen/src/providers/webpageprovider.dart';
import 'package:luen/src/views/achievements.dart';
import 'package:luen/src/views/dashboard.dart';
//import 'package:luen/src/views/gameboard.dart';
import 'package:luen/src/views/libraryitemlist.dart';
import 'package:luen/src/views/loginform.dart';
import 'package:luen/src/views/register.dart';
import 'package:luen/src/views/passwordform.dart';
import 'package:luen/src/util/utils.dart';
import 'package:luen/src/views/validatecontact.dart';
//import 'package:luen/src/views/welcome.dart';
import 'package:luen/src/views/tasklist.dart';
import 'package:luen/src/providers/auth.dart';
import 'package:luen/src/providers/user_provider.dart';
import 'package:luen/src/util/shared_preference.dart';
//import 'package:luen/src/views/viewform.dart';
import 'package:provider/provider.dart';
import 'package:feedback/feedback.dart';
import 'src/objects/user.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp( BetterFeedback(
      child:Luen(),
  ));
}

class Luen extends StatelessWidget {
  // This widget is the root of Luen application.

  @override
  Widget build(BuildContext context) {

    print('build called for luen application (main.dart)');
    Future<User>? getUserData() => UserPreferences().getUser();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => WebPageProvider())
      ],
      child: MaterialApp(
          title: 'Riveillä',
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          localizationsDelegates:  AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,//const [Locale('fi', 'FI')],
          //AppLocalizations.supportedLocales,
          theme: ThemeData(
            // This is the theme of the application.
            //  brightness: Brightness.light,
           // brightness: Brightness.dark,
            canvasColor: Colors.black,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: createMaterialColor('#FFe5b2d2'), // text button color

              ),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: createMaterialColor('#FF000000'),
              foregroundColor:  createMaterialColor('#ffffffff'),
            ),
            colorScheme: Theme.of(context).colorScheme.copyWith(
              brightness: Brightness.dark,

              primary:createMaterialColor('#FFf47b6a'), //button backgrounds
              secondary: createMaterialColor('#FF65246d'), // dark purple
            ),
            cardTheme: CardTheme(

              color: createMaterialColor('#FFaf1e53'),

          ),
            primaryTextTheme: Typography.whiteHelsinki,



            inputDecorationTheme:  InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: createMaterialColor('#FF4f144e')
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: createMaterialColor('#FFffe4d2')),
              ),
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
              //  foregroundColor:MaterialStateProperty.all(Colors.black),
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
          ),
          home: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                print('main.dart: snapshot connectionState: ' +
                    snapshot.connectionState.toString());
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:

                    if (snapshot.hasError)
                      return Text('Error occurred: ${snapshot.error}');
                    else if (snapshot.hasData) //(userdata.token == null)
                       {
                         print("User from snapshot:" + snapshot.toString());
                         User userdata = snapshot.data as User;
                         if(userdata.token!=null)
                           {
                             Provider.of<UserProvider>(context, listen: false).setUserSilent(userdata);
                          return DashBoard();
                           }
                        return Login();
                      }
                    else
                      UserPreferences().removeUser();
                   // print("Snapshot: "+ snapshot.data);
                    return Login(); //Welcome(user: snapshot.data as User);
                }
              }),
          routes: {
           // '/gameboard' : (context) => Gameboard(),
            '/mybooks' : (context) => VerticalItemList(viewtype:'own'),
            '/dashboard': (context) => DashBoard(),
            '/login': (context) => Login(),
            '/register': (context) => Register(),
            '/reset-password': (context) => ResetPassword(),
            '/validatecontact' : (context) => ValidateContact(),
            '/tasklist' : (context) => TaskList(),
            '/achievements' : (context)=> AchievementsView(),


          }),
    );
  }
}
