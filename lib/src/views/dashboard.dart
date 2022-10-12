//import 'dart:math';
import 'package:flutter/material.dart';
import 'package:luen/src/objects/badge.dart';
import 'package:luen/src/objects/elearningcourse.dart';
import 'package:luen/src/objects/libraryitem.dart';
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/objects/webpage.dart';
import 'package:luen/src/providers/user_provider.dart';
import 'package:luen/src/providers/webpageprovider.dart';
import 'package:luen/src/util/shared_preference.dart';
import 'package:luen/src/views/achievements.dart';
import 'package:luen/src/views/badge.dart';
import 'package:luen/src/views/scorelist.dart';
import 'package:luen/src/views/webpagetextcontent.dart';
import 'package:provider/provider.dart';
import 'package:luen/src/views/card.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectmodel;
import 'package:luen/src/views/libraryitemlist.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:luen/src/util/utils.dart';
import 'package:luen/src/util/widgets.dart';
import 'package:luen/src/views/loginform.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:luen/src/views/gameboard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'elearningcourse.dart';

class DashBoard extends StatefulWidget {
  final String viewTitle = 'dashboard';

  final objectmodel.LibraryItemProvider libraryItemProvider =
  objectmodel.LibraryItemProvider();
  final objectmodel.ElearningCourseProvider courseProvider =
  objectmodel.ElearningCourseProvider();
  final objectmodel.LibraryCollectionProvider collectionProvider =
  objectmodel.LibraryCollectionProvider();
  final objectmodel.BadgeProvider badgeProvider = objectmodel.BadgeProvider();
  final dataKey = new GlobalKey();
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int buildIteration = 1;

