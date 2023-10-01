import 'dart:developer';

import 'package:core/core.dart';
import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

  @override
  Widget build(BuildContext context) {
    log('Building routinesscreen, refresh: ${widget.refresh}');
    return ScreenScaffold(
        title: AppLocalizations.of(context)!.routines_title,
        navigationIndex: widget.navIndex,
        refresh: widget.refresh ,
        onRefresh:(){
          if(kDebugMode) {
            log('reloading page');
          }
          setState(){

          }
          constants.Router.navigate(context,'routines',widget.navIndex,refresh: true);
          },
        child: RoutinesView(refresh: widget.refresh,));
  }
}

class RoutinesView extends StatefulWidget {
  RoutinesView({this.refresh=false,super.key});
  final bool refresh;
  @override
  State<RoutinesView> createState() => _RoutinesViewState();
}

class _RoutinesViewState extends State<RoutinesView> {

  @override
  void initState(){
    super.initState();
    log('Initing routinesview state, refresh: ${widget.refresh}');
    Map<String,dynamic> params = {};
    Provider.of<RoutineProvider>(context,listen: false).getItems(params,reload:widget.refresh);
  }

  @override
  Widget build(BuildContext context) {
    RoutineProvider routineProvider = Provider.of<RoutineProvider>(context);

    if (routineProvider.loadingStatus == DataLoadingStatus.loaded) {

      if (routineProvider.list != null) {
        List<Routine>? items = routineProvider.list;
        return items!=null ? ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index){
              return RoutinesScreenItem(items[index]);
            }) : Text(AppLocalizations.of(context)!.noRoutinesFound);
      }
      else {
        return defaultContent(Text(AppLocalizations.of(context)!.noRoutinesFound));
      }
    }
    return defaultContent(Row(children:[CircularProgressIndicator(),
      Text(routineProvider.loadingStatus.toString())]));
  }
Widget defaultContent(contentChild){
  return Padding(
      padding:EdgeInsets.all(30),
      child:Center(
          child:contentChild)

      );
}
}