import 'dart:developer';

import 'package:core/core.dart';
import 'package:fiteens/src/widgets/popupdialog.dart';
import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../util/constants.dart' as constants;
import '../../widgets/notifydialog.dart';
import 'components/activityitem.dart';

class LibraryItemsScreen extends StatefulWidget {
  final int navIndex;
  final bool refresh;
  final ActivityClass activityClass;
  const LibraryItemsScreen(this.activityClass,{this.navIndex=4,this.refresh = false,super.key});

  @override
  State<StatefulWidget> createState() => _LibraryItemsScreenState();
}

class _LibraryItemsScreenState extends State<LibraryItemsScreen> {

  Widget defaultContent = const CircularProgressIndicator();

  @override
  void initState(){
    super.initState();
    if(kDebugMode){
      log('Libraryscreen initState - loading activities');
    }
    Map<String,dynamic> params = {
    'activitystatus' : 'active',  // only load active items
      'activityclass' : widget.activityClass.id.toString()
    };
    Provider.of<ActivityProvider>(context,listen: false).getItems(params,reload: widget.refresh);
  }

  @override
  Widget build(BuildContext context) {

    /// Provider provides us with the data
    ActivityProvider activityProvider = Provider.of<ActivityProvider>(context);
    Widget libraryView;
    if (activityProvider.loadingStatus == DataLoadingStatus.loaded) {

      if (activityProvider.list != null) {
        List<Activity>? items = activityProvider.list;
        libraryView = items!=null ? ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index){
              final item = items[index];
              List<Widget> actions = [
                ElevatedButton(
                  onPressed: () async {
                    if (item.id != null) {
                      dynamic result = await activityProvider.delete(item.id ?? 0);
                      log("result: $result");
                      if (result['status']=='success') setState(() {
                        items.removeAt(index);
                        //Navigator.of(context, rootNavigator: true).pop(true);
                        if(Navigator.of(context, rootNavigator: true).canPop()) Navigator.of(context, rootNavigator: true).pop(false);
                      });
                      else {
                        if(Navigator.of(context, rootNavigator: true).canPop()) Navigator.of(context, rootNavigator: true).pop(false);
                        notifyDialog('Failed to delete item',Text(result['error'] ?? 'Failed to delete item'),context);

                      }
                    }

                  },
                  child: Text('Delete'),),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(false);
                  },
                  child: Text('Cancel'),)
              ];
          return item.accesslevel>=20 ? Dismissible(
              key: Key(item.toString()),
              confirmDismiss: (direction) async {
                return await popupDialog("Delete item?",Text("Item will be permanently deleted from the library, are you sure?"), context,actions: actions);

              },
              background: Container(
                  color:Colors.red,
                  padding: EdgeInsets.only(right: 20.0),
                  alignment: Alignment.centerRight,
              child: Text('Delete',
                  textAlign: TextAlign.right,
                  style: new TextStyle(color: Colors.white))
              ),
              child:ActivityItem(item,navIndex: widget.navIndex,)
          ) : ActivityItem(item,navIndex: widget.navIndex);
        }) : Text(AppLocalizations.of(context)!.noActivitiesFound);
      }
      else {
        libraryView = Text(AppLocalizations.of(context)!.noActivitiesFound);
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
        title: "${AppLocalizations.of(context)!.library} - ${widget.activityClass.name}",
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