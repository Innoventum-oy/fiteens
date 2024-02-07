import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fiteens/src/util/utils.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fiteens/src/util/styles.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:core/core.dart' as core;

import '../../widgets/videoplayer.dart';


class WebPageView extends StatefulWidget {
  final core.WebPage _webPage;
  final core.WebPageProvider provider;
  final core.ImageProvider imageProvider;

  WebPageView(this._webPage, this.provider, this.imageProvider);

  @override
  _WebPageViewState createState() => _WebPageViewState();
}

class _WebPageViewState extends State<WebPageView> {
  //final ApiClient _apiClient = ApiClient();
  Map<String, dynamic>? map;

  int iteration = 1;
  int buildtime = 1;
  core.WebPage webPage = new core.WebPage();
  LoadingState _loadingState = LoadingState.waiting;
  //bool _visible = false;
  core.User? user;
  String? baseUrl;
  //dynamic _webPageDetails;
  // final core.ApiClient _apiClient = core.ApiClient();

  notify(String text) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    this.webPage = widget._webPage;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      _loadWebPage(this.user);

    });

    // Timer(Duration(milliseconds: 100), () => setState(() => _visible = true));
  }

  void _loadWebPage(user) async {
    if (_loadingState == LoadingState.loading)
      return;
    else if (_loadingState == LoadingState.waiting)
      _loadingState = LoadingState.loading;

    try {
      dynamic details =
          await widget.provider.getDetails(widget._webPage.id!);
        // if page has video, get base url
      if(details['data']['videourl']!=null){
        baseUrl = await core.ApiClient().baseUrl;
      }
      setState(() {
        if (details != null) {
          if(kDebugMode){
            log('webpageview: loaded details for id ${widget._webPage.id} with data $details');
          }
          this.webPage = core.WebPage.fromJson(details);
          _loadingState = LoadingState.done;
        } else {
          _loadingState = LoadingState.error;
        }

      });
    } catch (e, stack) {
      print('loadDetails returned error $e\n Stack trace:\n $stack');
      //Notify(e.toString());
      _loadingState = LoadingState.error;
      e.toString();
    }
  }



  @override
  Widget build(BuildContext context) {
     print('rebuilding webPage view');
    this.user = Provider.of<core.UserProvider>(context).user;

    return Scaffold(
        backgroundColor:appBackground,
        body: CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(),
            _buildContentSection(),
          ],
        ),
        bottomNavigationBar: bottomNavigation(context));
  }

  List<Widget> buttons(core.WebPage webPage) {
    List<Widget> buttons = [];
    buttons.add(Container());
    if (webPage.accesslevel >= 20) {}
    return buttons;
  }

  Widget _buildAppBar() {
    core.WebPage page = this.webPage;


    Widget heroWidget = Hero(
      tag: "WebPage-Tag-${widget._webPage.id}",
      child: widget._webPage.thumbnailUrl != null
          ? FadeInImage.assetNetwork(
        fit: BoxFit.contain,
        width: double.infinity,
        placeholder: 'images/webPage-placeholder.png',
        image: widget._webPage.thumbnailUrl!,
      )
          : Image(
          image: AssetImage('images/webPage-placeholder.png')),
    );

    return SliverAppBar(
      expandedHeight: 240.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            page.data?['videourl'] !=null ? (baseUrl!=null ?
            VideoPlayerElement(
              url: Uri.https(baseUrl!,page.data?['videourl']).toString(),
            )
                : CircularProgressIndicator()) :
            GestureDetector(
              onTap: () {
                if (widget._webPage.thumbnailUrl != null)
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailScreen(widget._webPage.thumbnailUrl!);
                  }));
              },
              child: heroWidget
            ),
            // BottomGradient(),
            //_buildMetaSection(webPage)
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    //final TextTheme textTheme = Theme.of(context).textTheme;
    core.WebPage webPage = this.webPage;

    print('building ContentSection for id ' +
        webPage.id.toString() +
        '/' +
        widget._webPage.id.toString());

    // List<Widget> buttons = [];
