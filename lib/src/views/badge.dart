// Single badge view
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:luen/src/objects/badge.dart';
import 'package:luen/src/objects/user.dart';

import 'package:luen/src/providers/user_provider.dart';
//import 'package:luen/src/util/utils.dart';
import 'package:luen/src/util/widgets.dart';
import 'package:provider/provider.dart';
import 'package:luen/src/util/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class BadgeView extends StatefulWidget {
  final Badge _badge;


  BadgeView(this._badge);

  @override
  _BadgeViewState createState() => _BadgeViewState();
}

class _BadgeViewState extends State<BadgeView> {
  //final ApiClient _apiClient = ApiClient();
  Map<String, dynamic>? map;
  List<Badge> myBadges=[];


  int iteration = 1;
  int buildtime = 1;
  //bool _visible = false;
  User? user;
  //dynamic _badgeDetails;


   notify(String text) {
    final snackBar = SnackBar(
      content: Text(text,style: TextStyle(color:Colors.white),),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



  bool itemInMyBadges(List<Badge> badges,int? id)
  {
    final found = badges.where((badge) =>badge.id == id);
    if(found.isNotEmpty) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding Badge view');
    this.user = Provider.of<UserProvider>(context).user;
    this.myBadges = Provider.of<UserProvider>(context).myBadges;

    return Scaffold(
        backgroundColor: primary,
        body: CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(),
            _buildContentSection(),
          ],
        ),
        bottomNavigationBar: bottomNavigation(context));
  }



  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 240.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: "Badge-Tag-${widget._badge.id}",
              child: widget._badge.badgeimageurl != null
                  ? FadeInImage.assetNetwork(
                fit: BoxFit.contain,
                width: double.infinity,

                placeholder: 'images/badge-placeholder.jpg',
                image: widget._badge.badgeimageurl!,
              )
                  : Image(
                  image: AssetImage('images/badge-placeholder.jpg')),
            ),
          //  BottomGradient(),
            //_buildMetaSection(Badge)
          ],
        ),
      ),
    );
  }


  Widget _buildContentSection() {
    Badge badge = widget._badge;

    print('building ContentSection for badge id '+badge.id.toString()+'/'+widget._badge.id.toString());

    List<Widget> buttons = [];
    bool isAwarded = badge.id != null ? itemInMyBadges(this.myBadges,badge.id) : false;
    if(isAwarded) {
      buttons.add(
          Padding(padding: EdgeInsets.all(20),
              child: Row(
                  children: [
                    Icon(

                        Icons.check
                    ),
                    Text(AppLocalizations.of(context)!.youHaveThisBadge)
                  ]
              )
          )
      );

     if(widget._badge.badgeimageurl != null) buttons.add(
        ElevatedButton(
            onPressed: () {
              print('launching url '+(badge.assertionBakedBadgeImageUrl ??''));
              launchUrl(Uri.parse(badge.assertionBakedBadgeImageUrl ?? ''),mode:LaunchMode.inAppWebView);
            },
            child: Text(AppLocalizations.of(context)!.downloadOpenBadge,
              textAlign: TextAlign.left,)
        ),
      );
      buttons.add(
        ElevatedButton(
            onPressed: () {
              print('launching url '+(badge.assertionCertificateAsPdfUrl??''));
              launchUrl(Uri.parse(badge.assertionCertificateAsPdfUrl ?? ''));
            },
            child: Text(AppLocalizations.of(context)!.downloadCertificate,
              textAlign: TextAlign.left,)
        ),
      );
    }
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Container(
          decoration: BoxDecoration(color: const Color(0xff222128)),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  badge.name != null
                      ? badge.name.toString()
                      : AppLocalizations.of(context)!.unnamed,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children:[
                  Container(
                    height: 8.0,
                  ),
                  Text(badge.description ??'',
                    style:
                    const TextStyle(color: Colors.white, fontSize: 13.0),
                  ),
                  ...buttons
                ]   )
        )


      ]),
    );
  }


}
