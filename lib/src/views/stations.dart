//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luen/src/objects/elearningcourse.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:luen/src/objects/webpage.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectmodel;
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/providers/webpageprovider.dart';
import 'package:luen/src/util/api_client.dart';
import 'package:luen/src/util/app_url.dart';
import 'package:luen/src/util/utils.dart';
import 'package:luen/src/providers/user_provider.dart';
import 'package:luen/src/util/widgets.dart';
import 'package:provider/provider.dart';
import 'package:luen/src/views/elearningcourse.dart';
import 'package:luen/src/views/gameboard.dart';
import 'package:luen/src/views/webpagetextcontent.dart';

/*
* Stations - list view
*/

class StationsView extends StatefulWidget {
  final String viewTitle = 'stations';

  final objectmodel.ElearningCourseProvider courseProvider;
  final objectmodel.ImageProvider imageProvider;
  final objectmodel.LibraryCollectionProvider collectionProvider =
  objectmodel.LibraryCollectionProvider();
  StationsView(this.courseProvider, this.imageProvider);

  @override
  _StationsViewState createState() => _StationsViewState();
}

class _StationsViewState extends State<StationsView> {
  Map<String, dynamic>? map;
  List<ElearningCourse> data = [];
  List<ElearningCourse> endStations = [];
  User? user;
  Map<String,LoadingState> _loadingStates = {};
  List<dynamic> lineData = [];

  int iteration = 1;
  int buildIteration = 1;
  int buildtime = 1;
  int limit = 100;
  int _pageNumber = 0;
  String? errormessage;

  var screenWidth;
  var screenHeight;

  WebPage page = new WebPage();

  /* load related page */
  _loadWebPage(user)async {
   // print('calling loaditem for webpage '+widget.viewTitle);
    await Provider.of<WebPageProvider>(context,listen:false).loadItem({
      'language': Localizations.localeOf(context).toString(),
      'commonname': widget.viewTitle,
      'fields': 'id,commonname,pagetitle,textcontents,thumbnailurl',
      if (user.token != null) 'api_key': user.token,
    });
    setState(() {

      this.page = Provider.of<WebPageProvider>(context, listen: false).page;
    });

  }

  _loadLines(user) async{
    final ApiClient _apiClient = ApiClient();
    print('loading lines data from server');


    final Map<String, String> params = {
      'fields': 'id,colour,elearningcourselist,name,icon,stations',
      'api_key': user.token,
      'sort': 'id',
      'application' : 'id='+AppUrl.appId.toString()
    };

    try {
      dynamic data = await _apiClient.getDataList('certificate',params);

      setState(() {
        _loadingStates['lines'] = LoadingState.DONE;
        // lineData = data;
        print(data.length.toString() + ' lines loaded!');
        for(var line in data)
        {
          List<int> stations = [];
          Map<String,dynamic> itemContent = line['data'];
         // print(line['data'].toString());
          if(itemContent['stations']!=null) {
            List<dynamic> dataList = itemContent['stations'].split(',');
            stations = dataList.map((data) => int.parse(data))
                .toList();
          }
          else if(itemContent['elearningcourselist']!=null)
            for (var station in itemContent['elearningcourselist'])
            {
              stations.add(int.parse(station['objectid']));

            }
          lineData.add({
            'id':itemContent['id'],
            'name':itemContent['name'],
            'stations' : stations,
            'colour': itemContent['colour'],
            'icon':itemContent['icon']});
          if(itemContent['elearningcourselist']!=null)
            print('Stations on line '+itemContent['name']+': '+itemContent['elearningcourselist'].length.toString());
        }

      });
    } catch (e, stack) {

      print('loadLines returned error $e\n Stack trace:\n $stack');
      errormessage = e.toString();
      if (_loadingStates['lines'] == LoadingState.LOADING) {
        setState(() => _loadingStates['lines'] = LoadingState.ERROR);
      }
    }
  }

