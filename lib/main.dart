import 'dart:developer';

import 'package:core/core.dart';
import 'package:fiteens/src/util/styles.dart';
import 'package:fiteens/src/views/calendar/calendarscreen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:fiteens/src/views/user/card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fiteens/generated/l10n.dart'; // important
import 'package:fiteens/src/views/achievements.dart';
import 'package:fiteens/src/views/dashboard/dashboard.dart';
import 'package:fiteens/src/views/webpage/pagelist.dart';
import 'package:fiteens/src/views/user/loginform.dart';
import 'package:fiteens/src/views/user/register.dart';
import 'package:fiteens/src/views/user/passwordform.dart';
import 'package:fiteens/src/util/utils.dart';
import 'package:fiteens/src/views/user/validatecontact.dart';
import 'package:core/core.dart' as core;
//import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  /*
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  final targetEnvironment = await Settings().getServerName();
  await Hive.initFlutter("${appDocumentDirectory.path}/$targetEnvironment");
*/
  final fileStorage = await core.FileStorage.initialize();
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
          ChangeNotifierProvider(create: (_) => fileStorage), // FileStorage
          ChangeNotifierProvider(create: (_) => core.ImageProvider()),
          ChangeNotifierProvider(create: (_) => core.RoutineProvider()),
          ChangeNotifierProvider(create: (_) => core.RoutineItemProvider()),
        ],
        child:const Fiteens()
    ),
  );
}


class Fiteens extends StatefulWidget {
  const Fiteens({super.key});

  @override
  FiteensState createState() => FiteensState();
}
class FiteensState extends State<Fiteens> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    // Listen to ApiClient isProcessingNotifier
    core.ApiClient().isProcessingNotifier.addListener(_handleProcessing);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    core.ApiClient().isProcessingNotifier.removeListener(_handleProcessing);
    super.dispose();
  }

  void _handleProcessing() {
    if(kDebugMode || kProfileMode){
      log('ApiClient isProcessingNotifier: ${core.ApiClient().isProcessingNotifier.value}',name:'main.dart FiteensState');
    }
    // if the ApiClient is processing, show the loader overlay
    if (core.ApiClient().isProcessingNotifier.value) {
      context.loaderOverlay.show();
    } else {
      // if the ApiClient is not processing, hide the loader overlay
      context.loaderOverlay.hide();
    }
  }

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
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,

        theme: appTheme,
        home: const AppLocalizationState(),
        routes: {
          // '/gameboard' : (context) => Gameboard(),
          '/resources': (context) => VerticalPageList(),
          '/dashboard': (context) => const DashBoard(),
          '/login': (context) => const Login(),
          '/calendar' :(context) =>const CalendarScreen(),
          '/register': (context) => const Register(),
          '/reset-password': (context) => const ResetPassword(),
          '/validatecontact': (context) => const ValidateContact(),
          '/achievements': (context) => AchievementsView(),
          '/user' : (context) => const MyCard()
        }
    );
  }
}
class AppLocalizationState extends StatefulWidget{
  const AppLocalizationState({super.key});

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
    return LoaderOverlay(
        child: FutureBuilder(
        initialData: User(),
        future: getUserData(),
        builder: (context, snapshot) {
          if (kDebugMode) {
            log("main.dart: snapshot connectionState: ${snapshot.connectionState.toString()}");
          }
          log('Locales in use: ${AppLocalizations.delegate.supportedLocales}; Current locale: ${Localizations.localeOf(context)}, intl locale: ${Intl.getCurrentLocale()}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: SizedBox(width:100,height:100,child: CircularProgressIndicator()));
            default:
              if (snapshot.hasError) {
                return Container(
                    color: Colors.red,
                    child: Padding(
                        padding:
                        const EdgeInsets.only(top: 50, left: 20, right: 20),
                        child: Text(
                            'Error occurred: ${snapshot.error} :: ${snapshot.stackTrace}\n Sorry! x(',
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.none))));
              } else if (snapshot.hasData)
              {

                core.User userdata = snapshot.data as core.User;
                if (userdata.token != null) {
                  Provider.of<core.UserProvider>(context, listen: false)
                      .setUserSilent(userdata);

                  return const DashBoard();
                }
                return const Login();
              } else {
                core.UserPreferences.removeUser();
              }
              return const Login(); //Welcome(user: snapshot.data as User);
          }
        })
    );
  }
}