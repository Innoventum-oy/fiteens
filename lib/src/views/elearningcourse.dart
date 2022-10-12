import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:luen/src/objects/badge.dart';
import 'package:luen/src/objects/elearningcourse.dart';
import 'package:luen/src/objects/librarycollection.dart';
import 'package:luen/src/objects/webpage.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectmodel;
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/providers/user_provider.dart';
import 'package:luen/src/util/widgets.dart';
import 'package:luen/src/views/badge.dart';
import 'package:luen/src/views/stations.dart';
import 'package:luen/src/providers/webpageprovider.dart';
//import 'dart:async';
import 'package:provider/provider.dart';
import 'package:luen/src/util/styles.dart';
import 'package:luen/src/util/utils.dart';
import 'package:luen/src/views/utilviews.dart';
import 'package:luen/src/views/libraryitemlist_horizontal.dart';

class ElearningCourseView extends StatefulWidget {
  final String viewTitle = 'station';
  final int? elearningCourseId;

  final objectmodel.ElearningCourseProvider courseProvider;
  //final objectmodel.LibraryCollectionProvider collectionProvider;
  final objectmodel.ImageProvider imageProvider;
  final objectmodel.LibraryItemProvider libraryItemProvider = objectmodel.LibraryItemProvider();
  final objectmodel.BadgeProvider badgeProvider = objectmodel.BadgeProvider();

  ElearningCourseView(
      this.elearningCourseId,this.courseProvider, this.imageProvider);

  @override
  _CourseViewState createState() => _CourseViewState();
}

class _CourseViewState extends State<ElearningCourseView> {

  //final ApiClient _apiClient = ApiClient();
  Map<String, dynamic>? map;
  ElearningCourse course = ElearningCourse();
  LibraryCollection collection = LibraryCollection();
  LoadingState _loadingState = LoadingState.WAITING;
  int iteration = 1;
  int buildtime = 1;

  Map<String,dynamic> stationStatus = {};
  User? user;
  Badge? requiredBadge;
  String appbarTitle = 'Asema';
  WebPage page = new WebPage();

  refreshView() async {
    print('Refreshing view');


    Provider.of<UserProvider>(context, listen: false).refreshUser();
    Provider.of<UserProvider>(context, listen: false).getBookList();

    setState(() {

      //collection = LibraryCollection();
      _loadingState = LoadingState.WAITING;
      _loadCourse(this.user);
    });
  }

