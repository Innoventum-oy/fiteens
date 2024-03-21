import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:core/core.dart' as core;
import 'package:fiteens/src/views/webpage/webpagetextcontent.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:fiteens/src/views/user/loginform.dart';
import '../../util/constants.dart';
import 'components/achievements.dart';
import 'components/badgeicondisplay.dart';
import 'components/usertile.dart';
import '../../util/constants.dart' as constants;

class DashBoard extends StatefulWidget {
  final String viewTitle = 'dashboard';
  final int navIndex;
  final bool refresh;

  const DashBoard({this.navIndex = 0, this.refresh = false, super.key});

  @override
  DashBoardState createState() => DashBoardState();
}

class DashBoardState extends State<DashBoard> {
  int buildIteration = 1;

  core.User user = core.User();
  List<core.Badge> badges = [];
  bool loginPopupDisplayed = false;
  String? errorMessage;
  core.WebPage? page;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      buildIteration = 1;
      user = Provider.of<core.UserProvider>(context, listen: false).user;

      ///TODO: change to get instead of load, only reload on refresh
      Provider.of<core.UserProvider>(context, listen: false).getBadgeList();
      Provider.of<core.WebPageProvider>(context, listen: false).clear();
      Provider.of<core.WebPageProvider>(context, listen: false).getItems({
        'language': Localizations.localeOf(context).toString(),
        'commonname': widget.viewTitle,
        'fields': 'id,commonname,pagetitle,textcontents,thumbnailurl',
      });

      final Map<String, dynamic> badgeParams = {
        //'fields' : 'title,description,coverpictureurl,level,identifier',
        'requiredactivities': "gt:0",
        'sort': 'requiredactivities',
      };
      Provider.of<core.BadgeProvider>(context, listen: false)
          .getItems(badgeParams);

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
    buildIteration++;

    user = Provider.of<core.UserProvider>(context).user;
    badges = (Provider.of<core.BadgeProvider>(context).list ?? []);
    page = Provider.of<core.WebPageProvider>(context).current;
    if(kDebugMode) {
      log('building dasboard state($buildIteration), ${badges
          .length} badges,available score: ${user.getValue('availablescore')} activity count ${user.getValue('activitycount')}');
    }

    /// open login if user token is not found
    if (user.token == null) {
      //   print('user token not found, pushing named route /login');
      return const Login();
    } else {
      bool hasInfoPage = page != null &&
              page!.id != null &&
              page.runtimeType.toString() == 'WebPage'
          ? true
          : false;

      return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.appName),
            elevation: 0.1,
            actions: [
              //Info page button
              if (hasInfoPage)
                IconButton(
                    icon: const Icon(Icons.info_outline_rounded),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ContentPageView(widget.viewTitle,
                            providedPage: page),
                      ));
                    }),

              //Refresh button
              IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () async {
                    Provider.of<core.UserProvider>(context, listen: false)
                        .refreshUser();
                  }),
              IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    UserProvider userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    User loggedInUser = userProvider.user;
                    await Provider.of<AuthProvider>(context, listen: false)
                        .logout(loggedInUser);
                    userProvider.clearCurrentUser();
                    setState(() {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    });
                  }),
              //User card link
            ],
          ),
          body: ListView(children: <Widget>[
            userTile(user, context),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Card(
                    elevation: 3.0,
                    child: achievements(user, badges, context))),
            ...navItems.map((navItem) => (navItem.displayInDashboard
                ? dashboardTile(navItem)
                : Container())),
            if (Provider.of<core.UserProvider>(context).myBadges.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!.collectedBadges,
                            style: const TextStyle(fontSize: 20),
                          ),
                          GridView.count(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 5,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(10),
                              childAspectRatio: 1,
                              children: collectedBadges(
                                  Provider.of<core.UserProvider>(context)
                                      .myBadges,
                                  context)),
                        ]),
                  ),
                ),
              ),
          ]),
          bottomNavigationBar:
              bottomNavigation(context, currentIndex: widget.navIndex));
    }
  }

  Widget dashboardTile(NavigationItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Card(
        elevation: 3.0,
        child: ListTile(
          visualDensity: const VisualDensity(vertical: VisualDensity.maximumDensity),
          title: Text(
            AppLocalizations.of(context)!.navitem(item.label),
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          trailing: item.icon,
          onTap: () {
            constants.Router.navigate(context, item.view, item.navigationIndex);
          },
        ),
      ),
    );
  }

  /* Widget list creator for collected badges */
  List<Widget> collectedBadges(collectedBadges, BuildContext context) {
    List<Widget> data = [];
    if (collectedBadges.isEmpty) return data;
    for (var badge in collectedBadges) {
      data.add(badgeIconDisplay(badge, context));
    }
    return data;
  }
}
