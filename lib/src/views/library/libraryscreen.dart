import 'dart:developer';

import 'package:core/core.dart';
import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'components/activityitem.dart';

class LibraryScreen extends StatefulWidget {
  final int navIndex;
  final bool refresh;
  const LibraryScreen({this.navIndex=4,this.refresh = false,super.key});

  @override
  State<StatefulWidget> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
        title: AppLocalizations.of(context)!.library,
        navigationIndex: widget.navIndex,
        refresh: widget.refresh,
        child: LibraryView(refresh: widget.refresh,));
  }
}

class LibraryView extends StatefulWidget {
  final bool refresh;
  const LibraryView({this.refresh=false,super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {

  Widget defaultContent = const CircularProgressIndicator();

  @override
  void initState(){
    super.initState();
    if(kDebugMode){
      log('Libraryscreen initState - loading activities');
    }
    Map<String,dynamic> params = {};
    Provider.of<ActivityProvider>(context,listen: false).getItems(params,reload: widget.refresh);
  }
  @override
  Widget build(BuildContext context) {

    /// Provider provides us with the data
    ActivityProvider activityProvider = Provider.of<ActivityProvider>(context);

    if (activityProvider.loadingStatus == DataLoadingStatus.loaded) {

      if (activityProvider.list != null) {
        List<Activity>? items = activityProvider.list;
        return items!=null ? ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index){
          return ActivityItem(items[index]);
        }) : Text(AppLocalizations.of(context)!.noActivitiesFound);
      }
      else {
        return Text(AppLocalizations.of(context)!.noActivitiesFound);
      }
    }
    else {
      /*if (!connection.appOnline) {
        defaultContent = Text(AppLocalizations.of(context)!.applicationOffline);
      }

       */
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(child: defaultContent)

        ],
      );

    }
  }

}