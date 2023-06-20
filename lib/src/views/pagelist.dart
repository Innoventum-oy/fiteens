import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fiteens/src/util/utils.dart';
import 'package:fiteens/src/util/widgets.dart';
import 'package:fiteens/src/views/pagelist_item.dart';
import 'package:provider/provider.dart';
import 'package:fiteens/src/views/webpagetextcontent.dart';
import 'package:core/core.dart' as core;
class VerticalPageList extends StatefulWidget {
  final String viewTitle = 'pagelist';
  final core.WebPageProvider provider = core.WebPageProvider();
  final core.ImageProvider imageprovider = core.ImageProvider();
  //final List<String> pageCategory;

  VerticalPageList();

  @override
  _VerticalPageListState createState() => _VerticalPageListState();
}

class _VerticalPageListState extends State<VerticalPageList> {
  Map<String, dynamic>? map;
  List<core.WebPage> data = [];
  core.User? user;
  LoadingState _loadingState = LoadingState.loading;
  //bool _isLoading = false;
  int iteration = 1;
  int buildtime = 1;
  int limit = 20;
  //int _pageNumber = 0;
  String? errormessage;
  core.WebPage page = new core.WebPage();

  notify(String text) {
    final snackBar = SnackBar(
      content: Text(text),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _loadPages(user) async {
    final Map<String, String> params = {
      'fields':
          'id,pagetitle,textcontents,thumbnailurl,accesslevel,commonname,category',
      'api_key': user.token,
      'sort': 'pagetitle',
      'status': '2',
      'show_in_menu': '1',
      //'pagecategory' : "IS SET"
    };
    this.data = await widget.provider.loadItems(params);
    setState(() {
      this._loadingState = LoadingState.done;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.user = Provider.of<core.UserProvider>(context, listen: false).user;
      _loadPages(this.user);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('building WebPagelist');

    core.User user = Provider.of<core.UserProvider>(context, listen: false).user;

    bool isTester = false;
    if (user.data != null) {
      if (user.data!['istester'] != null) {
        if (user.data!['istester'] == 'true') isTester = true;
      }
    }
    bool hasInfoPage =
        this.page.id != null && this.page.runtimeType.toString() == 'WebPage'
            ? true
            : false;
    return DefaultTabController(
      length: 3,
      child: new Scaffold(
          appBar: new AppBar(
            title: new Text(AppLocalizations.of(context)!.resources),
            actions: [
              if (hasInfoPage)
                IconButton(
                    icon: Icon(Icons.info_outline_rounded),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ContentPageView(widget.viewTitle,
                            providedPage: this.page),
                      ));
                    }),
              if (isTester)
                IconButton(
                    icon: Icon(Icons.bug_report),
                    onPressed: () {
                      feedbackAction(context, user);
                    }),
            ],
            bottom: TabBar(
                //labelColor: Colors.black,
                //indicatorColor: Colors.black,
                //TODO: replace with pagecategories retrieved from server
                tabs: [
                  Tab(
                    text: AppLocalizations.of(context)!.physicalActivities,
                  ),
                  Tab(
                    text: AppLocalizations.of(context)!.healthyLifestyle,
                  ),
                  Tab(
                    text: AppLocalizations.of(context)!.healthyFood,
                  ),
                ]), // Tabs
          ),
          body: TabBarView(children: [
            _getContentSection(user, 'physicalactivities'),
            _getContentSection(user, 'healthylifestyle'),
            _getContentSection(user, 'healthyfood'),
          ]),
          bottomNavigationBar: bottomNavigation(context, currentIndex: 2)),
    );
  }

  Widget _getContentSection(user, pageCategory) {
    print('loading state: ' + _loadingState.toString());

    switch (_loadingState) {
      case LoadingState.done:
        List<core.WebPage>? pages =
            this.data.where((page) => pageCategory == page.category).toList();
        //data loaded
        print(pages.length.toString() +
            ' pages of type ' +
            pageCategory +
            ' found');
        if (pages.isNotEmpty)
          return ListView.builder(
              itemCount: pages.length,
              itemBuilder: (BuildContext context, int index) {
                /*
              all books are returned at once
              if (!_isLoading && index > (data.length * 0.7)) {
              /
              print('calling loadnextpage, user token is '+user.token);
                _loadNextPage(user);
              }
*/
                return WebPageListItem(pages[index]);
              });
        else
          return Text(AppLocalizations.of(context)!.noResourcesFound);
      case LoadingState.error:
        //data loading returned error state
        return Align(
          alignment: Alignment.center,
          child: ListTile(
            leading: Icon(Icons.error),
            title: Text(
                'Sorry, there was an error loading the data: $errormessage'),
          ),
        );

      case LoadingState.loading:
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

     List <WebPage> WebPages = (await widget.provider.loadItems(params)).cast<WebPage>();
      setState(() {
        _loadingState = LoadingState.DONE;
        data.addAll(WebPages);
        print(data.length.toString()+' library items currently loaded!');
        _isLoading = false;
        _pageNumber++;
      });
    } catch (e,stack) {
      _isLoading = false;
      print('loadItems returned error $e\n Stack trace:\n $stack');
      errormessage = e.toString();
      if (_loadingState == LoadingState.loading) {
        setState(() => _loadingState = LoadingState.ERROR);
      }
    }
  }
 */
}
