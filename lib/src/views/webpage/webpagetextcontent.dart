import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:core/core.dart';
import '../../util/constants.dart';

/// View for displaying selected webpage text contents from iCMS. Fetches the page contents from server based on commonname + language parameters.
/// Expects to receive array of text editor blocks to display


class ContentPageView extends StatefulWidget {
  final String commonname;
  final String language;
  final WebPage? providedPage;
  final WebPageProvider pageProvider = WebPageProvider();
  final String? route;
  final Widget? bottomNavigationBar;

  ContentPageView(this.commonname,
      {this.language='en',this.providedPage, this.route, this.bottomNavigationBar});
  @override
  _ContentPageViewState createState() => _ContentPageViewState();
}

class _ContentPageViewState extends State<ContentPageView> {
  String? errormessage;
  WebPage? page;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      User user = Provider.of<UserProvider>(context, listen: false).user;

      if (widget.providedPage != null) {
        this.page =widget.providedPage!;

      } else {
        final Map<String, String> params = {
          'language': Localizations.localeOf(context).toString(),
          'commonname': widget.commonname,
          'fields': 'id,commonname,pagetitle,textcontents,thumbnailurl',
          'api_key': user.token ?? AppUrl.anonymousApikey,
        };
        widget.pageProvider.loadItem(params);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(this.page==null) this.page = Provider.of<WebPageProvider>(context).page;
    String pageTitle = this.page?.pagetitle ?? AppLocalizations.of(context)!.pageContent;
    return Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
          elevation: 0.1,
        ),
        body: _pageContentSection(this.page),
        bottomNavigationBar: widget.bottomNavigationBar ?? null);
  }



  Widget _pageContentSection(page) {
    List<Widget> textContents = [];
    //textContents.add(Text(page.pagetitle!=null ? page.pagetitle : 'No title',style: Theme.of(context).textTheme.headline4),);
    if (page != null && page.textcontents != null)
      for (var i in page.textcontents)
        textContents.add(Html(data: i.toString()));
    if (widget.route == null)
      textContents.add(Align(
        alignment: Alignment.center,
        child: ElevatedButton(
            onPressed: () {
              if (widget.route != null) {
                if(kDebugMode){
                  print('pushing route' + widget.route!);
                }
                Navigator.pushNamedAndRemoveUntil(
                    context, widget.route!, (Route<dynamic> route) => false);
              } else
                Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.btnReturn)),
      ));
    return Container(child: Column(children: textContents));
  }
}
