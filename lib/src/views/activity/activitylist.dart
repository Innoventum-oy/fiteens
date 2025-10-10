import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/l10n/app_localizations.dart'; // important
import 'package:fiteens/src/util/utils.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:fiteens/src/views/activity/activitylist_item.dart';
import 'package:core/core.dart' as core;
import 'package:provider/provider.dart';

class ActivityList extends StatefulWidget {
  final String viewTitle = 'activitylist';
  final core.ActivityProvider activityProvider;
  final core.ImageProvider imageProvider;
  final String viewType;
  const ActivityList(this.activityProvider,this.imageProvider,{super.key, this.viewType='all'});
  @override
  ActivityListState createState() => ActivityListState();
}

class ActivityListState extends State<ActivityList>  {

  Map<String,dynamic>? map;
  List<core.Activity> data =[];
  core.User? user;
  LoadingState _loadingState = LoadingState.loading;
  bool _isLoading = false;
  int iteration =1;
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

  _loadNextPage(user) async {
    _isLoading = true;
    int offset = limit * _pageNumber;
    // DateTime now = DateTime.now();

    final Map<String, String> params = {
      'view':'activitylist',
      'activitystatus': 'active',
      'limit' : limit.toString(),
      'offset' : offset.toString(),
      'api_key':user.token,

    };

    switch(widget.viewType)
    {
      case 'locations':
        params['activitytype'] = 'location';
        params['accesslevel']='modify';
        params['sort'] = 'name';
        params['grouping']='activity.id';
        break;
      case 'own':
        params['activitytype'] = 'activity';
        params['accesslevel']='modify';
     //   params['startfrom'] = DateFormat('yyyy-MM-dd').format(now);
        params['grouping']='activity.id';
        //   params['limit']='NULL';
      break;
      default:
        params['activitytype'] = 'activity';
    //    params['startfrom'] = DateFormat('yyyy-MM-dd').format(now);
        params['sort'] ='name';
        params['grouping']='activity.id';


    }
    try {

      var nextActivities =
      await widget.activityProvider.loadItems(params);
      setState(() {
        _loadingState = LoadingState.done;
        if(nextActivities.isNotEmpty) {
          data.addAll(nextActivities);
          if(kDebugMode) {
            print('${data.length} activities currently loaded!');
          }
          _isLoading = false;
          _pageNumber++;
        }
        else
          {if(kDebugMode) {
            print('no more activities were found');
          }
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
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      core.User user = Provider.of<core.UserProvider>(context,listen: false).user;

      _loadNextPage(user);
    });
  super.initState();

  }

  @override
  Widget build(BuildContext context){


  core.User user = Provider.of<core.UserProvider>(context,listen: false).user;
  bool isTester = false;
  if(user.data!=null) {
    if (user.data!['istester'] != null) {
      if (user.data!['istester'] == 'true') isTester = true;
    }
  }

  return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.viewType=='locations' ? AppLocalizations.of(context)!.locations : AppLocalizations.of(context)!.activities),
          actions: [
          if(isTester) IconButton(
      icon: const Icon(Icons.bug_report),
    onPressed:(){feedbackAction(context,user); }
    ),
    ]
    ),
      body: _getContentSection(user),
      bottomNavigationBar: bottomNavigation(context)
    );
  }

  Widget _getContentSection(user) {
   // User user = Provider.of<UserProvider>(context).user;

    switch (_loadingState) {
      case LoadingState.done:

        //data loaded
        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              if (!_isLoading && index > (data.length * 0.7)) {
                _loadNextPage(user);
              }

              return ActivityListItem(data[index]);
            });
      case LoadingState.error:
        //data loading returned error state
        return Align(alignment:Alignment.center,
            child:ListTile(
              leading: const Icon(Icons.error),
              title: Text('Sorry, there was an error loading the data: $errormessage'),
            ),
        );

      case LoadingState.loading:
        //data loading in progress
        return Align(alignment:Alignment.center,
          child:Center(
            child:ListTile(
              leading:const CircularProgressIndicator(),
              title: Text(AppLocalizations.of(context)!.loading,textAlign: TextAlign.center),
          ),
          ),
        );
      default:
        return Container();
    }
  }

}