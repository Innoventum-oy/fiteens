import 'package:flutter/material.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectmodel;
import 'package:provider/provider.dart';

import '../objects/score.dart';
import '../objects/user.dart';
import '../providers/user_provider.dart';
import '../util/utils.dart';

class ScoreList extends StatefulWidget {
  final objectmodel.ScoreProvider scoreprovider = objectmodel.ScoreProvider();

  ScoreList();

  @override
  _ScoreListState createState() => _ScoreListState();
}

class _ScoreListState extends State<ScoreList> {

  List<Score> data =[];
  User? user;
  LoadingState _loadingState = LoadingState.DONE;
  //bool _isLoading = false;
  int iteration =1;
  int buildTime = 1;
  int limit = 20;
  //int _pageNumber = 0;
  String? errorMessage;

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      super.initState();
    });

  }
  @protected
  //@mustCallSuper
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<UserProvider>(context,listen: false).user;

    return Placeholder();
  }
}