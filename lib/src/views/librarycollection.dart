import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:intl/intl.dart';
import 'package:luen/src/objects/librarycollection.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectmodel;
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/providers/user_provider.dart';
import 'package:luen/src/util/widgets.dart';
//import 'dart:async';
import 'package:provider/provider.dart';
//import 'package:luen/src/util/api_client.dart';
import 'package:luen/src/util/styles.dart';
import 'package:luen/src/util/utils.dart';
import 'package:luen/src/views/utilviews.dart';
import 'package:luen/src/views/libraryitemlist_horizontal.dart';

class CollectionView extends StatefulWidget {
  //final LibraryCollection _collection;
  final int? collectionId;

  final objectmodel.LibraryCollectionProvider collectionProvider;
  final objectmodel.ImageProvider imageProvider;
  final objectmodel.LibraryItemProvider libraryItemProvider =
      objectmodel.LibraryItemProvider();

  CollectionView(
      this.collectionId, this.collectionProvider, this.imageProvider);

  @override
  _CollectionViewState createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {

  //final ApiClient _apiClient = ApiClient();
  Map<String, dynamic>? map;
  LibraryCollection collection = LibraryCollection();
  LoadingState _loadingState = LoadingState.LOADING;
  int iteration = 1;
  int buildtime = 1;
  //bool _visible = false;
  User? user;
  //bool _isloading = false;
  String appbarTitle = 'Station';

  notify(String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    print('initState called for CollectionView');
    super.initState();
    _loadingState = LoadingState.LOADING;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this.user = Provider
          .of<UserProvider>(context, listen: true)
          .user;

      _loadCollection(this.user);
    });

    //Timer(Duration(milliseconds: 100), () => setState(() => _visible = true));
  }

  @protected
  //@mustCallSuper
  void dispose() {
    _loadingState = LoadingState.LOADING;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.user = Provider
        .of<UserProvider>(context, listen: true)
        .user;
    if (collection.id == null) {
      setState(() {
        _loadingState = LoadingState.LOADING;
        _loadCollection(this.user);
      });
    }
    print('rebuilding collection view. loading state: ' +
        _loadingState.toString());
    switch (_loadingState) {
      case LoadingState.DONE:
        return Scaffold(
            backgroundColor: primary,
            body: CustomScrollView(
              slivers: <Widget>[
                _buildAppBar(collection),
                _buildContentSection(collection),
              ],
            ));

      case LoadingState.ERROR:
      //return error information
        return Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text(appbarTitle),
             /* leading: IconButton(icon: Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              )*/
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
                          print('Refreshing view');
                          setState(() {
                            _loadingState = LoadingState.LOADING;
                            _loadCollection(user);
                          });
                        })
                  ]
              )
          ),
         bottomNavigationBar: bottomNavigation(context)
        );

      case LoadingState.LOADING:
      //data loading in progress
        return Scaffold(
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

  List<Widget> buttons(LibraryCollection collection) {

    List<Widget> buttons = [];
    buttons.add(Container());
    if (collection.accesslevel >= 20) {}
    return buttons;
  }

  Widget _buildAppBar(LibraryCollection collection) {
    return SliverAppBar(
      expandedHeight: 240.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: "course-Tag-${collection.id}",
              child: collection.coverpictureurl != null
                  ? FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: 'images/collection-placeholder.png',
                image: collection.coverpictureurl!,
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
  Widget _buildMetaSection(LibraryCollection collection) {

    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                TextBubble(
                  collection.title.toString(),
                  backgroundColor: Color(0xffF47663),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(collection.title!,
                  style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 20.0)),
            ),
          ],
        ),
      ),
    );
  }
*/
  void _loadCollection(user) async {
    if (widget.collectionId == null) {
      _loadingState = LoadingState.ERROR;
      print('Could not load collection, collection ID not provided');
      return;
    }
    print('loading collection ' + widget.collectionId.toString()+' for user '+user.firstname+' '+user.lastname);
    try {
      dynamic details = await widget.collectionProvider
          .getDetails(widget.collectionId!, user);
      setState(() {

        collection = LibraryCollection.fromJson(details);
        _loadingState = LoadingState.DONE;
      });
    } catch (e, stack) {
      print('loadDetails returned error $e\n Stack trace:\n $stack');
      //Notify(e.toString());
      _loadingState = LoadingState.ERROR;
      e.toString();
    }
  }

  Widget _buildContentSection(LibraryCollection collection) {
    /*
    int calculateDifference(DateTime date) {
      DateTime now = DateTime.now();
      return DateTime(date.year, date.month, date.day)
          .difference(DateTime(now.year, now.month, now.day))
          .inDays;
    }
*/
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Container(
          decoration: BoxDecoration(color: const Color(0xff222128)),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  collection.title != null
                      ? collection.title.toString()
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
                    (collection.description != null
                        ? collection.description
                        : '')!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    )),
                Container(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
    ... user?.getCurrentStation() == collection.id ? bookLists(collection) : stationInfo(collection)
      ]),
    );
  }
  List<Widget> stationInfo(collection){

    int? currentstation = this.user?.getCurrentStation();
    return<Widget>[
      Text(collection.id.toString()+' is not the current station for user '+(this.user?.firstname ?? 'Anonymous')+': '+ (currentstation!=null ? currentstation.toString() : 'none'))
      ];
  }
  List<Widget> bookLists(collection)
  {
    return <Widget>[ Text(
      AppLocalizations.of(context)!.easyBooks,
      style: const TextStyle(
          color: Colors.lightGreen,
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
    ),
    collectionLevel(collection, 1),
    Text(
    AppLocalizations.of(context)!.moderateBooks,
  style: const TextStyle(
  color: Colors.amberAccent,
    fontSize: 20.0,
    fontWeight: FontWeight.bold),
  ),
  collectionLevel(collection, 2),
    Text(
    AppLocalizations.of(context)!.challengingBooks,
  style: const TextStyle(
  color: Colors.redAccent, fontSize: 20.0, fontWeight: FontWeight.bold),
  ),
  collectionLevel(collection, 3)];
  }
  Widget collectionLevel(collection,level)
  {
  return Container(
      height: 400.0,
      decoration: BoxDecoration(color: primaryDark),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: collection.id == null
            ? Container(child: Text('No books on this stop baby'))
            : LibraryItemList(
            widget.libraryItemProvider, widget.imageProvider,
            collection: collection.id,
            level:level),
      ),
    );
  }
}