import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fiteens/src/util/utils.dart';
import 'package:fiteens/src/util/navigator.dart';
import 'package:provider/provider.dart';
import 'package:core/core.dart' as core;

class WebPageList extends StatefulWidget {
  final core.WebPageProvider webPageProvider;
  final core.ImageProvider imageProvider;
  final String? pageCategory;
  final int height;
  final double width;
  const WebPageList(this.webPageProvider, this.imageProvider,
      {super.key, this.pageCategory, this.height = 400, this.width = 200});

  @override
  WebPageListState createState() => WebPageListState();
}

class WebPageListState extends State<WebPageList> {
  Map<String, dynamic>? map;
  List<core.WebPage> data = [];
  core.User? user;
  LoadingState _loadingState = LoadingState.loading;
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
    _loadingState = LoadingState.waiting;
    int offset = limit * _pageNumber;

    final Map<String, String> params = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'fields':
          'title,description,coverpictureurl,level,identifier,authors,authorname,readstatus,hashtags,themes,objectratingcount,objectrating,userrating,pagecount',
      'api_key': user.token,
      'method': 'json',
      'sort': 'title',
    };
    if (widget.pageCategory != null) {
      params['pagecategory.commonname'] = widget.pageCategory!;
    }

    try {
      dynamic pages = await widget.webPageProvider.loadItems(params);
      setState(() {
        _loadingState = LoadingState.done;
        data.addAll(pages);
        // _isLoading = false;
        _pageNumber++;
      });
    } catch (e) {
      //  _isLoading = false;
      errorMessage = e.toString();
      if (_loadingState == LoadingState.loading ||
          _loadingState == LoadingState.waiting) {
        setState(() => _loadingState = LoadingState.error);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //User user = Provider.of<UserProvider>(context,listen:false).user;
      data = [];
      _loadNextPage(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    iteration++;
    user = context.watch<core.UserProvider>().user;
    //this.user = Provider.of<UserProvider>(context).user;

    return _getContentSection(user);
  }

  Widget _getContentSection(user) {

    switch (_loadingState) {
      case LoadingState.done:
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
              return webPageHorizontal(data[index]);
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
                  textAlign: TextAlign.center),
            ),
          ),
        );
      default:
        return Container();
    }
  }

  Widget webPageHorizontal(webPage) {
    //print('item id: '+webPage.id.toString());
    List<Widget> buttons = [];
    buttons.add(TextButton(
      child: Text(AppLocalizations.of(context)!.readMore),
      onPressed: () {
        /* open library view */
        goToWebPage(context, webPage);
      },
    ));
    buttons.add(const SizedBox(width: 8));

    if (webPage.accesslevel >= 20) {
      //user has modify access
    }
    Widget statusInfoWrap(contents) {
      return Align(
          alignment: Alignment.topRight,
          child: Container(
              padding: const EdgeInsets.all(2.0),
              decoration: const BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: contents)));
    }

    Widget readStatusInfo = Container();

    switch (webPage.readstatus) {
      case 'accepted':
        readStatusInfo = statusInfoWrap([
          const Icon(Icons.check_circle_outlined, color: Colors.green),
          const Text(
            'Luettu',
            style: TextStyle(color: Colors.black),
          ),
        ]);
        break;
      case 'pending':
        readStatusInfo = statusInfoWrap([
          const Icon(Icons.bookmark, color: Colors.black),
          const Text(
            'Lukulistalla',
            style: TextStyle(color: Colors.black),
          ),
        ]);

        break;
      default:
        readStatusInfo = Container(); //Text(webPage.readstatus);
    }

    return SizedBox(
        width: widget.width,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: InkWell(
                onTap: () => goToWebPage(context, webPage),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Card(
                        elevation: 18.0,
                        child: Stack(alignment: Alignment.topCenter, children: [
                          webPage.coverpictureurl != null
                              ? Image.network(webPage.coverpictureurl!,
                                  width: (widget.width - 10),
                                  height: (widget.height - 105),
                                  fit: BoxFit.cover)
                              : const Icon(Icons.book),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: readStatusInfo)
                        ]),
                      ),
                      Flexible(
                        child: Text(
                          webPage.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(webPage.authorname ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            softWrap: false),
                      ),
                    ]))));
  }
}