  _loadStations(user) async {

    int offset = 0;
    print('loading map data from server');
    final Map<String, String> params = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'fields':
      'title,description,coverpictureurl,description,canvas_x,canvas_y,requiredknowledge,requiredscore,collections,icon,unicodeicon,titleposition,textcolour,backgroundcolour',
      'status' : 'active',
      'category' : '3',
      'api-key': user.token,
      'api_key': user.token,
      'sort': 'id',
    };
    print('Loading page $_pageNumber');
    try {
      List<ElearningCourse> courses =
      (await widget.courseProvider.loadItems(params))
          .cast<ElearningCourse>();
      setState(() {
        data.clear();
        endStations.clear();
        _loadingStates['stations'] = LoadingState.DONE;
        data.addAll(courses);
        print(data.length.toString() + ' stations currently loaded!');
        courses.forEach((element) {
          if(element.requiredKnowledge!=null && element.requiredKnowledge!.length>0) {
            print((element.title??'Unnamed station')+' has requiredKnowledge:'+element.requiredKnowledge.toString());
          }
          else{
            print('adding '+(element.title??' unnamed station')+' to end stations list');
            endStations.add(element);
          }

        });
        _pageNumber++;
      });
    } catch (e, stack) {

      print('loadItems returned error $e\n Stack trace:\n $stack');
      errormessage = e.toString();
      if (_loadingStates['stations'] == LoadingState.LOADING) {
        setState(() => _loadingStates['stations'] = LoadingState.ERROR);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      this.user = Provider.of<UserProvider>(context, listen: false).user;
      print('initstate - loading stations and lines');
      _loadStations(this.user);
      _loadLines(this.user);
      _loadWebPage(this.user);
    });
  }

  @override
  Widget build(BuildContext context) {

    print('Build '+this.buildIteration.toString()+' called for stations view');
    this.buildIteration++;
    User user = Provider.of<UserProvider>(context, listen: true).user;
    bool isTester = false;
    if(user.data!=null) {
      if (user.data!['istester'] != null) {
        if (user.data!['istester'] == 'true') isTester = true;
      }
    }

    this.page = Provider.of<WebPageProvider>(context,listen:false).page;

    bool hasInfoPage =
    this.page.id != null && this.page.runtimeType.toString() == 'WebPage'
        ? true
        : false;

    var line = this.lineData.singleWhere((line)=>int.parse(line['id'])==user.currentline,orElse:()=>null);
    String appBarTitle = line!=null ? line['name'] : AppLocalizations.of(context)!.lineMap;
    return new  Scaffold(
        appBar: new AppBar(
            title: new Text(appBarTitle),
            actions: [
              if(hasInfoPage)IconButton(
                  icon: Icon(Icons.info_outline_rounded),
                  onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ContentPageView(widget.viewTitle,providedPage:this.page),
                    ));}
              ),
              IconButton(
                  icon:Icon(Icons.map_outlined),
                  tooltip:AppLocalizations.of(context)!.stationList,
                  onPressed:(){
                    Navigator.of(context)
                        .pushAndRemoveUntil(MaterialPageRoute(
                        builder: (context) =>
                            Gameboard(widget.courseProvider, widget.imageProvider)), (Route<dynamic> route) => false);
                  }
              ),
              IconButton(
                  icon: Icon(Icons.directions_subway),
                  tooltip: AppLocalizations.of(context)!.lineMap,
                  onPressed: () { notifyDialog('Vaihda linjaa',Container(height:300,width:200,child:stationChooser()),context);
                  }),
              if(isTester) IconButton(
                  icon: Icon(Icons.bug_report),
                  onPressed:(){feedbackAction(context,user); }
              ),
              IconButton(
                  icon: Icon(Icons.refresh),
                  tooltip: AppLocalizations.of(context)!.refresh,
                  onPressed: () {
                    print('Refreshing view');
                    setState(() {
                      data.clear();
                      _loadingStates['stations'] = LoadingState.LOADING;

                      _pageNumber = 0;
                      _loadStations(user);
                    });
                  }),
            ]),
        body: SafeArea(child:_getContentSection(user)),

        bottomNavigationBar: bottomNavigation(context,currentIndex: 1)
    );
  }

  Widget _getContentSection(user) {

    print('loading state: ' + _loadingStates['stations'].toString());
    switch (_loadingStates['stations']) {
      case LoadingState.DONE:

        List<Widget> stations = [];
        //print('looking for line '+user.currentline.toString());
        //print('does list have the line?'+(this.lineData.singleWhere((line)=>int.parse(line['id'])==user.currentline,orElse:()=>null)!=null ? 'yes' : 'no'));
        if(user.currentline==null &&  this.user?.getCurrentStation()!=null)
        {
          print('user current line appears to be null, current station: '+(this.user?.getCurrentStation().toString()??''));
          //try picking line based on current station
          Iterable<dynamic> stationOnLines = this.lineData.where((line)=>line['stations'].contains(this.user?.getCurrentStation()));
          if(stationOnLines.length==1) {
            print('station found on single line');
            dynamic s = stationOnLines.first;
            user.currentline =  int.parse(s['id']);
          }
          else print('station found on '+stationOnLines.length.toString()+' lines');

        }
        if(user.currentline==null ){
          print('user.currentline: '+user.currentline.toString());
          return(Padding(padding:EdgeInsets.all(20),

            child:lineChooser(user),

          )
          );

        }
        else
        if(this.lineData.isNotEmpty)
        {
          // print('current station: '+user.currentstation['objectid'].toString());
          // print('line data is not empty and line is found for user');
          var line = this.lineData.singleWhere((line)=>int.parse(line['id'])==user.currentline,orElse:()=>null);

          if(line != null && line['stations']!=null)
          {
            //add header
            stations.add(Padding(
                padding:EdgeInsets.only(bottom:10),
                child: Text(line['name'],style: Theme.of(context).textTheme.headlineSmall,))
            );

            Color lineColor = line['colour'] != null ? HexColor.fromHex(
                line['colour']) : Theme
                .of(context)
                .colorScheme
                .primary;

            if(Provider.of<UserProvider>(context, listen: false).station==null) {
              stations.add(
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text('Et ole vielä valinnut asemaa', style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium,))

              );

              //   print(line['name']+': '+line['stations'].toString());
              stations.add(Padding(padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Voit aloittaa kummalta tahansa pääteasemalta', style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,)));
            }
            for(int stationId in line['stations'])
            {
              ElearningCourse course = data.isNotEmpty ? data.firstWhere((element) => element.id == stationId,orElse:()=>new ElearningCourse()) : new ElearningCourse();

              Iterable<dynamic> stationOnLines = this.lineData.where((line)=>line['stations'].contains(stationId));
              List<Widget> stationLineLinks = [];
              if(stationOnLines.isNotEmpty)
              {
                stationOnLines.forEach((element) {

                  if(element['id']!=line['id'])
                    stationLineLinks.add(Padding(

                      padding: EdgeInsets.only(left:5,right:5),

                      child:Text(element['name'],style:TextStyle(


                          color:element['colour']!=null ? HexColor.fromHex(element['colour']) : Theme.of(context).colorScheme.primary)
                      ),));
                });
              }

              bool isCurrentStation = int.parse(user?.currentstation?['objectid'] ??'0' ) == stationId ? true : false;
              // print('is '+course.id.toString()+' current station '+(user?.currentstation?['objectid'] ??'0')+'? '+isCurrentStation.toString());
              stations.add(GestureDetector(
                onTap: (){
                  //  print('setting station');
                  // Provider.of<UserProvider>(context, listen: false).setStation(course);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ElearningCourseView(
                            course.id,
                            widget.courseProvider,
                            // widget.collectionProvider,
                            widget.imageProvider)),
                  );
                },
                child:Container(
                  decoration: BoxDecoration(
                      color: course.backgroundcolour!=null && course.backgroundcolour!='' ? HexColor.fromHex(course.backgroundcolour!) : Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  padding: EdgeInsets.all(10),

                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [

                        // Station icon
                    Flexible(
                      flex: 2,
                      fit: FlexFit.loose,
                      child:
                      Container(
                          width:60,
                          clipBehavior:Clip.none,child:
                      (course.unicodeicon != null) ? FaIcon(
                          IconData(course.unicodeicon!,
                              fontFamily: 'FontAwesomeSolid',
                              fontPackage: 'font_awesome_flutter'),
                          size: 40.0,
                          color: isCurrentStation  ? Theme.of(context).colorScheme.primaryContainer : lineColor
                      ) : Icon(Icons.directions_subway, size: 40.0,
                          color: isCurrentStation ? Theme.of(context).colorScheme.primaryContainer : lineColor)
                      ),
                    ),

                    // Station title
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Text(    ( course.title ?? AppLocalizations.of(context)!.unnamedStation),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isCurrentStation ? Theme.of(context).colorScheme.primaryContainer : lineColor),

                      ),
                    ),

                    //Crossing lines
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: GestureDetector(
                          onTap: (){
                            notifyDialog('Linjan valinta',Container(
                                height:300,
                                width:200,
                                child:isCurrentStation ? lineChooser(user) : Text('Siirry asemalle vaihtaaksesi linjaa')
                            ),context
                            );
                          },child:
                      Column(children:stationLineLinks)
                      ),
                    ),

                    //Current station indicator
                    Expanded(
                      flex: 1,

                      child: isCurrentStation ? Icon(Icons.circle,color: Colors.red) : Container(),
                      ),

                  ]),
                ),
              ),
              );
              stations.add(Row(children:[Container(width:85,height:15,alignment:Alignment.center,
                child: VerticalDivider(
                  //height: 10,
                  thickness: 2,
                  indent: 2.0,
                  endIndent: 2.0,
                  color: Colors.yellow,
                ),),Expanded(child:Container())]),

              );
            }
          }
          if(stations.length>1) stations.removeLast();



        }
        else stations.add(  Align(
          alignment: Alignment.center,
          child: Center(
            child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text(AppLocalizations.of(context)!.loading,
                  textAlign: TextAlign.center),
            ),
          ),
        ));
        return SingleChildScrollView
          (
          padding: EdgeInsets.all(20),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: stations,
          ),
        );



      case LoadingState.ERROR:
      //data loading returned error state
        return Align(
          alignment: Alignment.center,
          child: ListTile(
            leading: Icon(Icons.error),
            title: Text(
                'Sorry, there was an error loading the data: $errormessage'),
          ),
        );
      case LoadingState.LOADING:
      default:

      //data loading in progress
        return Align(
          alignment: Alignment.center,
          child: Center(
            child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text(AppLocalizations.of(context)!.loading,
                  textAlign: TextAlign.center),
            ),
          ),
        );


    } //switch
  }


  Widget modalContents(ElearningCourse course) {
    return Container(
      height: 200,
      child: Padding(
        padding: EdgeInsets.all(10),
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(children: [
                if (course.unicodeicon != null)
                  FaIcon(
                      IconData(course.unicodeicon!,
                          fontFamily: 'FontAwesomeSolid',
                          fontPackage: 'font_awesome_flutter'),
                      size: 50.0)
                else
                  Icon(Icons.directions_subway, size: 50.0),
                VerticalDivider(
                  width: 20,
                  thickness: 2,
                  indent: 1.0,
                  color: HexColor.fromHex('#ffffff'),
                ),
                Text(
                  course.title ?? AppLocalizations.of(context)!.unnamedStation,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              ElevatedButton(
                  onPressed: ()=>  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ElearningCourseView(
                            course.id,
                            widget.courseProvider,
                            // widget.collectionProvider,
                            widget.imageProvider)),
                  ),
                  child: Text('Näytä')
              ),
            ]),
      ),
    );
  }

  selectCurrentStation(user)
  {
    List<dynamic> lines = [];

    if(this.lineData.isNotEmpty) {
      int currentStationId = user?.getCurrentStation() ?? 0;
      for (var l in lineData) {
        if (l['stations'] != null) {
          List<dynamic> dataList = l['stations'].split(',');
          List<int> stationsAsInt = dataList.map((data) => int.parse(data)).toList();
          if (stationsAsInt.contains(currentStationId)) {
            lines.add(l);
          }
        }
      }
      if(lines.length==1) {
        dynamic currentline = lines.first;
        user!.currentline = currentline['id'];
        return true;
      }
      else notifyDialog('Linjan valinta',lineChooser(user),context);
      return(Padding(padding:EdgeInsets.all(20),
          child:Text('Valitse linja')
      )
      );
    }
    else {
      //error!
      return false;
    }
  }

  Widget lineChooser(user,{showAll: false})
  {
    List<Widget> items = [];

    if(lineData.isNotEmpty) {
      int? currentStationId = user?.getCurrentStation();
      Iterable<dynamic> availableLines = [];
      if(currentStationId!=null && showAll == false)
      {
        //reduce available lines based on current station
        print('reducing lines from '+lineData.length.toString()+' to the ones available from current station '+(user?.getCurrentStation().toString() ??''));
        lineData.forEach((element) {print(element['name'].toString()+': '+element['stations'].toString());});
        availableLines = this.lineData.where((line)=>line['stations'].contains(user?.getCurrentStation()));
      }
      else {
        print('no station selected, showing all lines');
        availableLines = lineData;
      }
      if(availableLines.isEmpty) {
        print('reducing available lines left nothing! please reselect station');
        items.add(stationChooser());
      }
      else {
        items.add(Padding(
          padding:EdgeInsets.only(bottom: 10),
          child:Text('Valitse linja',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        );
        if(currentStationId!=null)
          items.add(Padding(
            padding:EdgeInsets.only(bottom: 10),
            child:Text('Olet asemalla ' + (Provider.of<UserProvider>(context, listen: false).station?.title ?? '?'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          );
        for (var l in availableLines) {
          if (l['stations'] != null) {
            print(l.toString());
            if (l['stations'].contains(currentStationId) ||
                currentStationId == null || showAll == true) {
              items.add(Card(
                  color: Colors.white,
                  child: ListTile(
                      title: GestureDetector(
                          onTap: () {
                            setState(() {
                              Provider.of<UserProvider>(context, listen: false)
                                  .setLine(int.parse(l['id']));

                            });
                          },
                          child: Text(l['name'] ?? '', style: TextStyle(
                            color: HexColor.fromHex(l['colour']),
                          ),)),
                      leading: l['unicodeicon'] != null ? FaIcon(
                          IconData(l['unicodeicon']!,
                              fontFamily: 'FontAwesomeSolid',
                              fontPackage: 'font_awesome_flutter'),
                          size: 40.0,
                          color: HexColor.fromHex(l['colour'])) : Icon(
                          Icons.directions_subway, size: 40.0,
                          color: HexColor.fromHex(l['colour']))
                  )
              ));
            }
          }
          else
            print('stations is nullenull');
        }
        print(items.length.toString() + ' lines created for line chooser');
      }
    }
    else print('no lines found to choose from!');
    return ListView(children:items);
  }
  Widget stationChooser()
  {
    List<Widget> items = [];
    if(this.endStations.isNotEmpty){
      print(endStations.length.toString()+' endstations found');
      this.endStations.forEach((element) {
        items.add(Card(
            child:ListTile(
                title:GestureDetector(
                    onTap: (){
                      Provider.of<UserProvider>(context, listen: false).setStation(element);
                    },
                    child:Text(element.title??'')),
                leading:element.unicodeicon!=null ? FaIcon(
                    IconData(element.unicodeicon!,
                        fontFamily: 'FontAwesomeSolid',
                        fontPackage: 'font_awesome_flutter'),
                    size: 40.0) : Icon(Icons.directions_subway, size: 40.0)
            )
        ));
      });
    }
    else print('No endstations found!');
    return ListView(
        shrinkWrap: true,
        children:items
    );
  }

}
