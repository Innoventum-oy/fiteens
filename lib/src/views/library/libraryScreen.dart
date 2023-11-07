import 'dart:developer';

import 'package:core/core.dart';
import 'package:fiteens/src/views/library/components/activityclass.dart';
import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../util/constants.dart' as constants;

class LibraryScreen extends StatefulWidget {
  final int navIndex;
  final bool refresh;
  const LibraryScreen({this.navIndex=4,this.refresh = false,super.key});

  @override
  State<StatefulWidget> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {

  Widget defaultContent = const CircularProgressIndicator();

  @override
  void initState(){
    super.initState();
    if(kDebugMode){
      log('Libraryscreen initState - loading activity classes');
    }
    Map<String,dynamic> params = {
      //'activitystatus' : 'active',  // only load active items
    };
    Provider.of<ActivityClassProvider>(context,listen: false).getItems(params,reload: widget.refresh);
  }

  @override
  Widget build(BuildContext context) {

    /// Provider provides us with the data
    ActivityClassProvider activityClassProvider = Provider.of<ActivityClassProvider>(context);
    Widget libraryView;
    if (activityClassProvider.loadingStatus == DataLoadingStatus.loaded) {

      if (activityClassProvider.list != null) {
        List<ActivityClass>? items = activityClassProvider.list;
        libraryView = items != null ? GridView.builder(
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
        libraryView = Text(AppLocalizations.of(context)!.libraryIsEmpty);
      }
    }
    else {
      /*if (!connection.appOnline) {
        defaultContent = Text(AppLocalizations.of(context)!.applicationOffline);
      }

       */
      libraryView = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(child: defaultContent)

        ],
      );

    }
    return ScreenScaffold(
        title: AppLocalizations.of(context)!.library,
        navigationIndex: widget.navIndex,
        refresh: widget.refresh,

        onRefresh:(){
          if(kDebugMode) {
            log('reloading page');
          }
          setState(){

          }
          constants.Router.navigate(context,'library',widget.navIndex,refresh: true);
        },
        child: libraryView
    );
  }

}