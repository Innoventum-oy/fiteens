import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../util/constants.dart' as constants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Widget bottomNavigation(BuildContext context, {int currentIndex = 0}) {
  List<constants.NavigationItem> bottomNavItems = constants.navItems;
  bottomNavItems.removeWhere((item)=> item.displayInBottomNavigation==false);
  return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      items: [...bottomNavItems.map((navitem) =>  BottomNavigationBarItem(label: AppLocalizations.of(context)!.navitem(navitem.label), icon: navitem.icon))],
      selectedItemColor: Colors.white,
      onTap: (index) {
          for(constants.NavigationItem navItem in constants.navItems){
            if(navItem.navigationIndex == index) {
              if(kDebugMode){
                log('$index ${navItem.view.toString()} ');
              }

              constants.Router.navigate(context,navItem.view,index);
             // Navigator.pushNamedAndRemoveUntil(context, navItem.route, (Route<dynamic> route) => false);
            }
          }

      });
}
