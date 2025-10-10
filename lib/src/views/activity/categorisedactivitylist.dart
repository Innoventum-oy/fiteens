import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/l10n/app_localizations.dart'; // important
import 'package:fiteens/src/util/styles.dart';
import 'package:fiteens/src/util/utils.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:fiteens/src/views/activity/activitylistsliver.dart';
import 'package:provider/provider.dart';
import 'package:core/core.dart' as core;

class CategorisedActivityList extends StatefulWidget {
  final String viewType;

  const CategorisedActivityList( {super.key, this.viewType = 'all'});

  @override
  CategorisedActivityListState createState() =>
      CategorisedActivityListState();
}

class CategorisedActivityListState extends State<CategorisedActivityList> {
  Map<String, dynamic>? map;
  List<core.ActivityClass> data = [];
  core.User? user;
  LoadingState _loadingState = LoadingState.loading;
  bool _isLoading = false;
  int iteration = 1;
  int buildtime = 1;
  int limit = 20;
  int _pageNumber = 0;
  String? errormessage;

  notify(String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  // Load next set of  activityclasses
  _loadNextPage(user) async {
    _isLoading = true;
    int offset = limit * _pageNumber;

    final Map<String, String> params = {
      'loadmethod' :'loadActivityClassesWithActivities',
      'limit': limit.toString(),
      'offset': offset.toString(),
      if(user.token!=null ) 'api_key': user.token,

      'sort': 'name',
    };
    if(kDebugMode) {
      print("categorised activitylist viewtype: ${widget.viewType}");
    }
    core.ActivityClassProvider activityClassProvider = core.ActivityClassProvider();


    try {
      var activityCategories = await activityClassProvider.loadItems(params);
      setState(() {
        _loadingState = LoadingState.done;
        data.addAll(activityCategories);
        if(activityCategories.length >= limit) {
          _isLoading = false;
          _pageNumber++;
        }
      });
    } catch (e) {
      _isLoading = false;
      errormessage = e.toString();
      if (_loadingState == LoadingState.loading) {
        setState(() => _loadingState = LoadingState.error);
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      core.User user = Provider
          .of<core.UserProvider>(context, listen: false)
          .user;
      _loadNextPage(user);
    });
    super.initState();
  }

  @override
  @protected
  @mustCallSuper
  void dispose() {
    _loadingState = LoadingState.loading;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    core.User user = Provider
        .of<core.UserProvider>(context, listen: false)
        .user;

    bool isTester = false;
    if(user.data!=null) {
      if (user.data!['istester'] != null) {
        if (user.data!['istester'] == 'true') isTester = true;
      }
    }

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.activities),
          actions: [
            if(isTester) IconButton(
                icon: const Icon(Icons.bug_report),
                onPressed:(){feedbackAction(context,user); }
            ),
      IconButton(
      icon: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            data = [];
            _pageNumber = 0;
            _loadingState = LoadingState.loading;
            _isLoading = false;
            /// Clear local data
            core.FileStorage().clear('activities');
            _loadNextPage(user);
          });
        }),]
      ),
      body: _getContentSection(user),
        bottomNavigationBar: bottomNavigation(context,currentIndex:1)
      );
  }

  Widget _getContentSection(user) {
    switch (_loadingState) {
      case LoadingState.done:
      //data loaded
        return data.isEmpty ? Container(
            padding: const EdgeInsets.all(20),
            child:
            ListTile(
              leading: const Icon(Icons.error,color:Colors.white),
              title: Text(
                  AppLocalizations.of(context)!.noActivitiesFound,
                  style:const TextStyle(color:Colors.white)),
            ),
            ) :
        CustomScrollView(
            slivers: <Widget>[
              SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (!_isLoading && index > (data.length * 0.7) && data.length==limit && _pageNumber>0) {

                _loadNextPage(user);
              }
             if(data.isNotEmpty) {
               return activityClassView(data[index]);
             } else {
               return Container();
             }
            },
            childCount: data.length))]
            );
      case LoadingState.error:
      //data loading returned error state
        return Align(
          alignment: Alignment.center,
          child: ListTile(
            leading: const Icon(Icons.error),
            title: Text(
                'Sorry, there was an error loading the activity classes : $errormessage'),
          ),
        );

      case LoadingState.loading:
      //data loading in progress
    //  if(!_isLoading) _loadNextPage(user);
        return Align(
          alignment: Alignment.center,
          child: Center(
            child: ListTile(
              leading: const CircularProgressIndicator(),
              title: Text(AppLocalizations.of(context)!.loading,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white)
              ),
            ),
          ),
        );
      default:
        return Container();
    }
  }

  Widget activityClassView(activityClass) {
    return
      Container(
        decoration: const BoxDecoration(color: Color(0xff222128)),
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(activityClass.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 400.0,
                  decoration: const BoxDecoration(color: primaryDark),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:
                      ActivityListSliver( activityClass),
                  ),
                ),
              ]
          ),
        ),
      );
  }


}
