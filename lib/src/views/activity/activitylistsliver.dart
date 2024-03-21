
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fiteens/src/util/utils.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fiteens/src/util/navigator.dart';
import 'package:core/core.dart' as core;

class ActivityListSliver extends StatefulWidget {
  final core.ActivityClass activityClass;

  const ActivityListSliver(this.activityClass, {super.key});

  @override
  ActivityListSliverState createState() => ActivityListSliverState();
}

class ActivityListSliverState extends State<ActivityListSliver> {
  Map<String, dynamic>? map;
  List<core.Activity> data = [];
  core.User? user;
  LoadingState _loadingState = LoadingState.loading;
  bool _isLoading = false;
  int iteration = 1;
  int buildTime = 1;
  int limit = 20;
  int count = 0;
  int _pageNumber = 0;
  String? errorMessage;

  notify(String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );

    /// Find the ScaffoldMessenger in the widget tree and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Calculate difference between now and given date
  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  /// Load next set of events
  _loadNextPage(user, activityclass,{refresh=false}) async {
    _isLoading = true;
    int offset = limit * _pageNumber;
   // DateTime now = DateTime.now();
    final Map<String, String> params = {
      'view':'activitylistsliver',
      'activityclass': activityclass.id.toString(),
      'activitystatus': 'active',
      'activitytype': 'activity',
      'grouping':'activity.id',
      'limit': limit.toString(),
      'offset': offset.toString(),
     // 'startfrom': DateFormat('yyyy-MM-dd').format(now),
      if(user.token !=null) 'api_key': user.token,
      'sort': 'name',
    };

    try {
      final core.ActivityProvider activityProvider = Provider.of<core.ActivityProvider>(context,listen:false);
      var nextActivities = await activityProvider.getItems(params,reload: refresh);
      setState(() {
        _loadingState = LoadingState.done;
        if (nextActivities.isNotEmpty) {
          data.addAll(nextActivities);

          if (nextActivities.length >= limit) {

            _isLoading = false;
            _pageNumber++;
          }
        }
        else {
        }
      });
    } catch (e) {
      _isLoading = false;
      errorMessage = e.toString();
      if (_loadingState == LoadingState.loading) {
        setState(() => _loadingState = LoadingState.error);
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      core.User user = Provider.of<core.UserProvider>(context, listen: false).user;

      _loadNextPage(user, widget.activityClass,refresh: true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    core.User user = Provider.of<core.UserProvider>(context, listen: false).user;

    //final core.ImageProvider imageProvider = Provider.of<core.ImageProvider>(context);
    return _getContentSection(user);
  }

  Widget _getContentSection(user) {
    switch (_loadingState) {
      case LoadingState.done:
        if(data.isEmpty) {
          return Container(
          padding: const EdgeInsets.all(20),
          child:
          ListTile(
            leading: const Icon(Icons.error,color:Colors.white),
            title: Text(
                AppLocalizations.of(context)!.noActivitiesFound,
                style:const TextStyle(color:Colors.white)),
          ),
        );
        }
        return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              if (!_isLoading && index > (data.length * 0.7)) {
                _loadNextPage(user, widget.activityClass);
              }

              return activityHorizontal(data[index]);
            });

      case LoadingState.error:
        //data loading returned error state
        return Align(
          alignment: Alignment.center,
          child: ListTile(
            leading: const Icon(Icons.error),
            title: Text(
                'Sorry, there was an error loading the data: $errorMessage'),
          ),
        );

      case LoadingState.loading:
        //data loading in progress
        return Align(
          alignment: Alignment.center,
          child: Center(
            child: ListTile(
              leading: const CircularProgressIndicator(),
              title: Text(AppLocalizations.of(context)!.loading,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
        );
      default:
        return const Text('No activities found in this category');
    }
  }

  Widget activityHorizontal(activity) {
    List<Widget> buttons = [];
    buttons.add(TextButton(
      child: Text(AppLocalizations.of(context)!.readMore),
      onPressed: () {
        /* open library view */
        goToActivity(context, activity);
      },
    ));
    buttons.add(const SizedBox(width: 8));

    if (activity.accesslevel >= 20) {
      //user has modify access
    }

    String dateinfo = activity.nexteventdate == null
        ? ''
        : (calculateDifference(activity.nexteventdate!) != 0
            ? DateFormat('kk:mm dd.MM.yyyy').format(activity.nexteventdate!)
            : AppLocalizations.of(context)!.today + DateFormat('kk:mm ').format(activity.startdate!));

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: InkWell(
            onTap: () => goToActivity(context, activity),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Card(
                    elevation: 18.0,
                    child: activity.coverpictureurl != null
                        ? Image.network(activity.coverpictureurl!,
                            width: 150, height: 230, fit: BoxFit.cover)
                        : widget.activityClass.coverpictureurl != null
                            ? Image.network(
                                widget.activityClass.coverpictureurl!,
                                width: 150,
                                height: 230,
                                fit: BoxFit.cover)
                            : const Icon(Icons.group_rounded, size: 150),
                  ),
                  Text(
                      (activity.name ?? AppLocalizations.of(context)!.unnamedActivity)!,
                      style: const TextStyle(color: Colors.white)),
                  Text(dateinfo, style: const TextStyle(color: Colors.white)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: buttons,
                  ),
                ])));
  }
}
