import 'dart:developer';

import 'package:core/core.dart';
import 'package:fiteens/src/widgets/popupdialog.dart';
import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/generated/l10n.dart';
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
  bool loaded = false;
  bool isLoadingNewCategory = false;
  int? currentActivityClassId;

  @override
  void initState(){
    super.initState();
    if(kDebugMode){
      log('Libraryscreen initState - loading activities');
    }
    currentActivityClassId = widget.activityClass.id;
    _loadActivities();
  }

  @override
  void didUpdateWidget(LibraryItemsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if the activity class has changed
    if (oldWidget.activityClass.id != widget.activityClass.id) {
      if (kDebugMode) {
        log('Activity class changed from ${oldWidget.activityClass.id} to ${widget.activityClass.id}');
      }
      setState(() {
        isLoadingNewCategory = true;
        currentActivityClassId = widget.activityClass.id;
      });
      _loadActivities();
    }
  }

  void _loadActivities() {
    Map<String,dynamic> params = {
      'activitystatus' : 'active',  // only load active items'
      //'sort' : 'attribute:name',
      'activityclass' : widget.activityClass.id.toString()
    };

    if (kDebugMode) {
      log('Loading activities for class ${widget.activityClass.id}');
    }

    Provider.of<ActivityProvider>(context,listen: false).getItems(params,reload: widget.refresh || loaded==false ? true : false).then((_) {
      if (mounted) {
        // Wait a brief moment to ensure provider has updated its state
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            setState(() {
              loaded = true;
              isLoadingNewCategory = false;
              if (kDebugMode) {
                log('Activities loaded for class ${widget.activityClass.id}');
              }
            });
          }
        });
      }
    }).catchError((error) {
      if (kDebugMode) {
        log('Error loading activities: $error');
      }
      if (mounted) {
        setState(() {
          loaded = true;
          isLoadingNewCategory = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    /// Provider provides us with the data
    ActivityProvider activityProvider = Provider.of<ActivityProvider>(context);

    // Show loading indicator if we're switching categories OR if provider is still loading
    if (isLoadingNewCategory || !loaded || activityProvider.loadingStatus != DataLoadingStatus.loaded) {
      if (kDebugMode) {
        log('Showing loading indicator - isLoadingNewCategory: $isLoadingNewCategory, loaded: $loaded, provider status: ${activityProvider.loadingStatus}');
      }
      return ScreenScaffold(
        title: "${AppLocalizations.of(context).library} - ${widget.activityClass.name}",
        navigationIndex: widget.navIndex,
        refresh: widget.refresh,
        onRefresh: (){
          if(kDebugMode) {
            log('reloading page');
          }
          constants.Router.navigate(context,'library',widget.navIndex,refresh: true);
        },
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading activities...'),
            ],
          ),
        ),
      );
    }

    Widget libraryView;
    if (activityProvider.loadingStatus == DataLoadingStatus.loaded) {

      if (activityProvider.list != null) {
        List<Activity>? items = activityProvider.list;

        if (kDebugMode && items != null) {
          log('Provider has ${items.length} items for class $currentActivityClassId');
        }

        libraryView = items != null && items.isNotEmpty ? ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index){
              final item = items[index];
              List<Widget> actions = [
                ElevatedButton(
                  onPressed: () async {
                    NavigatorState navigator = Navigator.of(context, rootNavigator: true);
                    if (item.id != null) {
                      dynamic result = await activityProvider.delete(item.id ?? 0);
                      log("result: $result");
                      if (result['status']=='success') {
                        setState(() {
                        items.removeAt(index);
                        if(navigator.canPop()) navigator.pop(false);
                      });
                      } else {
                        if(navigator.canPop()) navigator.pop(false);
                        notifyDialog('Failed to delete item',Text(result['error'] ?? 'Failed to delete item'),context);

                      }
                    }

                  },
                  child: const Text('Delete'),),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(false);
                  },
                  child: const Text('Cancel'),)
              ];
          return item.accesslevel>=20 ? Dismissible(
              key: Key(item.toString()),
              confirmDismiss: (direction) async {
                return await popupDialog("Delete item?",const Text("Item will be permanently deleted from the library, are you sure?"), context,actions: actions);

              },
              background: Container(
                  color:Colors.red,
                  padding: const EdgeInsets.only(right: 20.0),
                  alignment: Alignment.centerRight,
              child: const Text('Delete',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white))
              ),
              child:ActivityItem(item,navIndex: widget.navIndex,)
          ) : ActivityItem(item,navIndex: widget.navIndex);
        }) : Text(AppLocalizations.of(context).noActivitiesFound);
      }
      else {
        libraryView = Text(AppLocalizations.of(context).noActivitiesFound);
      }
    }
    else {
      if(kDebugMode){
        log('Provider still loading - status: ${activityProvider.loadingStatus}');
      }
      libraryView = const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(child: CircularProgressIndicator())
        ],
      );

    }
    return ScreenScaffold(
        title: "${AppLocalizations.of(context).library} - ${widget.activityClass.name}",
        navigationIndex: widget.navIndex,
        refresh: widget.refresh,

        onRefresh:(){
          if(kDebugMode) {
            log('reloading page');
          }

          constants.Router.navigate(context,'library',widget.navIndex,refresh: true);
        },
        child: libraryView
    );
    }

}