/*
    if (webPage.videoUrl != null) buttons.insert(0,ElevatedButton.icon(
      icon: Icon(Icons.movie),
      onPressed: ()async{
        if (!await launchUrl(Uri.parse(webPage.videoUrl!)))
          Flushbar(
            title: AppLocalizations.of(context)!.error,
            message: AppLocalizations.of(context)!.couldNotOpenLink+' '+(webPage.videoUrl??''),
            duration: Duration(seconds: 10),
          ).show(context);
          //throw 'Linkin avaaminen ei onnistunut $webPage.videoUrl';
        },
      label: Text('Katso video'),
    ));
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
                  webPage.pagetitle != null
                      ? webPage.pagetitle.toString()
                      : AppLocalizations.of(context)!.unnamedWebPage,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                if (webPage.author != null)
                  Container(
                    height: 8.0,
                  ),
                if (webPage.author != null)
                  Text(
                    webPage.author ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                Container(
                  height: 8.0,
                ),

                for (dynamic text in webPage.textcontents!)
                  Html(
                    data: text.toString(),
                    //  style: const TextStyle(color: Colors.white, fontSize: 13.0),
                  ),
                /* if (webPage.description != null)
                  Text(
                    (webPage.description??''),
                    style: const TextStyle(color: Colors.white, fontSize: 13.0),
                  ),
                Text(
                  (webPage.description??''),
                  style: const TextStyle(color: Colors.white, fontSize: 13.0),
                ),*/
                Container(
                  height: 8.0,
                ),

                //youtubePlayerWidget(webPage.videoId),
/*
    if(webPage.objectrating!=null)
    Center(child:RatingBarIndicator(
    rating:webPage.objectrating ?? 0 ,

    direction: Axis.horizontal,
    itemSize: 20,
    itemCount: 5,
    //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
    itemBuilder: (context, _) => Icon(
    Icons.star,
    color: Colors.amber,
    ),
    ))
*/
              ],
            ),
          ),
        ),
      ]),
    );
  }

/*
  Widget displayHashtags()
  {
    print('number of hashtags: '+this.hashtags.length.toString());
    if(this.hashtags.isEmpty) return Container();
    else{
      print('showing container with '+this.hashtags.length.toString()+' hashtags!!');
      List<TextSpan> tags = [];
      for(Keyword hashtag in this.hashtags) tags.add(TextSpan(
          text:'#'+(hashtag.keyword ?? '')+ ' ',
              style:new TextStyle(
              color:hashtag.colour!=null && hashtag.colour!.isNotEmpty ? HexColor.fromHex(hashtag.colour ??'#ffffff') : Theme.of(context).colorScheme.primary,
              ),
        ),
      );
      return Container(
          child:RichText(
          text: new TextSpan(text:'Tagit'+"\n",
          children: tags)
        ),
    );
    }
  }
  Widget displayThemes()
  {
    print('number of themes: '+this.themes.length.toString());
    if(this.themes.isEmpty) return Container();
    else{

      List<Widget> tags = [];
      for(Keyword hashtag in this.themes) {
        if (hashtag.unicodeicon != null)
          tags.add(Padding(
            padding:EdgeInsets.only(top:5,bottom:5),
            child:Row(children:[
            Container(
              width:30,
              child:FaIcon(
              IconData(hashtag.unicodeicon!,
                  fontFamily: 'FontAwesomeSolid',
                  fontPackage: 'font_awesome_flutter'),
              size: 20.0),
            ),
                SizedBox(width:5),
                RichText(
                  text:TextSpan(
                      text: (hashtag.keyword ?? '') + ' ',
                      style: new TextStyle(
                        color: hashtag.colour != null && hashtag.colour!.isNotEmpty
                            ? HexColor.fromHex(hashtag.colour ?? '#ffffff')
                            : Theme
                            .of(context)
                            .colorScheme
                            .primary,
                      ),
                    ),
                )
              ]
                ),
          ),
                );
      }
      return Container(
        child:Column(
            children: tags)
      );
    }
  }

*/

/*
  Widget _buildMetaSection(WebPage webPage) {
    print('hello this is Metasection');
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
                  webPage.title.toString(),
                  backgroundColor: Color(0xffF47663),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(webPage.title!,
                  style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 20.0)),
            ),
          ],
        ),
      ),
    );
  }
*/
}

class DetailScreen extends StatelessWidget {
  final String? url;
  DetailScreen(String this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              url!,
              fit: BoxFit.contain,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
