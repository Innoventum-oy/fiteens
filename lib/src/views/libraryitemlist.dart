import 'package:flutter/material.dart';
import 'package:luen/src/objects/libraryitem.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:luen/src/objects/webpage.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectmodel;
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/util/utils.dart';
import 'package:luen/src/providers/user_provider.dart';
import 'package:luen/src/util/widgets.dart';
import 'package:luen/src/views/libraryitemlist_item.dart';
//import 'package:luen/src/providers/webpageprovider.dart';
import 'package:provider/provider.dart';
import 'package:luen/src/views/webpagetextcontent.dart';

class VerticalItemList extends StatefulWidget {
  final String viewTitle = 'booklist';
  final objectmodel.LibraryItemProvider provider = objectmodel.LibraryItemProvider();
  final objectmodel.ImageProvider imageprovider = objectmodel.ImageProvider();
  final String viewtype;

  VerticalItemList({this.viewtype='all'});

  @override
  _VerticalItemListState createState() => _VerticalItemListState();
}

class _VerticalItemListState extends State<VerticalItemList>  {

  Map<String,dynamic>? map;
  List<LibraryItem> data =[];
  User? user;
  LoadingState _loadingState = LoadingState.DONE;
  //bool _isLoading = false;
  int iteration =1;
  int buildtime = 1;
  int limit = 20;
  //int _pageNumber = 0;
  String? errormessage;
  WebPage page = new WebPage();

  notify(String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
/*
  _loadWebPage(user)async {
    print('calling loaditem for webpage');
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
*/
  /*
  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      //User user = Provider.of<UserProvider>(context,listen: false).user;
    //  _loadNextPage(user);
      super.initState();
    });


  }
  @protected
  //@mustCallSuper
  void dispose() {

    super.dispose();
  }
*/
  @override
  Widget build(BuildContext context){
  print('building libraryitemlist');

  User user = Provider.of<UserProvider>(context,listen: false).user;

  bool isTester = false;
  if(user.data!=null) {
    if (user.data!['istester'] != null) {
      if (user.data!['istester'] == 'true') isTester = true;
    }
  }
  bool hasInfoPage =
  this.page.id != null && this.page.runtimeType.toString() == 'WebPage'
      ? true
      : false;
    return DefaultTabController(
      length:2,
      child:new Scaffold(
      appBar: new AppBar(
          title: new Text(AppLocalizations.of(context)!.myBooks),
          actions: [
            if(hasInfoPage)IconButton(
                icon: Icon(Icons.info_outline_rounded),
                onPressed:(){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ContentPageView(widget.viewTitle,providedPage:this.page),
                  ));}
            ),
          if(isTester) IconButton(
        icon: Icon(Icons.bug_report),
    onPressed:(){feedbackAction(context,user); }
    ),
    ],
        bottom: TabBar(
          //labelColor: Colors.black,
          //indicatorColor: Colors.black,
          tabs: [
            Tab(
              text: AppLocalizations.of(context)!.readList,
            ),
            Tab(
              text:AppLocalizations.of(context)!.readBooksList,
            )
          ]
        ),// Tabs
      ),

      body: TabBarView(
          children:[
            _getContentSection(user,['pending','rejected']),
            _getContentSection(user,['accepted']),
        ]),
          bottomNavigationBar: bottomNavigation(context,currentIndex: 3)
    ),
    );
  }

  Widget _getContentSection(user,readstatus) {
    List<LibraryItem> allBooks = Provider
        .of<UserProvider>(context)
        .myBooks;

    List<LibraryItem>? myBooks = allBooks.where((book)=>
        readstatus.contains(book.readstatus)).toList();

    print('loading state: '+_loadingState.toString());

    switch (_loadingState) {
      case LoadingState.DONE:

        //data loaded
        if(myBooks.isNotEmpty)
        return ListView.builder(
            itemCount: myBooks.length,
            itemBuilder: (BuildContext context, int index) {
              /*
              all books are returned at once
              if (!_isLoading && index > (data.length * 0.7)) {
              /
              print('calling loadnextpage, user token is '+user.token);
                _loadNextPage(user);
              }
*/
              return LibraryItemListItem(myBooks[index]);
            });
        else return Text(AppLocalizations.of(context)!.readListIsEmpty);
      case LoadingState.ERROR:
        //data loading returned error state
        return Align(alignment:Alignment.center,
            child:ListTile(
              leading: Icon(Icons.error),
              title: Text('Sorry, there was an error loading the data: $errormessage'),
            ),
        );

      case LoadingState.LOADING:
        //data loading in progress
        return Align(alignment:Alignment.center,
          child:Center(
            child:ListTile(
              leading:CircularProgressIndicator(),
              title: Text(AppLocalizations.of(context)!.loading,textAlign: TextAlign.center),
          ),
          ),
        );
      default:
        return Container();
    }
  }
/*
 _loadNextPage(user) async {
    _isLoading = true;
    int offset = limit * _pageNumber;

    final Map<String, String> params = {

      'limit' : limit.toString(),
      'offset' : offset.toString(),
      'fields' : 'title,description,coverpictureurl,level,identifier',
      'api-key':user.token,
      'api_key':user.token,
      'sort' : 'title',
    };


    print('Loading page $_pageNumber');
    try {

     List <LibraryItem> libraryItems = (await widget.provider.loadItems(params)).cast<LibraryItem>();
      setState(() {
        _loadingState = LoadingState.DONE;
        data.addAll(libraryItems);
        print(data.length.toString()+' library items currently loaded!');
        _isLoading = false;
        _pageNumber++;
      });
    } catch (e,stack) {
      _isLoading = false;
      print('loadItems returned error $e\n Stack trace:\n $stack');
      errormessage = e.toString();
      if (_loadingState == LoadingState.LOADING) {
        setState(() => _loadingState = LoadingState.ERROR);
      }
    }
  }
 */

}