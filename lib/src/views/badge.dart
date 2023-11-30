// Single badge view
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fiteens/src/util/styles.dart';
import 'package:core/core.dart' as core;

class BadgeView extends StatefulWidget {
  final core.Badge _badge;

  const BadgeView(this._badge, {super.key});

  @override
  BadgeViewState createState() => BadgeViewState();
}

class BadgeViewState extends State<BadgeView> {
  //final ApiClient _apiClient = ApiClient();
  Map<String, dynamic>? map;
  List<core.Badge> myBadges = [];

  int iteration = 1;
  int buildtime = 1;

  //bool _visible = false;
  core.User? user;

  //dynamic _badgeDetails;

  notify(String text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool itemInMyBadges(List<core.Badge> badges, int? id) {
    final found = badges.where((badge) => badge.id == id);
    if (found.isNotEmpty) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<core.UserProvider>(context).user;
    myBadges = Provider.of<core.UserProvider>(context).myBadges;

    return Scaffold(
        //backgroundColor: primary,
        body: CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(),
            _buildContentSection(),
          ],
        ),
        bottomNavigationBar: bottomNavigation(context));
  }

  List<Widget> buttons(core.Badge badge) {
    List<Widget> buttons = [];
    buttons.add(Container());

    return buttons;
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
                  : const Image(
                      image: AssetImage('images/badge-placeholder.jpg')),
            ),
            // BottomGradient(),
            //_buildMetaSection(Badge)
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    core.Badge badgeObject = widget._badge;

    List<Widget> buttons = [];
    bool isAwarded = badgeObject.id != null
        ? itemInMyBadges(myBadges, badgeObject.id)
        : false;
    if (isAwarded) {
      buttons.add(Padding(
          padding: const EdgeInsets.all(20),
          child: Row(children: [
            const Icon(Icons.check),
            Text(AppLocalizations.of(context)!.youHaveThisBadge)
          ])));
    }

    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Container(
          decoration: const BoxDecoration(color: Color(0xff222128)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  badgeObject.name != null
                      ? badgeObject.name.toString()
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
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 8.0,
                  ),
                  Text(
                    badgeObject.description ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 13.0),
                  ),
                  ...buttons
                ]))
      ]),
    );
  }
}
