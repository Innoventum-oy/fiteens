//import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:core/core.dart' as core;
import 'package:fiteens/src/views/achievements.dart';
import 'package:fiteens/src/views/badge.dart';
import 'package:fiteens/src/views/scorelist.dart';
import 'package:fiteens/src/views/webpage/webpagetextcontent.dart';
import 'package:fiteens/src/views/user/card.dart';
import 'package:fiteens/src/views/webpage/pagelist.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:fiteens/src/views/user/loginform.dart';
import 'package:fiteens/src/util/utils.dart';

import '../../util/constants.dart';
import 'components/achievements.dart';
import 'components/badgeicondisplay.dart';
import 'components/useravatar.dart';
import 'components/usernamelabel.dart';
import 'components/usertile.dart';
import '../../util/constants.dart' as constants;
//import 'package:core/src/providers/imageprovider.dart' as coreimage;
class DashBoard extends StatefulWidget {
  final String viewTitle = 'dashboard';


  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int buildIteration = 1;

  core.User user = new core.User();
  List<core.Badge> badges = [];
  bool loginPopupDisplayed = false;
  core.BadgeProvider badgeProvider = core.BadgeProvider();
  String? errorMessage;
  core.WebPage page = new core.WebPage();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this.buildIteration = 1;
      this.user = Provider.of<core.UserProvider>(context, listen: false).user;
      
      Provider.of<core.UserProvider>(context, listen: false).getBadgeList();
      Provider.of<core.WebPageProvider>(context, listen: false).loadItem({
        'language': Localizations.localeOf(context).toString(),
        'commonname': widget.viewTitle,
        'fields': 'id,commonname,pagetitle,textcontents,thumbnailurl',
        if (user.token != null) 'api_key': user.token,
      });

      final Map<String, dynamic> badgeParams = {
        //'fields' : 'title,description,coverpictureurl,level,identifier',
        'requiredactivities': "gt:0", /// Todo: support parameter in back-end
        'api-key': user.token,
        'api_key': user.token,
        'sort': 'requiredactivities',
      };
       this.badgeProvider.loadItems(badgeParams);
      /// See if info page exists for the view
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    print('building dasboard state($buildIteration)');
    buildIteration++;

    this.user = Provider.of<core.UserProvider>(context).user;
    this.badges = (this.badgeProvider.badges ?? []);
    this.page = Provider.of<core.WebPageProvider>(context).page;

    /// open login if user token is not found
    if (this.user.token == null) {
      //   print('user token not found, pushing named route /login');
      return Login();
    } else {
      

      bool hasInfoPage =
          this.page.id != null && this.page.runtimeType.toString() == 'WebPage'
              ? true
              : false;

      return  Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.appName),
                elevation: 0.1,
                actions: [
                  //Info page button
                  if (hasInfoPage)
                    IconButton(
                        icon: Icon(Icons.info_outline_rounded),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ContentPageView(widget.viewTitle,
                                providedPage: this.page),
                          ));
                        }),

                  //Refresh button
                  IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () async {

                        Provider.of<core.UserProvider>(context, listen: false)
                            .refreshUser();

                      }),
                  //User card link

                ],
              ),
              body: ListView(children: <Widget>[

               userTile(user,context),
                SizedBox(height:10),
                achievements(user,badges,context),

                ...navItems.map((navitem) =>  (navitem.displayInDashboard  ? dashboardTile(navitem) : Container())),

/*
                dashboardTile('Calendar', Icons.calendar_month_rounded),
                dashboardTile('Routines', Icons.sports_gymnastics),
                dashboardTile('My Well-being', Icons.monitor_heart_outlined),
                dashboardTile('Library / Resources',Icons.my_library_books_outlined),
*/
                Padding(
                  /// Badges
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      color: HexColor.fromHex('#FF66b42c'), // green
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(children: <Widget>[

                      /*   Divider(
                        height: 10,
                        thickness: 2,
                        indent: 0.0,
                        color: HexColor.fromHex('#ffffff'),
                      ),
                     Padding(
                        padding: EdgeInsets.all(10.0),
                        child: GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(10),
                            childAspectRatio: 1,
                            children: collectedBadges(
                                Provider.of<core.UserProvider>(context).myBadges, context)
                        ),
                      ),*/
                    ]),
                  ),
                ),
              ]),
              bottomNavigationBar: bottomNavigation(context)
      );
    }
  }

Widget dashboardTile(NavigationItem item){
    return Card(child:
    ListTile(
      visualDensity: VisualDensity(vertical: VisualDensity.maximumDensity),
      title: Text(AppLocalizations.of(context)!.navitem(item.label)),
      trailing: item.icon,
      onTap: (){
        constants.Router.navigate(context,item.view);
      },
    ),
    );
}

  /* Widget list creator for collected badges */
  List<Widget> collectedBadges(collectedBadges, BuildContext context) {
    //  print('displaying '+collectedBadges.length.toString()+' collected badges');
    List<Widget> data = [];
    if (collectedBadges.isEmpty) return data;
    for (var badge in collectedBadges) {
      data.add(badgeIconDisplay(badge,context));
    }
    return data;
  }










}
