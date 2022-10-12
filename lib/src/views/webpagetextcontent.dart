import 'package:flutter/material.dart';
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/providers/webpageprovider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:luen/src/providers/user_provider.dart';
import 'package:luen/src/util/utils.dart';
import'package:luen/src/objects/webpage.dart';
import 'package:flutter_html/flutter_html.dart';

import '../util/app_url.dart';

/*
* View for displaying selected webpage text contents from iCMS. Fetches the page contents from server based on commonname + language parameters.
* Expects to receive array of text editor blocks to display
*/

class ContentPageView extends StatefulWidget {
  final String commonname;
  final WebPage? providedPage;
  final WebPageProvider pageProvider = WebPageProvider();
  final String? route;
  final Widget? bottomNavigationBar;

  ContentPageView(this.commonname,{this.providedPage,this.route,this.bottomNavigationBar});
  @override
  _ContentPageViewState createState() => _ContentPageViewState();
}

class _ContentPageViewState extends State<ContentPageView> {

  LoadingState _pageLoadingState = LoadingState.LOADING;
  String? errormessage;
  List<WebPage> pages = [];

  _loadWebPage(String commonname,user) async {

    final Map<String, String> params = {

      'language' : Localizations.localeOf(context).toString(),
      'commonname': commonname,
      'fields' :'id,commonname,pagetitle,textcontents,thumbnailurl',
      'api_key': user.token ?? AppUrl.anonymousApikey,

    };

    try {
   //   print('Loading page '+widget.commonname);

     WebPage page = await widget.pageProvider.loadItem(params);
      this.pages.add(page);
      setState(() {
     //   print('Loaded page '+widget.commonname);
       // print('page info: '+page.id.toString()+': ' +page.commonname.toString());

        _pageLoadingState = LoadingState.DONE;

        //pages.addAll(result);
        // print(result.length.toString() + ' pages currently loaded!');
        //_isLoading = false;
      });
    } catch (e, stack) {
      // _isLoading = false;
      print('loadPages returned error $e\n Stack trace:\n $stack');
      errormessage = e.toString();
      if (_pageLoadingState == LoadingState.LOADING) {
        setState(() => _pageLoadingState = LoadingState.ERROR);
      }
    }
  }
  _setWebPage(){
    print('setting provided webpage');
    this.pages.add(widget.providedPage!);
    setState(() =>
    _pageLoadingState = LoadingState.DONE);
  }
  @override
  void initState() {
    this._pageLoadingState = LoadingState.LOADING;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      User user = Provider.of<UserProvider>(context, listen: false).user;

      if(widget.providedPage!=null) {
        print(widget.providedPage!.data?.toString());
        print('setting provided page '+(widget.providedPage!.pagetitle ??''));
        _setWebPage();
      }
      else {
        print('loading page '+widget.commonname);
        _loadWebPage(widget.commonname, user);

      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
  //print('page title: '+this.pages[0].pagetitle.toString());

    return Scaffold(
        appBar: AppBar(
          title: Text(this.pages.isNotEmpty && this.pages[0].pagetitle!=null ? this.pages[0].pagetitle!.toString() : AppLocalizations.of(context)!.pageContent),
          elevation: 0.1,
        ),
        body: _getPageSection(user),
        bottomNavigationBar : widget.bottomNavigationBar ?? null
    );
  }


  Widget _getPageSection(user) {
    print('pagesection - pageloadingstate: '+_pageLoadingState.toString());
    switch (_pageLoadingState) {
      case LoadingState.DONE:
      //data loaded
        if(this.pages.isEmpty) return Container(
          child:ListTile(
              leading: Icon(Icons.error),
              title: Text(AppLocalizations.of(context)!.contentNotFound+' ('+widget.commonname+' ['+Localizations.localeOf(context).toString()+'])')),
        );
        return ListView.builder(
            itemCount: this.pages.length,
            itemBuilder: (BuildContext context, int index) {
              return _pageContentSection(this.pages[index]);
            });

      case LoadingState.ERROR:
      //data loading returned error state
        return Container(
          alignment: Alignment.center,
          child: ListTile(
            leading: Icon(Icons.error),
            title: Text(
                'Sorry, there was an error loading the data: $errormessage'),
          ),
        );

      case LoadingState.LOADING:
      //data loading in progress
        return Container(
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

  Widget _pageContentSection(page) {
    List<Widget> textContents = [];
    //textContents.add(Text(page.pagetitle!=null ? page.pagetitle : 'No title',style: Theme.of(context).textTheme.headline4),);
    if(page.textcontents!=null)
    for(var i in page.textcontents)
      textContents.add(Html(data:i.toString()));
    if(widget.route == null) textContents.add(Align(alignment:Alignment.center,
        child:ElevatedButton(
            onPressed: () {
              if(widget.route!=null) {
              print('pushing route'+widget.route!);
                Navigator.pushNamedAndRemoveUntil(
                    context, widget.route!, (Route<dynamic> route) => false);
              }
            else  Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.btnReturn)
        ),
    ));
    return Container(
        child:
        Column(
            children:textContents
        )

    );
  }
}