  notify(String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
/* load related page */
  _loadWebPage(user)async {
    print('calling loaditem for webpage '+widget.viewTitle);
    await Provider.of<WebPageProvider>(context,listen:false).loadItem({
      'language': Localizations.localeOf(context).toString(),
      'commonname': widget.viewTitle,
      'fields': 'id,commonname,pagetitle,textcontents,thumbnailurl',
      if (user.token != null) 'api_key': user.token,
    });
    setState(() {

      this.page = Provider.of<WebPageProvider>(context, listen: true).page;
    });

  }
  @override
  void initState() {
    super.initState();
    _loadingState = LoadingState.WAITING;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //this.user = Provider.of<UserProvider>(context, listen: false).user;

      _loadCourse(this.user);
      _loadWebPage(this.user);
    });


  }

  @protected
  //@mustCallSuper
  void dispose() {
    _loadingState = LoadingState.WAITING;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.user = Provider
        .of<UserProvider>(context, listen: true)
        .user;
    if (course.id == null && _loadingState != LoadingState.ERROR && _loadingState != LoadingState.LOADING) {
      setState(() {

        _loadCourse(this.user);
        _loadingState = LoadingState.LOADING;
      });
    }
    bool isTester = false;
    if(this.user!.data!=null) {

      if (this.user!.data!['istester'] != null) {
        if (this.user!.data!['istester'] == 'true') isTester = true;
      }
    }

    switch (_loadingState) {
      case LoadingState.DONE:
        return Scaffold(
            appBar: AppBar(
              // automaticallyImplyLeading: true,
                primary:true,
                title: Text(appbarTitle),
                leading: IconButton(icon: Icon(Icons.arrow_back_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  IconButton(
                      icon:Icon(Icons.list),
                      tooltip:AppLocalizations.of(context)!.stationList,
                      onPressed:(){
                        Navigator.of(context)
                            .pushAndRemoveUntil(MaterialPageRoute(
                            builder: (context) =>
                                StationsView(widget.courseProvider, widget.imageProvider)), (Route<dynamic> route) => false);
                      }
                  ),
                  if(isTester) IconButton(
                      icon: Icon(Icons.bug_report),
                      onPressed:(){feedbackAction(context,this.user!); }
                  ),
                  IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed:(){
                        this.refreshView();

                      }
                  ),
                ]
            ),
            backgroundColor: primary,
            body: CustomScrollView(
              slivers: <Widget>[
                _buildAppBar(course),
                ..._buildContentSection(course),
              ],
            ),
            bottomNavigationBar: bottomNavigation(context)
        );

      case LoadingState.ERROR:
      //return error information
        return Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: true,
              primary:true,
              title: Text(appbarTitle),
              leading: IconButton(icon: Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: this.refreshView()),
              ]
          ),
          body: Center(
              child:

              Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    Text(AppLocalizations.of(context)!.couldNotLoadStation),
                    IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          print('Refreshing elearningcourse.dart view');
                          setState(() {
                            _loadingState = LoadingState.LOADING;
                            _loadCourse(user);
                          });
                        })
                  ]
              )
          ),
        );
      case LoadingState.WAITING:
      case LoadingState.LOADING:
      //data loading in progress
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(appbarTitle),
            leading: IconButton(icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

          ),
          body: Align(
            alignment: Alignment.center,
            child: Center(
              child: ListTile(
                leading: CircularProgressIndicator(),
                title: Text(AppLocalizations.of(context)!.loading,
                    textAlign: TextAlign.center),
              ),
            ),
          ),
        );
      default:
        return Container();
    }
  }
/*
  List<Widget> buttons(LibraryCollection collection) {

    List<Widget> buttons = [];
    buttons.add(Container());
    if (collection.accesslevel >= 20) {}
    return buttons;
  }
*/
  Widget _buildAppBar(ElearningCourse course) {
    return SliverAppBar(
      expandedHeight: 240.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: "course-Tag-${course.id}",
              child: course.coverpictureurl != null
                  ? FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: 'images/collection-placeholder.png',
                image: course.coverpictureurl!,
              )
                  : Image(image: AssetImage('images/course-placeholder.png')),
            ),
            BottomGradient(),
            //_buildMetaSection(course)
          ],
        ),
      ),
    );
  }
