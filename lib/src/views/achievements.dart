import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:luen/src/objects/badge.dart';
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/providers/user_provider.dart';
import 'package:luen/src/util/app_url.dart';
//import 'package:luen/src/util/api_client.dart';
import 'package:luen/src/util/utils.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectmodel;
import 'package:luen/src/util/widgets.dart';
import 'package:luen/src/views/badge.dart';
import 'package:provider/provider.dart';

class AchievementsView extends StatefulWidget {
  final String viewTitle = 'achievements';
  final objectmodel.BadgeProvider badgeProvider = objectmodel.BadgeProvider();

  @override
  _AchievementsViewState createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView> {

  Map<String,LoadingState> _loadingStates = {};
  List<Badge> badgedata = [];
  int limit = 50;
  String? errormessage;

  _loadAvailableBadges(user) async{
    print('loading badges from server');
    final Map<String, String> params = {
      'limit': limit.toString(),
      'offset':'0',
      'application' : 'id='+AppUrl.appId.toString(),
      'fields': 'id,name,color,badgeimageurl,description,badgeimageurl,requiredbookcount,assertionBakedBadgeImageUrl,assertionCertificateAsPdfUrl',

      'api-key': user.token,
      'api_key': user.token,
      'sort': 'name',
    };
    try {
      List<Badge> badges =
      (await widget.badgeProvider.loadItems(params))
          .cast<Badge>();
      setState(() {
        _loadingStates['badges'] = LoadingState.DONE;
        badgedata.addAll(badges);
        print(badgedata.length.toString() + ' badges loaded!');


      });
    } catch (e, stack) {

      print('loadItems returned error $e\n Stack trace:\n $stack');
      errormessage = e.toString();
      if (_loadingStates['stations'] == LoadingState.LOADING) {
        setState(() => _loadingStates['stations'] = LoadingState.ERROR);
      }

    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      User user = Provider.of<UserProvider>(context, listen: false).user;

      _loadAvailableBadges(user);

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //User user = Provider.of<UserProvider>(context, listen: true).user;
    //List<Badge> collectedBadges = Provider.of<UserProvider>(context).myBadges;


/*
    bool isTester = false;
    if(user.data!=null) {
      if (user.data!['istester'] != null) {
        if (user.data!['istester'] == 'true') isTester = true;
      }
    }
*/

    return
      Scaffold(
        appBar: new AppBar(
            title: new Text(AppLocalizations.of(context)!.achievements),
            actions: [],
        ),
        body:
      Padding(
      padding: EdgeInsets.all(20.0),
      child:
      GridView.count(
          crossAxisCount:3,
          crossAxisSpacing:5,
          mainAxisSpacing:5,
          scrollDirection:Axis.vertical,
          shrinkWrap: true,
          padding:EdgeInsets.all(10),
          children:allBadges(),
      ),
    ), bottomNavigationBar: bottomNavigation(context,currentIndex: 2)
      );
  }
  /* Widget list creator for collected badges */
  List<Widget> allBadges()
  {

    List<Widget> data = [];
    if(this.badgedata.isEmpty) return data;
    for (var badge in this.badgedata) {
      data.add(badgeIconDisplay(badge));
    }
    return data;
  }

  Widget badgeIconDisplay(Badge badge)
  {
    return Container(
      height: 150,
      child:GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BadgeView(badge)),
          );
        },
        child:Column(

            children:[
              badge.badgeimageurl != null
                  ? FadeInImage.assetNetwork(
                fit: BoxFit.contain,
                width: double.infinity,
                height:60,
                placeholder: 'images/badge-placeholder.jpg',
                image: badge.badgeimageurl!,
              ) :
              FaIcon(
                  IconData(0xf091,
                      fontFamily: 'FontAwesomeSolid',
                      fontPackage: 'font_awesome_flutter'),
                  size: 60.0),
              SizedBox(height:5),
              Text(badge.name ?? '-',
                style: TextStyle(fontSize: 12),),
            ]
        ),
      ),
    );
  }

}