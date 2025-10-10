import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fiteens/src/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fiteens/l10n/app_localizations.dart';
import 'package:core/core.dart' as core;
class ScoreList extends StatefulWidget {
  final core.ScoreProvider scoreprovider = core.ScoreProvider();

  ScoreList({super.key});

  @override
  ScoreListState createState() => ScoreListState();
}

class ScoreListState extends State<ScoreList> {
  List<core.Score> myScoreItems = [];
  core.User? user;

  int iteration = 1;
  int buildTime = 1;

  //int _pageNumber = 0;
  String? errorMessage;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<core.UserProvider>(context, listen: false).getScoreList();
    });
    super.initState();
  }

/*
  Relies on scorelist provided by userprovider:
  To update score call userprovider.getScorelist or userprovider.refreshUser
 */
  @override
  Widget build(BuildContext context) {
    //User user = Provider.of<UserProvider>(context,listen: false).user;
    myScoreItems = Provider.of<core.UserProvider>(context).myScore;
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.myPoints),
        ),
        body: scoreList(),
        bottomNavigationBar: bottomNavigation(context, currentIndex: 3));
  }

  Widget scoreList() {
    if (myScoreItems.isNotEmpty) {
      return ListView.builder(
          itemCount: myScoreItems.length,
          itemBuilder: (BuildContext context, int index) {
            return scoreListRow(myScoreItems[index]);
          });
    } else {
      return Text(AppLocalizations.of(context)!.scoreListIsEmpty);
    }
  }

  Widget scoreListRow(core.Score item) {
    return ListTile(
      //minLeadingWidth: 80,
      leading: Text(item.score.toString()),
      title: Text(
          (item.description ?? AppLocalizations.of(context)!.noDescription)),
      subtitle: Text(
          "${item.scorestatus ?? ''}\n${DateFormat('dd.MM.yyyy').format((item.scoredate ?? DateTime.now()))}",
          overflow: TextOverflow.ellipsis,
          maxLines: 10),
      isThreeLine: true,
    );
  }
}