  LoadingState _stationLoadingState = LoadingState.IDLE;
  LoadingState _badgeLoadingState = LoadingState.IDLE;
  LoadingState _pageLoadingState = LoadingState.IDLE;
  late ElearningCourse currentstation;
  User user = new User();
  List<Badge> badges = [];
  bool loginPopupDisplayed = false;
  bool _stationIsLoading = false;
  String? errormessage;
  WebPage page = new WebPage();

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this.buildIteration = 1;
      this.user = Provider.of<UserProvider>(context, listen: false).user;
      Provider.of<UserProvider>(context,listen:false).getBookList();
      Provider.of<UserProvider>(context,listen:false).getBadgeList();
      if (this._stationLoadingState == LoadingState.IDLE)_loadCurrentStation(this.user);
      if(this._badgeLoadingState == LoadingState.IDLE)_loadBadges(this.user);
      //See if info page exists for the view
      if(this._pageLoadingState == LoadingState.IDLE)_loadWebPage(this.user);
      this.loginPopupDisplayed = this.user.loginPopupDisplayed;

    });
    super.initState();
  }
  @override
  void dispose()
  {
    super.dispose();
  }
  _loadBadges(user) async{
    this._badgeLoadingState = LoadingState.LOADING;
   // print('loading BADGES for progress indicators ');
    final Map<String,dynamic> badgeParams = {
      //'fields' : 'title,description,coverpictureurl,level,identifier',
      'requiredbookcount' : "gt:0",
      'api-key':user.token,
      'api_key':user.token,
      'sort' : 'requiredbookcount',
    };
    dynamic badgedata = await widget.badgeProvider.loadItems(badgeParams);
    setState((){
      // print(badgedata.length.toString()+' badges loaded!');
      this._badgeLoadingState = LoadingState.DONE;
      badges.clear();
      badges.addAll(badgedata);
    });
  }
  _loadCurrentStation(user) async {
    //print('_loadCurrentStation called');


    if(user.getCurrentStation()!= null) {
      _stationIsLoading = true;
      try {
        print('loading current user station');
        dynamic stationData =
        await widget.courseProvider.getDetails(user.getCurrentStation(), user);


        if(stationData!=null)
        {
          setState(() {

            currentstation = ElearningCourse.fromJson(stationData);
            print('Current station is ' + currentstation.id.toString());
            Provider.of<UserProvider>(context,listen:false).station = currentstation;
            _stationLoadingState = LoadingState.DONE;
          });
        }else setState(() => _stationLoadingState = LoadingState.ERROR);
      } catch (e, stack) {
        _stationIsLoading = false;
        print('loading current station returned error $e\n Stack trace:\n $stack');
        errormessage = e.toString();
        if (_stationLoadingState == LoadingState.LOADING) {
          setState(() => _stationLoadingState = LoadingState.ERROR);
        }
      }
    }
    else {
      _stationIsLoading = false;
      print('user.getCurrentStation() returned null');
      setState(() => _stationLoadingState = LoadingState.ERROR);
    }
  }

  /* load related page */
  _loadWebPage(user)async {
    this._pageLoadingState = LoadingState.LOADING;
    //print('calling loaditem for webpage');
    await Provider.of<WebPageProvider>(context,listen:false).loadItem({
      'language': Localizations.localeOf(context).toString(),
      'commonname': widget.viewTitle,
      'fields': 'id,commonname,pagetitle,textcontents,thumbnailurl',
      if (user.token != null) 'api_key': user.token,
    });
    setState(() {
      this._pageLoadingState = LoadingState.DONE;
      this.page = Provider.of<WebPageProvider>(context, listen: false).page;
    });

  }
  @override
  Widget build(BuildContext context) {
    print('building dasboard state($buildIteration)');
    buildIteration++;
    this.loginPopupDisplayed = this.user.loginPopupDisplayed;
    //AuthProvider auth = Provider.of<AuthProvider>(context);
    this.user = Provider.of<UserProvider>(context).user;
    // Provider.of<UserProvider>(context, listen: false).getBookList();
    List<LibraryItem> myBooks = Provider.of<UserProvider>(context).myBooks;
    this.page = Provider.of<WebPageProvider>(context, listen:false).page;

   // bool hasInfoPage = this.page.id != null && this.page.runtimeType.toString()=='WebPage' ? true : false;
    if (this.user.token == null) {
   //   print('user token not found, pushing named route /login');
      return Login();
    } else {

      /* objectmodel.LibraryItemProvider provider =
          objectmodel.LibraryItemProvider();

      */
      objectmodel.ImageProvider imageprovider = objectmodel.ImageProvider();
      objectmodel.ElearningCourseProvider courseProvider =
      objectmodel.ElearningCourseProvider();

      List<String> nameparts = [];
      nameparts.add(user.firstname ?? 'Maija');
      nameparts.add(user.lastname ?? 'Meikäläinen');

      String username = nameparts.join(' ');

      /* Books read info */

      int userScore = user.availablescore?? 0;
      int awardedscore = user.awardedscore ?? 0;

      int booksRead = myBooks.isNotEmpty ?  myBooks.where((book)=>
          book.readstatus.contains('accepted')).toList().length : 0;
      bool hasInfoPage = this.page.id != null && this.page.runtimeType.toString()=='WebPage' ? true : false;
      bool isTester = false;
      //print(this.user.toString());
      if(this.user.data!=null) {
       // print(this.user.data.toString());
        if (this.user.data!['istester'] != null) {
          if (this.user.data!['istester'] == 'true') {
            isTester = true;
          }
        }
      }

      return this.loginPopupDisplayed==true ? Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.appName),
            elevation: 0.1,
            actions: [
              //Info page button
              if(hasInfoPage)IconButton(
                  icon: Icon(Icons.info_outline_rounded),
                  onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ContentPageView(widget.viewTitle,providedPage:this.page),
                    ));}
              ),
              //Bug reporting button
              if(isTester) IconButton(
                  icon: Icon(Icons.bug_report),
                  onPressed:(){feedbackAction(context,user); }
              ),
              //Refresh button
              IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () async {
                    print('Refreshing view');


                    Provider.of<UserProvider>(context, listen: false).refreshUser();
                    Provider.of<UserProvider>(context, listen: false).getBookList();
                    _loadBadges(user);
                    setState(() {

                      _stationLoadingState = LoadingState.LOADING;
                      _stationIsLoading = false;

                    });
                  }),
              //User card link
              IconButton(
                  icon: user.image != null && user.image!.isNotEmpty
                      ? Image.network(user.image!, height: 50)
                      : Image.asset('images/profile.png'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyCard()),
                    );
                  })
            ],
          ),
          body:  ListView(children:<Widget>[
            Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage('images/dashboard.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(children: <Widget>[
                Expanded(flex: 2, child: _drawNameLabel(context, username)),
                //User profile image (avatar)
               /* Expanded(
                    flex: 1,
                    child: _drawUserAvatar(
                        user.image != null && user.image!.isNotEmpty
                            ? NetworkImage(user.image!)
                            : Image.asset('images/profile.png').image)),
             */ ]),
            ),
            Padding(
              //Lukudiplomi-tilanne
              padding: EdgeInsets.all(16.0),
              child: Container(
                height:165,
                decoration: new BoxDecoration(
                  color: HexColor.fromHex('#af1e53'),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(AppLocalizations.of(context)!.readingProgress,

                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    indent: 0.0,
                    color: HexColor.fromHex('#f79880'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(children: <Widget>[
                      // Status indicator
                      Expanded(
                        flex: 3,

                        child:Column(children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!.score,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ScoreList()),
                              );
                            },
                            child:Text(
                              userScore.toString()+' ('+awardedscore.toString()+')',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        ]),

                      ),
                      //Books read
                      Expanded(

                        flex: 2,
                        child: Column(children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!.books,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => VerticalItemList()),
                              );
                            },
                            child:Text(
                              booksRead.toString(),
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                      ),

                      //Badges indicator and action link
                      Expanded(

                        flex: 3,
                        child: SingleChildScrollView(
                          scrollDirection:Axis.horizontal,
                          child: Column(

                            //contains badge status indicators and action link
                              children: <Widget>[
                                Row(

                                  //contains badge status indicators (3+)
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: badgeDisplays(this.badges,booksRead)
                                ),

                                SizedBox(
                                  height: 5,
                                ),
                              ]),
                        ),
                      )
                    ]),
                  ),
                ]),
              ),
            ),
            Padding(
              //Metrokartta

              padding: EdgeInsets.all(16.0),
              child: Container(
                decoration: new BoxDecoration(
                  color: HexColor.fromHex('#981f4f'),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.subwayMap,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 2,
                    indent: 0.0,
                    color: HexColor.fromHex('#f79880'),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30,10,10,20.0),
                    child: Row(children: <Widget>[
                      Expanded(
                        flex: 2,

                        // Station icon
                        child: Container(
                          height: 70.0,
                          margin: EdgeInsets.only(left:10),
                          decoration: new BoxDecoration(
                            color: HexColor.fromHex('#4c286a'),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child:IconButton(
                              iconSize: 50,
                            icon :currentstationIconDisplay(user),
                              onPressed:() {
                                Navigator.of(context)
                                    .pushAndRemoveUntil(MaterialPageRoute(
                                    builder: (context) =>
                                        Gameboard(
                                            courseProvider, imageprovider)), (
                                    Route<dynamic> route) => false);
                              }
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        //Current Station information
                        flex: 6,
                        child: Column(children: <Widget>[
                          currentstationDisplay(user, imageprovider),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushAndRemoveUntil(MaterialPageRoute(
                                  builder: (context) =>
                                      Gameboard(courseProvider, imageprovider)), (Route<dynamic> route) => false);
                              /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Gameboard(
                                          courseProvider, imageprovider)),


                                );*/
                            },
                            child:Text('Näytä kartta'),
                          ),



                        ]),
                      ),

                    ]),
                  ),
                ]),
              ),
            ),
            Padding(
              //Ansiomerkit

              padding: EdgeInsets.all(16.0),
              child: Container(
                decoration: new BoxDecoration(
                  color: HexColor.fromHex('#9d1a6f'),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AchievementsView()),
                      );
                    },
                    child:Padding(
                      padding: EdgeInsets.all(13.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.achievements,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),),
                  Divider(
                    height: 10,
                    thickness: 2,
                    indent: 0.0,
                    color: HexColor.fromHex('#f79880'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child:
                    GridView.count(
                        crossAxisCount:4,
                        crossAxisSpacing:5,
                        mainAxisSpacing:5,
                        scrollDirection:Axis.vertical,
                        shrinkWrap: true,
                        padding:EdgeInsets.all(10),
                        children:collectedBadges(Provider.of<UserProvider>(context).myBadges)
                    ),
                  ),


                ]),
              ),
            ),
          ]

          )
          ,
          bottomNavigationBar: bottomNavigation(context)


      ) :
  loginPopup();

    }
  }
  Widget loginPopup(){
    print('displaying loginpopup and setting user - popup displayed to true');

   // UserPreferences().saveUser(this.user);
    return ContentPageView('login-info',route: '/dashboard',bottomNavigationBar: ElevatedButton(
    child:Text('OK'),
      onPressed: (){
        setState(() {
          this.user.loginPopupDisplayed = true;
          UserPreferences().saveUser(this.user);
        });
      },

    ),

    );
  }
  /* Widget list creator for collected badges */
  List<Widget> collectedBadges(collectedBadges)
  {
  //  print('displaying '+collectedBadges.length.toString()+' collected badges');
    List<Widget> data = [];
    if(collectedBadges.isEmpty) return data;
    for (var badge in collectedBadges) {

      data.add(badgeIconDisplay(badge));
    }
    return data;
  }

  Widget badgeIconDisplay(Badge badge)
  {
    String badgeUrl = badge.badgeimageurl ??'';
    bool hasImage = badge.badgeimageurl !=null ? true : false;
 //   print('showing badge image: '+badgeUrl);
    return Container(
      height: 150,
      child:GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BadgeView(badge)),
          );
        },
        child:Column(

            children:[
              /*
              FaIcon(
                  IconData(0xf091,
                      fontFamily: 'FontAwesomeSolid',
                      fontPackage: 'font_awesome_flutter'),
                  size: 50.0),

               */

              AspectRatio(
                aspectRatio:1.25/1,
                child:ClipRect(

                  child: hasImage
                      ? FadeInImage.assetNetwork(
                    //fit: BoxFit.contain,
                   // width: double.infinity,
                    placeholder: 'images/badge-placeholder.jpg',
                    image: badgeUrl ,
                  )
                      : Image(
                      image: AssetImage('images/badge-placeholder.jpg')),
                ),
              ),
              Text(badge.name ?? '-',
                style: TextStyle(fontSize: 10),
              ),
            ]
        ),
      ),
    );
  }
  /* Widget list creator for available book-reading badges */
  List<Widget> badgeDisplays(badges,bookcount)
  {
 //   print('creating badgedisplays for '+badges!.length.toString()+' badges');
    List<Widget> data = [];
    bool firstVisibleBadgeSet = false;
    if(badges.isEmpty) return data;
    for (var badge in badges) {
      Key badgeKey = Key('badge-'+badge.id.toString());
      data.add(badgeDisplay(badge, bookcount,badgeKey));
      if(!firstVisibleBadgeSet)
      {
        double percentage = badge.requiredBookCount !=null ? bookcount / badge.requiredBookCount : 1 ;
        if(percentage < 1) {
          //ensure this badge is visible
          // print('ensuring badge '+badge.name+' should be visible, percentage is '+percentage.toString());
          firstVisibleBadgeSet=true;
          if(widget.dataKey.currentContext!=null)Scrollable.ensureVisible(widget.dataKey.currentContext!);
        }
      }
    }
    return data;
  }

  /* Single badge progress indicator */
  Widget badgeDisplay(badge,bookCount,key)
  {

    double percentage = badge.requiredBookCount !=null ? bookCount / badge.requiredBookCount : 1 ;
    if(percentage > 1) percentage = 1;
    //print('badge color: '+badge.color);
    return Padding(
      //Indicator 1/X
      padding: EdgeInsets.only(left:5),
      child:GestureDetector(

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BadgeView(badge)),
          );
        },
        child:
        CircularPercentIndicator(
            key:key,
            radius: 20.0,
            lineWidth: 4.0,
            percent: percentage,
            center: Center(
              child: Stack(
                alignment:Alignment.center,
                children:[
                  Icon(Icons.emoji_events,
                    size: 35.0,
                    semanticLabel:
                    badge.name),
                  Text((percentage*100).round().toString()+'%',
                        style: TextStyle(
                            fontSize: 9,
                            color: Colors.black
                        )
                    ),

                ]),
            ),
            backgroundColor: Colors.yellow,
            progressColor: badge.color !=null ? HexColor.fromHex(badge.color) : Colors.green//Colors.green,
        ),
      ),
    );
  }
  Padding _drawNameLabel(BuildContext context, String label) {
    TextTheme nameTheme = TextTheme(
        headlineMedium:
        TextStyle(color: Colors.white, backgroundColor: Colors.black38,fontSize: 30));
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        label,
        style: Theme.of(context).textTheme.merge(nameTheme).headlineMedium,
      ),
    );
  }