/*
  void _loadBadge() async{
    // print('loadBadge called');
    if(course.requiredBadge!=null) {
      print('loading related badge data for badge id '+course.requiredBadge?['objectid']);
      dynamic badgeData = await widget.badgeProvider.getDetails(int.parse(course.requiredBadge?['objectid']), this.user);
      if(badgeData != null)
        setState(() {
          this.requiredBadge = Badge.fromJson(badgeData);
          print('required Badge data is now set!');
        });
    }
    // else print('course has no requiredbadge');
  }
  */
  void _loadCourse(user) async {

    if (widget.elearningCourseId == null) {
      _loadingState = LoadingState.ERROR;
      print('Could not load collection, collection ID not provided');
      return;
    }
    else if( _loadingState == LoadingState.LOADING) return;
    else if( _loadingState == LoadingState.WAITING) _loadingState = LoadingState.LOADING;
    print('loading elearningcourse ' + widget.elearningCourseId.toString()+' for user '+user.firstname+' '+user.lastname);
    try {
      dynamic details = await widget.courseProvider
          .getDetails(widget.elearningCourseId!, user);
      course = ElearningCourse.fromJson(details);
      this.stationStatus = await Provider.of<UserProvider>(context, listen: false).stationStatus(course);
      setState(() {
        if(details != null) {

          course = ElearningCourse.fromJson(details);
          _loadingState = LoadingState.DONE;
        }
        else {
          _loadingState = LoadingState.ERROR;

        }

      });
    } catch (e, stack) {
      print('loadDetails returned error $e\n Stack trace:\n $stack');
      //Notify(e.toString());
      _loadingState = LoadingState.ERROR;
      e.toString();
    }
  }

  List<Widget> _buildContentSection(ElearningCourse course) {

    //String accessStatus = AppLocalizations.of(context)!.yes;

    print('station is accessible: '+stationStatus['isaccessible'].toString());
    print('station is opened: '+stationStatus['isopened'].toString());


    return <Widget>[
      SliverList(
        delegate: SliverChildListDelegate.fixed([Container(
          decoration: BoxDecoration(color: const Color(0xff222128)),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  course.title != null
                      ? course.title.toString()
                      : AppLocalizations.of(context)!.unnamedStation,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 8.0,
                ),
                Text(
                    (course.description != null
                        ? course.description
                        : '')!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    )),
                Container(
                  height: 8.0,
                ),
                if(stationStatus['isopened'])
                  Text(AppLocalizations.of(context)!.youHaveOpenedThisStation),
                if( stationStatus['iscompleted'] == true)
                  Column(children:[
                    Icon(Icons.check),
                    Text(AppLocalizations.of(context)!.stationIsPassed),
                  ]
                  ),
                if(this.requiredBadge!=null)
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BadgeView(this.requiredBadge ?? new Badge())),
                        );
                      },
                      child:Text('Vaatii ansiomerkin '+( this.requiredBadge?.name ?? ''),
                        style: TextStyle( fontWeight: FontWeight.bold),)),
                //Text(AppLocalizations.of(context)!.priceToOpen+': '+course.requiredScore.toString()+'p, '+AppLocalizations.of(context)!.myPoints+': '+user!.availablescore.toString()),

              ],
            ),
          ),
        )]
        ),
      ),
      if(user?.getCurrentStation() == course.id)  bookLists(course.collectionid),
      if(user?.getCurrentStation() != course.id) SliverList(
          delegate: SliverChildListDelegate.fixed([stationInfo(course)])),
    ];

  }
 Widget stationInfo(course){


    //List<Widget> contents = [];
    String cannotOpenStation = AppLocalizations.of(context)!.cannotOpenStation;

    if(stationStatus['isopened']!=true)
      if(stationStatus['isaccessible']==null || stationStatus['isaccessible']==false || stationStatus['canafford']==false) {

        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(cannotOpenStation,
            textAlign: TextAlign.center,
          ),
        );
      }
    String openText = stationStatus['isopened']==true ? AppLocalizations.of(context)!.transitToStation : AppLocalizations.of(context)!.openStation;
    return
      ElevatedButton(
          onPressed: () async {
            dynamic result = await Provider.of<UserProvider>(context, listen: false).setStation(course);
            handleNotifications(result['notifications'],context);
          }, child: Text(openText)
      )
      //Text(course.id.toString()+' is not the current station for user '+(this.user?.firstname ?? 'Anonymous')+', which is: '+ (currentstation!=null ? currentstation.toString() : 'none'))
    ;
  }
  SliverList bookLists(collectionid)
  {
    return SliverList(
        delegate: SliverChildListDelegate.fixed([ Text(
      AppLocalizations.of(context)!.easyBooks,
      style: const TextStyle(
          color: Colors.lightGreen,
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
    ),
      collectionLevel(collectionid, 1),
      Text(
        AppLocalizations.of(context)!.moderateBooks,
        style: const TextStyle(
            color: Colors.amberAccent,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
      ),
      collectionLevel(collectionid, 2),
      Text(
        AppLocalizations.of(context)!.challengingBooks,
        style: const TextStyle(
            color: Colors.redAccent, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      collectionLevel(collectionid, 3)])
    );
  }
  Widget collectionLevel(collectionid,level)
  {
    return Container(
      height: 400.0,
      decoration: BoxDecoration(color: primaryDark),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: collectionid == null
            ? Container(child: Text('No books on this stop baby'))
            : LibraryItemList(
            widget.libraryItemProvider, widget.imageProvider,
            collection: collectionid,
            level:level),
      ),
    );
  }
}