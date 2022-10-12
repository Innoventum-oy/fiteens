import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luen/src/objects/elearningcourse.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:luen/src/objects/webpage.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectmodel;
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/providers/webpageprovider.dart';
import 'package:luen/src/util/api_client.dart';
import 'package:luen/src/util/utils.dart';
import 'package:luen/src/providers/user_provider.dart';
import 'package:luen/src/util/widgets.dart';
import 'package:luen/src/views/stations.dart';
import 'package:luen/src/views/webpagetextcontent.dart';
import 'package:provider/provider.dart';
import 'package:widget_arrows/widget_arrows.dart';
import 'package:luen/src/views/elearningcourse.dart';

/* Graphviewimports */

import 'package:graphview/GraphView.dart';


/*
* Map view
*/

class Gameboard extends StatefulWidget {
  final String viewTitle = 'gameboard';
  final objectmodel.ElearningCourseProvider courseProvider;
  final objectmodel.ImageProvider imageProvider;
  final objectmodel.LibraryCollectionProvider collectionProvider =
  objectmodel.LibraryCollectionProvider();
  Gameboard(this.courseProvider, this.imageProvider);

  @override
  _GameboardState createState() => _GameboardState();
}

class _GameboardState extends State<Gameboard> {
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
  late TransformationController _controller;
  var graph = new Graph();
  var screenWidth;
  var screenHeight;
  Map<int,Node> nodes={};
  WebPage page = new WebPage();
  Map<String,int> mapRoutes= {};
  Map<String,int> stationLayers = {};
  List<String>stationIds = [];
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