/*
  Padding _drawUserAvatar(ImageProvider imageProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyCard()),
          );
        },
        child:Container(
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            backgroundImage: imageProvider,
            backgroundColor: Colors.white10,
            radius: 40.0,
          ),
        ),
      ),
    );
  }
*/
  Widget currentstationIconDisplay(user) {
    switch (_stationLoadingState) {
      case LoadingState.DONE:
      //data loaded

        if (currentstation.unicodeicon != null) {

          return FaIcon(
              IconData(currentstation.unicodeicon!,
                  fontFamily: 'FontAwesomeSolid',
                  fontPackage: 'font_awesome_flutter'),
              size: 50.0);
        }

        return Icon(Icons.directions_subway, size: 50.0);

      default:
        return Icon(Icons.directions_subway, size: 50.0);
    }
  }

  Widget currentstationDisplay(user, imageProvider) {
    switch (_stationLoadingState) {
      case LoadingState.DONE:
      //data loaded

        return TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ElearningCourseView(
                      currentstation.id,
                      widget.courseProvider,
                      //  widget.collectionProvider,
                      imageProvider)),
            );
          },
          child: Text(
            currentstation.title ?? AppLocalizations.of(context)!.unnamedStation,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );


      case LoadingState.LOADING:
      //data loading in progress
        if (!_stationIsLoading)
          _loadCurrentStation(user);
        return CircularProgressIndicator();

      case LoadingState.ERROR:
      //could not load current station
      default:
        return Text(AppLocalizations.of(context)!.youAreNotOnAnyStation);
    } //switch
  }
}
