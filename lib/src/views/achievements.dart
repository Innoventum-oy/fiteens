import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fiteens/src/util/utils.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:fiteens/src/views/badge.dart';
import 'package:provider/provider.dart';
import 'package:core/core.dart' as core;

class AchievementsView extends StatefulWidget {
  final String viewTitle = 'achievements';
  final core.BadgeProvider badgeProvider = core.BadgeProvider();

  AchievementsView({super.key});

  @override
  AchievementsViewState createState() => AchievementsViewState();
}

class AchievementsViewState extends State<AchievementsView> {
  final Map<String, LoadingState> _loadingStates = {};
  List<core.Badge> badgedata = [];
  int limit = 50;
  String? errormessage;

  _loadAvailableBadges(user) async {
    final Map<String, String> params = {
      'limit': limit.toString(),
      'offset': '0',
      'application': 'id=${core.AppSettings().get('appId')}',
      'fields':
          'id,name,color,badgeimageurl,description,badgeimageurl,requiredbookcount',
      'api-key': user.token,
      'api_key': user.token,
      'sort': 'name',
    };
    try {
      List<core.Badge> badges =
          (await widget.badgeProvider.loadItems(params)).cast<core.Badge>();
      setState(() {
        _loadingStates['badges'] = LoadingState.done;
        badgedata.addAll(badges);
      });
    } catch (e) {
      errormessage = e.toString();
      if (_loadingStates['stations'] == LoadingState.loading) {
        setState(() => _loadingStates['stations'] = LoadingState.error);
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      core.User user = Provider.of<core.UserProvider>(context, listen: false).user;

      _loadAvailableBadges(user);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.achievements),
          actions: const [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            children: allBadges(),
          ),
        ),
        bottomNavigationBar: bottomNavigation(context, currentIndex: 2));
  }

  /* Widget list creator for collected badges */
  List<Widget> allBadges() {
    List<Widget> data = [];
    if (badgedata.isEmpty) return data;
    for (var badge in badgedata) {
      data.add(badgeIconDisplay(badge));
    }
    return data;
  }

  Widget badgeIconDisplay(core.Badge badge) {
    return SizedBox(
      height: 150,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BadgeView(badge)),
          );
        },
        child: Column(children: [
          badge.badgeimageurl != null
              ? FadeInImage.assetNetwork(
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 60,
                  placeholder: 'images/badge-placeholder.jpg',
                  image: badge.badgeimageurl!,
                )
              : const FaIcon(
                  IconData(0xf091,
                      fontFamily: 'FontAwesomeSolid',
                      fontPackage: 'font_awesome_flutter'),
                  size: 60.0),
          const SizedBox(height: 5),
          Text(
            badge.name ?? '-',
            style: const TextStyle(fontSize: 12),
          ),
        ]),
      ),
    );
  }
}
