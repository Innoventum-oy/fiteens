import 'dart:developer';

import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'activityclass.dart';

class ChallengesTab extends StatefulWidget{
    final bool refresh;
    final int navIndex;
  const ChallengesTab({this.navIndex=4,super.key,this.refresh =false});
  @override
  _ChallengesTabState createState() => _ChallengesTabState();
}
class _ChallengesTabState extends State<ChallengesTab> with AutomaticKeepAliveClientMixin<ChallengesTab>{

  bool loaded = false;
  Widget defaultContent = const CircularProgressIndicator();

  @override
  void initState(){
    super.initState();
    if(kDebugMode){
      log('challengesTab initState - loading activity classes');
    }
    // Load activity classes from API
    Map<String,dynamic> params = {
      //'activitystatus' : 'active',  // only load active items
    };
    Provider.of<ActivityClassProvider>(context,listen: false).getItems(params,reload: widget.refresh || !loaded ? true : false).then((value) => loaded= true);
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget challengesTabContent;
    /// Provider provides us with the data
    ActivityClassProvider activityClassProvider = Provider.of<ActivityClassProvider>(context);
    if (activityClassProvider.loadingStatus == DataLoadingStatus.loaded) {

      if (activityClassProvider.list != null) {
        List<ActivityClass>? items = activityClassProvider.list;
        challengesTabContent = items != null ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 2,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              // Item rendering
              ActivityClass item = items[index];
              return Card(child:ActivityClassItem(
                navIndex: widget.navIndex,
                activityClass: item,

              ));
            }) : Text(AppLocalizations.of(context)!.libraryIsEmpty);
      }
      else {
        challengesTabContent = Text(AppLocalizations.of(context)!.libraryIsEmpty);
      }
    }
    else {

      challengesTabContent  = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(child: defaultContent)

        ],
      );

    }
    return  challengesTabContent ;
  }

  @override
  bool get wantKeepAlive => true;
}