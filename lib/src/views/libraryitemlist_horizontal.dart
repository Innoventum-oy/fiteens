import 'package:flutter/material.dart';
import 'package:luen/src/objects/libraryitem.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectmodel;
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/util/utils.dart';
import 'package:luen/src/providers/user_provider.dart';
import 'package:luen/src/util/navigator.dart';

import 'package:provider/provider.dart';

class LibraryItemList extends StatefulWidget {
  final objectmodel.LibraryItemProvider libraryItemProvider;
  final objectmodel.ImageProvider imageprovider;
  final int level;
  late final int? collection;
  final int height;
  final double width;
  LibraryItemList(this.libraryItemProvider, this.imageprovider, {this.level = 1,this.collection,this.height=400,this.width=200});

  @override
  _LibraryItemListState createState() => _LibraryItemListState();
}

class _LibraryItemListState extends State<LibraryItemList> {

  Map<String, dynamic>? map;
  List<LibraryItem> data = [];
  User? user;
  LoadingState _loadingState = LoadingState.LOADING;
 // bool _isLoading = false;
  int iteration = 1;
  int buildtime = 1;
  int limit = 20;
  int _pageNumber = 0;
  String? errorMessage;

  notify(String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _loadNextPage(user) async {
    //_isLoading = true;
    _loadingState = LoadingState.WAITING;
    int offset = limit * _pageNumber;

    final Map<String, String> params = {
      //'coursestatus': 'active',
     // 'action':'getitemsincollection',
      'limit': limit.toString(),
      'offset': offset.toString(),
      'collections': 'id='+widget.collection.toString(),
      'level' : widget.level.toString(),
      'fields': 'title,description,coverpictureurl,level,identifier,authors,authorname,readstatus,hashtags,themes,objectratingcount,objectrating,userrating,pageount',
      'api_key': user.token,
      'method' : 'json',
      'sort': 'title',
    };

    print('Loading page $_pageNumber'+' for collection '+widget.collection.toString()+', level '+widget.level.toString());
    try {
     /* List <LibraryItem> libraryItems = (await widget.provider.loadCollectionItems(
          params)).cast<LibraryItem>();*/
      dynamic libraryItems = await widget.libraryItemProvider.loadCollectionItems(params);
      setState(() {
        _loadingState = LoadingState.DONE;
        data.addAll(libraryItems);
        print(data.length.toString() + ' library items currently loaded!');
       // _isLoading = false;
        _pageNumber++;
      });
    } catch (e, stack) {
    //  _isLoading = false;
      print('loadItems returned error $e\n Stack trace:\n $stack');
      errorMessage = e.toString();
      if (_loadingState == LoadingState.LOADING || _loadingState == LoadingState.WAITING) {
        setState(() => _loadingState = LoadingState.ERROR);
      }
    }
  }

  @override
  void initState() {
    print('initState called for LibraryItemList');
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //User user = Provider.of<UserProvider>(context,listen:false).user;
      this.data = [];
      _loadNextPage(this.user);
    });

  }

  @override
  Widget build(BuildContext context) {
    print('build $iteration called for LibraryItemList');
    this.iteration++;
    this.user = context.watch<UserProvider>().user;
    //this.user = Provider.of<UserProvider>(context).user;

    return _getContentSection(user);
  }

  Widget _getContentSection(user) {
    print('loading state: ' + _loadingState.toString());


    switch (_loadingState) {
      case LoadingState.DONE:
      //data loaded
        return ListView.builder(
            //padding: EdgeInsets.symmetric(vertical: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
          /*    if (!_isLoading && index > (data.length * 0.7)) {
                print('calling loadnextpage, user token is ' + user.token);
                _loadNextPage(user);
              }
*/
              return libraryItemHorizontal(data[index]);
            });
      case LoadingState.ERROR:
      //data loading returned error state
        return Align(alignment: Alignment.center,
          child: ListTile(
            leading: Icon(Icons.error),
            title: Text(
                'Sorry, there was an error loading the data: $errorMessage'),
          ),
        );

      case LoadingState.LOADING:
      //data loading in progress
        return Align(alignment: Alignment.center,
          child: Center(
            child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text(AppLocalizations.of(context)!.loading,
                  textAlign: TextAlign.center),
            ),
          ),
        );
      default:
        return Container();
    }
  }


  Widget libraryItemHorizontal(libraryItem) {
    //print('item id: '+libraryItem.id.toString());
    List<Widget> buttons = [];
    buttons.add(TextButton(
      child: Text(AppLocalizations.of(context)!.readMore),
      onPressed: () {
        /* open library view */
        goToLibraryItem(context, libraryItem);
      },
    ));
    buttons.add(const SizedBox(width: 8));

    if (libraryItem.accesslevel >= 20) {
      //user has modify access
    }
    Widget statusInfoWrap(contents)
    {

      return Align(
          alignment: Alignment.topRight,
          child:Container(
          padding: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child:Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children:
              contents)
      )
      );
    }
    Widget readStatusInfo = Container();

    switch(libraryItem.readstatus){
      case 'accepted': readStatusInfo = statusInfoWrap(
          [
            Icon(Icons.check_circle_outlined,
            color:Colors.green),
            Text('Luettu',
            style: TextStyle(
              color:Colors.black
            ),),
      ]);
      break;
      case 'pending' :
        readStatusInfo = statusInfoWrap([
          Icon(Icons.bookmark, color:Colors.black),
          Text('Lukulistalla',
          style: TextStyle(
          color:Colors.black
          ),),
        ]);


          break;
      default:
        readStatusInfo=Container();//Text(libraryItem.readstatus);
  }

    return SizedBox(
        width:widget.width,

      child:
    Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child:
        InkWell(
            onTap: () => goToLibraryItem(context, libraryItem),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Card(

                    elevation: 18.0,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children:[
                        libraryItem.coverpictureurl != null
                        ? Image.network(
                        libraryItem.coverpictureurl!,
                        width: (widget.width-10),
                        height:(widget.height-105),
                        fit: BoxFit.cover
                    )
                        : Icon(Icons.book),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: readStatusInfo
                        )
                  ]),
                  ),
                  Flexible(child:Text(libraryItem.title,
                    overflow:TextOverflow.ellipsis,
                    maxLines:2,),
                  ),

                   Padding(
                     padding: const EdgeInsets.only(left:8.0,right:8.0),
                     child: Text(libraryItem.authorname??'',
                     overflow:TextOverflow.ellipsis,
                     maxLines:3,
                     softWrap:false),
                   ),


                ]
            )
        )
    )
    );
  }
}