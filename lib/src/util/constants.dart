import 'dart:developer';

import 'package:fiteens/src/views/activity/activity.dart';
import 'package:fiteens/src/views/calendar/calendarscreen.dart';
import 'package:fiteens/src/views/dashboard/dashboard.dart';
import 'package:fiteens/src/views/library/library_screen.dart';
import 'package:fiteens/src/views/mywellbeing/wellbeingscreen.dart';
import 'package:fiteens/src/views/routines/routinesscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/l10n/app_localizations.dart'; // important


import '../widgets/notifydialog.dart';

String fundingDisclaimer = 'The project 2021-1-ES01-KA220-SCH-000027761-FITeens Promoting physical activity and healthy habits in sedentary teenagers is co-funded by the Erasmus+ programme of the European Union. The content of this app is the sole responsibility of the FITeens Project Consortium and neither the European Commission nor the Spanish Service for the Internationalisation of Education (SEPIE) is responsible for any use that may be made of the information contained therein.';

class AppUrl {
  static const Map<String,String> servers = {
    'Fiteens' : 'fiteens.eu',
    'Development' : 'dev.fiteens.eu'
  };
  static const String liveBaseURL = "dev.fiteens.eu";
  static const String localBaseURL = "http://10.0.2.2:4000/api/";
  static const int appId = 1; //App id for Lukudiplomi
  static const String baseURL = liveBaseURL;
  static const String login = "/api/login";
  static const String logout = "/api/logout";
  static const String registration =  "/api/register";
  static const String forgotPassword =  "/api/forgot-password";
  static const String requestValidationToken = "/api/dispatcher/registration/";
  static const String checkValidationToken = "/api/dispatcher/registration/";
  static const String getContactMethods = "/api/dispatcher/registration/";
  static const String anonymousApikey = "\$2y\$10\$3xeuku9X5z8YNZNVaDUf0OPRU2Q2t8QJFnIFEGLaWlCtwCEWVLQHu";
}

/// Todo: Move class to core, make building navigation dynamic
class NavigationItem {
  int navigationIndex;
  String label;
  Icon icon;
  String route;
  String view;
  bool displayInBottomNavigation;
  bool displayInDashboard;

  NavigationItem({required this.navigationIndex,required this.label,required this.icon,required this.route, required this.view,this.displayInBottomNavigation=true,this.displayInDashboard=true});
}

// navItems is used for Dashboard tiles and bottomNavigation
List<NavigationItem> navItems = [
  NavigationItem(navigationIndex: 0, label: 'home', icon: const Icon(Icons.home), route: '/dashboard',view: 'dashboard',displayInDashboard:false),
  NavigationItem(navigationIndex: 1, label: 'calendar', icon: const Icon(Icons.calendar_month_rounded), route: '/calendar', view: 'calendar',),
  NavigationItem(navigationIndex: 2, label: 'routines', icon: const Icon(Icons.sports_gymnastics), route: '/routines', view: 'routines',),
  NavigationItem(navigationIndex: 3, label: 'mywellbeing', icon: const Icon(Icons.monitor_heart_outlined), route: '/mywellbeing', view: 'mywellbeing'),
  NavigationItem(navigationIndex: 4,label: 'library', icon: const Icon(Icons.my_library_books_outlined),route: '/library', view: 'library')
];

/// This router class takes care of navigating to different page routes defined by NavigationItems
class Router {
    static void navigate(BuildContext context,String view,int navIndex,{refresh=false,dynamic data}) {
      if(kDebugMode){
        log("Navigating to route $view");
      }
      bool routeFound = false;
      Widget targetWidget = const Text('Error: view not found');
      switch(view) {
        case 'activity' :
            targetWidget = ActivityScreen(data,navIndex:navIndex,refresh:refresh);
            routeFound = true;
          break;
        case 'dashboard' :
          targetWidget = DashBoard(navIndex: navIndex,refresh:refresh);
          routeFound = true;
          break;
        case 'calendar' :
          targetWidget = CalendarScreen(navIndex: navIndex,refresh: refresh,);
          routeFound = true;
          break;
        case 'library' :
          targetWidget = LibraryScreen(navIndex: navIndex,refresh:refresh);
          routeFound = true;
          break;
        case 'mywellbeing' :
          targetWidget = WellbeingScreen(navIndex: navIndex,refresh: refresh,);
          routeFound = true;
          break;
        case 'routines' :
          targetWidget = RoutinesScreen(navIndex: navIndex,refresh:refresh);
          routeFound = true;
          break;
        case 'webpage' :
       //   targetWidget = WebPageView();
          routeFound = true;
          break;


      }
      if (routeFound) {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => targetWidget);

        Navigator.pushReplacement(context, route);
      }
      else {
        // Display error
        notifyDialog(AppLocalizations.of(context)!.error,targetWidget,context);
      }
    }
}