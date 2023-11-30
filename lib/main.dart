import 'dart:developer';

import 'package:core/core.dart';
import 'package:fiteens/src/util/styles.dart';
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
import 'package:intl/intl.dart';
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



        return  MaterialApp(
          title: 'Fiteens',
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService.navigatorKey,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,

          theme: appTheme,
          home: AppLocalizationState(),
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
class AppLocalizationState extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AppLocalizationState();
  }
}
class _AppLocalizationState extends State<AppLocalizationState> {

  Future<User> getUserData() async {
    if(kDebugMode){
      //  log('getUserData() called for FutureBuilder in main');
    }

    return await Provider.of<AuthProvider>(context).user;
  }
  @override void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => setLocale(context));

  }
  void setLocale(context)
  {
    core.Settings().setValue('language', Localizations.localeOf(context).toString());
    if(kDebugMode){
      log('App language setting set to ${Localizations.localeOf(context)} ');
    }
  }
  @override
  Widget build(BuildContext context){
    return FutureBuilder(
        initialData: User(),
        future: getUserData(),
        builder: (context, snapshot) {
          if (kDebugMode) {
            log("main.dart: snapshot connectionState: ${snapshot.connectionState.toString()}");
          }
          log('Locales in use: ${AppLocalizations.supportedLocales}; Current locale: ${Localizations.localeOf(context)}, intl locale: ${Intl.getCurrentLocale()}');
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
                // print("User from snapshot:" + snapshot.toString());
                core.User userdata = snapshot.data as core.User;
                if (userdata.token != null) {
                  Provider.of<core.UserProvider>(context, listen: false)
                      .setUserSilent(userdata);

                  return DashBoard();
                }
                return Login();
              } else
                core.UserPreferences.removeUser();
              // print("Snapshot: "+ snapshot.data);
              return Login(); //Welcome(user: snapshot.data as User);
          }
        });
  }
}