      this.page = Provider.of<WebPageProvider>(context, listen: false).page;
    });

  }

  _loadLines(user) async{
    final ApiClient _apiClient = ApiClient();
    print('loading lines data from server');
    lineData.clear();

    final Map<String, String> params = {
      'fields': 'id,colour,elearningcourselist,name,icon,stations',
      'api_key': user.token,
      'sort': 'id',
      // 'application' : 'id='+AppUrl.appId.toString()
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
            'stations':  stations,
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
  _loadMap(user) async {

    int offset = 0;
    print('loading map data from server');
    final Map<String, String> params = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'fields': 'title,description,coverpictureurl,description,canvas_x,canvas_y,requiredknowledge,requiredscore,textcolour,backgroundcolour,collections,icon,unicodeicon,titleposition,isopened,isendpoint',
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
          if(element.data?['isendpoint']=='true')

            endStations.add(element);

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      User user = Provider.of<UserProvider>(context, listen: false).user;
      _loadWebPage(this.user);
      _loadMap(user);
      _loadLines(user);
    });
    _controller = TransformationController();
    //  _controller.value = Matrix4.identity() * 1.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.screenWidth = MediaQuery.of(context).size.width;
    this.screenHeight = MediaQuery.of(context).size.height;
    mapRoutes.clear();
    stationLayers.clear();
    stationIds.clear();
    print('Build '+this.buildIteration.toString()+' called for gameboard');
    this.buildIteration++;
    User user = Provider.of<UserProvider>(context, listen: true).user;
    bool isTester = false;
    if(user.data!=null) {
      if (user.data!['istester'] != null) {
        if (user.data!['istester'] == 'true') isTester = true;
      }
    }
    //this.page = Provider.of<WebPageProvider>(context).page;

    bool hasInfoPage =
    this.page.id != null && this.page.runtimeType.toString() == 'WebPage'
        ? true
        : false;

    if(user.getCurrentStation()==null)
    {
      //user needs to select current station
      //notifyDialog('Aloitusasema',stationChooser(),context);
    }
    return new  ArrowContainer(
      child: Scaffold(
          appBar: new AppBar(
              title: new Text(AppLocalizations.of(context)!.metroMap),
              actions: [
                if(hasInfoPage)IconButton(
                    icon: Icon(Icons.info_outline_rounded),
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ContentPageView(widget.viewTitle,providedPage:this.page),
                      ));}
                ),
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
                IconButton(
                    icon: Icon(Icons.directions_subway),
                    tooltip: AppLocalizations.of(context)!.lineMap,
                    onPressed: () { notifyDialog('Aloitusasema',stationChooser(),context);
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
                        _loadMap(user);
                        _loadLines(user);
                      });
                    }),
              ]),
          body: SafeArea(

            child:Stack(children:[
              _getContentSection(user)]
            ),



          ),
          bottomNavigationBar: bottomNavigation(context,currentIndex: 2)
      ),
    );
  }

  Widget _getContentSection(user) {
    // User screen size to set the canvas



    //calculate correct x/y coordinate for displaying item on canvas based on screen size;
    // original coordinates are set on 1000 unit grid
    double calculateCoordinateOnCanvas(origin, canvasMax, min, max,padding) {
      //original value adjusted to screen size, canvas coordinates scaled based on highest value
      // double adjustedvalue = (origin+adjust)/(1000+adjust)*canvasMax;

      origin-=min;
      var size = max-min;
      // min=0;

      var percent = origin/size;
      //   print('origin:'+origin.toString()+',min:'+min.toString()+',max:'+max.toString()+',size:'+size.toString());
      // print(origin.toString()+','+size.toString()+',location on line in %: '+percent.toString());
      num adjustedvalue = (20 * (percent * (canvasMax-padding*2)/20).floor()) + padding;
      //scale to fill canvas
      // adjustedvalue = adjustedvalue*canvasMax/scale;
      /* print('adjust: ' +
          adjust.toString() +
          ',scale: ' +
          scale.toString() +
          ', adjusted value ' +
          origin.toString() +
          ' -> ' +
          adjustedvalue.toString());
          */

      return (adjustedvalue.toDouble());
    }

    print('loading state: ' + _loadingStates['stations'].toString());
    switch (_loadingStates['stations']) {
      case LoadingState.DONE:
        List<Widget> dots = [];
        // get coordinate scale
        if(data.length>0) {
          int minX = 0;
          int maxX = 0;
          int minY = 0;
          int maxY = 0;

          for (var course in data) {
            if (course.canvasX < minX) minX = course.canvasX;
            if (course.canvasX > maxX) maxX = course.canvasX;
            if (course.canvasY < minY) minY = course.canvasY;
            if (course.canvasY > maxY) maxY = course.canvasY;
          }
          //add padding

          /*  print('canvas size:' +
              screenWidth.toString() +
              ' x ' +
              screenHeight.toString() +
              ' minX: ' +
              minX.toString() +
              ', maxX: ' +
              maxX.toString() +
              ', minY: ' +
              minY.toString() +
              ', maxY: ' +
              maxY.toString());
*/
          var canvasSize = this.screenHeight - 240;
          for (var course in data) {
            // print(course.data.toString());
            //print('POSITION: '+course.data?['titleposition']);
            if (course.id != null) nodes[course.id!] = Node.Id(course.title);
            double x = calculateCoordinateOnCanvas(
                course.canvasX, canvasSize, minX, maxX, 30);
            double y = calculateCoordinateOnCanvas(
                course.canvasY,canvasSize, minY, maxY, 30);
            //   print('adjusted '+course.canvasX.toString()+' x '+course.canvasY.toString()+' to '+x.toString()+' x '+y.toString());

            Widget positionedDot = Container();
            print(course.data?['titleposition']);
            switch (course.data?['titleposition']?.trim()) {
              case 'top':
                positionedDot = Positioned(
                    bottom: 30,
                    child: Text(course.title ?? '',textAlign: TextAlign.center));

                break;
              case 'bottom':
                positionedDot = Positioned(
                    top: 30,
                    child: Text(course.title ?? '',textAlign: TextAlign.center));
                break;
              case 'left':
                positionedDot = Positioned(
                    right: 30,
                    child: Text(course.title ?? '',textAlign: TextAlign.center));
                break;
              case 'right':
                positionedDot = Positioned(
                    left: 30,
                    child: Text(course.title ?? '',textAlign: TextAlign.center,));
                break;
              case 'top left':
                positionedDot = Positioned(
                    bottom: 25,
                    right: 20,
                    child: Text(course.title ?? '',textAlign: TextAlign.center));
                break;
              case 'top right':
                positionedDot = Positioned(
                    bottom: 25,
                    left: 20,
                    child: Text(course.title ?? '',textAlign: TextAlign.center));
                break;
              case 'bottom left':
                positionedDot = Positioned(
                    top: 25,
                    right: 20,
                    child: Text(course.title ?? '',textAlign: TextAlign.center));
                break;
              case 'bottom right':
                positionedDot = Positioned(
                    top: 25,
                    left: 20,
                    child: Text(course.title ?? '',textAlign: TextAlign.center));
                break;
            }

            /*Color courseColor = Colors.grey;
            if(course.isopened)

             */
            Color courseColor = Colors.white;
            if(course.id ==
                user.getCurrentStation())
              courseColor = Colors.red;
            else if(course.backgroundcolour!=null && course.backgroundcolour!='') {
              print('using colour "'+course.backgroundcolour!+'"');
              courseColor = HexColor.fromHex(course.backgroundcolour!);
            }
            dots.add(new Positioned(

              left: x,
              top: y,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  GestureDetector(
                    /*  onTap: () {
                        showMaterialModalBottomSheet(
                          context: context,
                          builder: (context) => modalContents(course),
                        );
                      },*/
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ElearningCourseView(
                                        course.id,
                                        widget.courseProvider,
                                        // widget.collectionProvider,
                                        widget.imageProvider)),
                          ),
                      child:
                      Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [...createArrows(course, Container(
                            //width: 50.0,
                            // height: 50.0,
                              width: 25.0,
                              height: 25.0,
                              decoration: new BoxDecoration(
                                color: courseColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: course.id ==
                                        user.getCurrentStation()
                                        ? Colors.green
                                        : Colors.black38,
                                    width: course.id ==
                                        user.getCurrentStation()
                                        ? 5
                                        : 2),
                                /*  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(
                                          course.coverpictureurl!)


                                  )*/
                              )
                          )
                          ),
                            positionedDot,

                          ])
                  ),
                  // Text(course.title!, textScaleFactor: 1.0)
                ],
              ),
            ),

            );
            /* if(course.id == user!.getCurrentStation())
            {
              double x =calculateCoordinateOnCanvas(
                  course.canvasX, this.screenWidth*2, minX.abs(), maxX.abs());
              double y = calculateCoordinateOnCanvas(
                  course.canvasY, this.screenHeight*2, minY.abs(), maxY.abs())-50;
              _controller.value = Matrix4.identity()..translate(-x,-y);
              print('positioning at '+(course.title ??' unnamed')+': '+x.toString()+' : '+y.toString());

            }
*/

          }
          return SizedOverflowBox(
            size: Size(screenWidth * 2, screenHeight),
            // width: screenWidth*2,
            // height: screenHeight*2,
            child: InteractiveViewer(
              transformationController: _controller,
              //alignPanAxis: true,
              panAxis: PanAxis.horizontal,
              panEnabled: true,
              scaleEnabled: false,
              // boundaryMargin: EdgeInsets.all(80),
              minScale: 0.1,
              maxScale: 5,

              clipBehavior: Clip.none,
              boundaryMargin: EdgeInsets.only(left:screenWidth,right:screenWidth),//EdgeInsets.all(double.infinity),
              constrained: false,
              child: Container(
                width: screenWidth * 2,
                height: screenHeight-240,
                child:Stack(
                  //Stack contains the stations as Positioned elements

                    clipBehavior: Clip.none,

                    children: [
                      /*Placeholder(
                  color: Colors.green,
                ),*/
                      ...dots]),
              ),
            ),

          );
        }
        else {
          print('data length was '+data.length.toString());
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
        }
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

      default:
      //data loading in progress
        print('Default case entered: '+_loadingStates['stations'].toString());
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
    return Container(height:300,width:200,child:ListView(children:items));
  }

  List<Widget> createArrows(elearningCourse, child) {
    print('Creating arrows for '+elearningCourse.title);
    print('-----');
    List<Widget> widgets = [];
    List<dynamic> targets = [];
    if(targets.isNotEmpty) targets.clear();
    Map<String,double> sourceAlignment = {},targetAlignment = {};
    String lineDirection='';
    var targetFound = false;
    var sourceFound = false;
    var station;
    if (elearningCourse.requiredKnowledge != null) {
      //int targetX = 0,targetY = 0;
      int sourceX = elearningCourse.canvasX;
      int sourceY = elearningCourse.canvasY;
      //  print(elearningCourse.requiredKnowledge.toString());
      for (var i in elearningCourse.requiredKnowledge) {
        //String defaultColor = '#ffffff';
        String lineColor = '#ffffff';
        String stationName='';
        //  print('resetting linecolour');

        if(this.lineData.isNotEmpty)
        {
          // check if both source and target appear on a line
          bool linePrinted = false;
          for (var l in lineData)
          {
            //reset alignment
            sourceAlignment['h'] = targetAlignment['h'] = sourceAlignment['h'] = targetAlignment['v'] = 0.0;
            //   print('Iterating line '+l['name']+' colour '+l['colour']);
            sourceFound = targetFound = false;
            lineDirection ='';
            if(l['stations']!= null) {
              // print('checking line '+l['name']+': '+l['stations'].toString());

              if (l['stations'].contains(elearningCourse.id)) {
                //     print(elearningCourse.id.toString()+' '+elearningCourse.title+' was found on line '+l['name']+' in '+l['stations'].toString());
                sourceFound = true;
              }
              if (l['stations'].contains(i) && sourceFound) {

                targetFound = true;
                station = this.data.singleWhere((stations)=>stations.id==i,orElse:()=>new ElearningCourse());

                int targetX = station.canvasX;
                int targetY = station.canvasY;
                if(targetX == sourceX)
                {
                  //vertical
                  lineDirection ='vertical';
                  print('vertical');
                  //     sourceAlignment['h'] = 0.0;
                  //    targetAlignment['h'] = 0.0;
                }
                else if(targetY ==sourceY) {
                  //horizontal
                  lineDirection = 'horizontal';
                  print('horizontal');
                  //  sourceAlignment['v'] = 0.0;
                  // targetAlignment['v'] = 0.0;

                }
                else {
                  if (targetY > sourceY) {
                    //up
                    lineDirection='down';
                    //  sourceAlignment['v'] = 1.0;
                    // targetAlignment['v'] = -1.0;
                  }
                  else if (targetY < sourceY) {
                    lineDirection='up';
                    // sourceAlignment['v'] = -1.0;
                    // targetAlignment['v'] =  1.0;
                  }
                  if (targetX > sourceX) {
                    // ->
                    print('to right');
                    lineDirection+='right';
                    // sourceAlignment['h'] = 1.0;
                    // targetAlignment['h'] = -1.0;
                  }
                  if (targetX < sourceX) {
                    // <-
                    lineDirection+='left';
                    print('to left');
                    // sourceAlignment['h'] = 1.0;
                    // targetAlignment['h'] = -1.0;
                  }

                }


                stationName = station.title??'';
              }

              //  print(sourceAlignment.toString()+' '+targetAlignment.toString());
              if (sourceFound && targetFound){
                linePrinted = true;
                print('Route '+elearningCourse.title+'->'+station.title.toString()+' found on line '+l['name']);
                /*print(
                        'path '+elearningCourse.title+':' + elearningCourse.id.toString() + '-' +
                            i.toString() + ' found on line ' + l['name']+', setting colour '+l['colour']);
*/
                //  print('setting linecolor to '+l['colour']);
                lineColor = l['colour'];
                String route = elearningCourse.id.toString()+'-'+i.toString();
                targets.add({
                  'direction' : lineDirection,
                  'title' : stationName,
                  'id': 'station' + i.toString(),
                  'colour': lineColor,
                  'track' :  mapRoutes[route]
                });
                mapRoutes.update(
                  route,
                      (value) => ++value,
                  ifAbsent: () => 1,
                );
              }
              else {

              }
            }

            //    else print('line has no stations');
          }
          if(!linePrinted)
          {
            // Print also route without lines (shows white)
            String route = elearningCourse.id.toString()+'-'+i.toString();
            targets.add({
              'direction' : lineDirection,
              'title' : stationName,
              'id': 'station' + i.toString(),
              'colour': lineColor,
              'track' :  mapRoutes[route]
            });
            mapRoutes.update(
              route,
                  (value) => ++value,
              ifAbsent: () => 1,
            );
          }

        }
        //  else print('linedata is empty');


        //   print('adding target ' + i.toString() + ' with colour ' + lineColor+', '+route+' track '+mapRoutes[route].toString());


      }
    }
    if(targets.length>0) {
      //List<String> targetNames = [];
      String? colour;
      // print('Creating Arrowelement station'+elearningCourse.id.toString()+' '+elearningCourse.title+' targeting '+targets.length.toString()+' stations: '+targets.toString());
      int i = 1;
      for (var line in targets) {

        //targetNames.add(line['id']);
        if(line['colour']!='') colour = line['colour'];
        String stationId = 'station' + elearningCourse.id.toString();
        String routeId = elearningCourse.id.toString()+'.'+line['id'];

        mapRoutes.update(
          routeId,
              (value) => ++value,
          ifAbsent: () => 1,
        );

        if(!stationIds.contains(stationId)) {
          print('adding stationid '+stationId);
          stationIds.add(stationId);
        }
        else {
          while (stationIds.contains(stationId + '-' + i.toString())) {
            i++;
            print('incrementing stadionid: ' + stationId + '-' + i.toString());
          }
          stationId = stationId + '-' + i.toString();
          stationIds.add(stationId);
        }
        print('Route number '+mapRoutes[routeId].toString()+' direction: '+line['direction']);
        switch(mapRoutes[routeId]) {
          case 2:
            switch(line['direction']){
              case 'vertical':
                sourceAlignment['h'] = targetAlignment['h'] = -0.5;
                break;
              case 'horizontal':
                sourceAlignment['v'] = targetAlignment['v'] = -0.5;
                break;
              case 'upleft':
                sourceAlignment['h'] = -0.6;
                sourceAlignment['v'] = 0.3;
                targetAlignment['h'] = -0.6;
                targetAlignment['v'] = 0.3;
                break;
              case 'upright':
                sourceAlignment['h'] = -0.6;
                sourceAlignment['v'] = 0.0;
                targetAlignment['h'] = -0.6;
                targetAlignment['v'] = 0.0;
                break;
              case 'downright':
                sourceAlignment['h'] = 0.0;
                sourceAlignment['v'] = 0.0;
                targetAlignment['h'] = 0.0;
                targetAlignment['v'] = 0.0;
                break;
              case 'downleft':
                sourceAlignment['h'] = 0.0;
                sourceAlignment['v'] = 0.0;
                targetAlignment['h'] = 0.0;
                targetAlignment['v'] = 0.0;
                break;
              default:
                sourceAlignment['h'] = targetAlignment['h'] = -0.5;

            }
            break;
          case 3:
            if(line['direction']=='vertical')
            {
              sourceAlignment['h'] = targetAlignment['h'] = 0.5;
            }
            if(line['direction']=='horizontal')
              sourceAlignment['v'] = targetAlignment['v'] = 0.5;
            break;
          default:
            sourceAlignment['v'] = targetAlignment['v'] = 0.0;

        }

        print('Creating arrow '+mapRoutes[routeId].toString()+' for '+elearningCourse.title+' -> '+line['title']+' ('+stationId+' - '+line['id']+') '+(colour ??'default colour'));
        print(Alignment(sourceAlignment['h'] ?? 0.0,sourceAlignment['v'] ?? 0.0).toString());
        widgets.add(ArrowElement(

          bow: 0.0,
          width: 2,
          tipLength: 0,
          //doubleSided: true,
          straights: true,
          show: true,
          stretch:0,
          stretchMax: 0,
          padEnd: 14,//24 ,
          padStart:14,//24,
          id: stationId,
          // targetIds: targetNames,
          targetId: line['id'],
          sourceAnchor: Alignment(sourceAlignment['h'] ?? 0.0,sourceAlignment['v'] ?? 0.0),
          targetAnchor: Alignment(targetAlignment['h'] ?? 0.0,targetAlignment['v'] ?? 0.0),
          color: colour!=null ? createMaterialColor(colour) : Colors.primaries[Random().nextInt(Colors.primaries.length)],
          child: child,
        )
        );

      }

/*
        print('creating arrowelement station'+elearningCourse.id.toString()+'-'+targetNames.toString());
     widgets.add(ArrowElement(

        bow: 0.0,
        width: 2,
        tipLength: 5,
        //doubleSided: true,
        straights: true,
        show: true,
        stretch:0,
        stretchMax: 0,
        padEnd: 14,//24 ,
        padStart:14,//24,
        id: stationId,
        targetIds: targetNames,
        //targetId: line['id'],
        sourceAnchor: Alignment.centerLeft,
        targetAnchor: Alignment.bottomRight,
        color: colour!=null ? createMaterialColor(colour) : Colors.primaries[Random().nextInt(Colors.primaries.length)],
        child: child,
      )
      );

*/

    }
    else {
      print('Creating arrowelement station'+elearningCourse.id.toString()+' '+elearningCourse.title+' with no targets');

      widgets.add(ArrowElement(
        bow: 0,
        width: 2,
        tipLength: 0,
        doubleSided: true,
        straights: true,
        show: true,
        //  padEnd: 24,
        // padStart: 24,
        id: 'station' + elearningCourse.id.toString(),
        sourceAnchor: Alignment(sourceAlignment['h'] ?? 0.0,sourceAlignment['v'] ?? 0.0),
        targetAnchor: Alignment(targetAlignment['h'] ?? 0.0,targetAlignment['v'] ?? 0.0),
        color: Colors.green,

        child: child,
      )
      );
    }


    return widgets;
  }
}
