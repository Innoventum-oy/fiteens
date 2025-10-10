import 'dart:developer';

import 'package:core/core.dart';
import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:fiteens/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../util/constants.dart' as constants;
import 'components/routinesscreenitem.dart';

/// Creates list of routines 
class RoutinesScreen extends StatefulWidget {
  final int navIndex;
  final bool refresh;
  const RoutinesScreen({this.navIndex=2,this.refresh=false,super.key});

  @override
  State<StatefulWidget> createState() => _RoutinesScreenState();
}

class _RoutinesScreenState extends State<RoutinesScreen> {

  bool loaded = false;
  @override
  void initState() {
    super.initState();
    log('Initing routinesview state, refresh: ${widget.refresh}');
    Map<String, dynamic> params = {
      'accesslevel': 'read'
    };
    RoutineProvider routineProvider = Provider.of<RoutineProvider>(
        context, listen: false);
    routineProvider.getItems(params,reload:widget.refresh || loaded == false ? true : false);
  loaded = true;
  }


  @override
  Widget build(BuildContext context) {

    RoutineProvider routineProvider = Provider.of<RoutineProvider>(context);
//    routineProvider.language = Localizations.localeOf(context).toString();
    Widget routineView = defaultContent(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:[
      const CircularProgressIndicator(),
      Text(AppLocalizations.of(context)!.loading)])
    );
    if (loaded) {

      if (routineProvider.list != null && routineProvider.list?.length !=null) {
        List<Routine>? items = routineProvider.list;
        routineView = items!=null ? ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index){
              final item = items[index];
              return Dismissible(
                  key: Key(item.toString()),
              onDismissed: (direction){
              setState(()
              {
                items.removeAt(index);
              });
              },
                  background: Container(color:Colors.red),
              child:RoutinesScreenItem(item)
              );
            }) : Text(AppLocalizations.of(context)!.noRoutinesFound);
      }
      else {
        routineView = defaultContent(Text(AppLocalizations.of(context)!.noRoutinesFound));
      }
    }

    return ScreenScaffold(
        title: AppLocalizations.of(context)!.routines_title,
        navigationIndex: widget.navIndex,
        refresh: widget.refresh ,
        onRefresh:(){
          if(kDebugMode) {
            log('reloading page');
          }

          constants.Router.navigate(context,'routines',widget.navIndex,refresh: true);
        },
        child: routineView);
  }
  }
Widget defaultContent(contentChild){
  return Padding(
      padding:const EdgeInsets.all(30),
      child:Center(
          child:contentChild)

      );

}