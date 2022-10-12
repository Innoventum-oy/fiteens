import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:luen/src/objects/keyword.dart';
import 'package:luen/src/objects/libraryitem.dart';
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectmodel;
import 'package:luen/src/objects/form.dart' as iCMSForm;
import 'package:luen/src/providers/user_provider.dart';
import 'package:luen/src/util/api_client.dart';
import 'package:luen/src/util/app_url.dart';
import 'package:luen/src/util/utils.dart';
import 'package:luen/src/util/widgets.dart';
import 'package:luen/src/views/tasklist.dart';
import 'package:luen/src/views/viewform.dart';
import 'package:provider/provider.dart';
import 'package:luen/src/util/styles.dart';

import 'package:url_launcher/url_launcher.dart';

class LibraryItemView extends StatefulWidget {
  final LibraryItem _libraryItem;
  final objectmodel.LibraryItemProvider provider;
  final objectmodel.ImageProvider imageprovider;
  final String libraryItemInfoUrl = AppUrl.libraryItemInfoUrl;
  LibraryItemView(this._libraryItem, this.provider, this.imageprovider);

  @override
  _LibraryItemViewState createState() => _LibraryItemViewState();
}

class _LibraryItemViewState extends State<LibraryItemView> {
  //final ApiClient _apiClient = ApiClient();
  Map<String, dynamic>? map;
  List<LibraryItem> myBooks = [];
  List<LibraryItem> myReadBooks = [];
  List<dynamic> answersets = [];
  List<Keyword> hashtags = [];
  List<Keyword> themes = [];
  int iteration = 1;
  int buildtime = 1;
  LibraryItem libraryItem = new LibraryItem();
  LoadingState _loadingState = LoadingState.WAITING;
  //bool _visible = false;
  User? user;

  //dynamic _libraryItemDetails;
  bool answersetsLoaded = false;
  final ApiClient _apiClient = ApiClient();

  notify(String text) {
    print('notifying '+text);
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
    this.libraryItem = widget._libraryItem;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //User user = Provider.of<UserProvider>(context, listen: false).user;

      // _loadDetails(user);
      loadAnswersets(widget._libraryItem);
      _loadBook(this.user);
      loadThemes();
      loadHashtags();
    });

    // Timer(Duration(milliseconds: 100), () => setState(() => _visible = true));
  }

  void _loadBook(user) async {
  //  print('loading book details');
    if( _loadingState == LoadingState.LOADING) return;
    else if( _loadingState == LoadingState.WAITING) _loadingState = LoadingState.LOADING;
    //print('loading libraryitem ' + widget._libraryItem.id.toString()+' for user '+user.firstname+' '+user.lastname);
    try {
      dynamic details = await widget.provider
          .getDetails(widget._libraryItem.id!, user);

      setState(() {
        if(details != null) {

          this.libraryItem = LibraryItem.fromJson(details);
          _loadingState = LoadingState.DONE;
        }
        else {
          _loadingState = LoadingState.ERROR;

        }

      });
    } catch (e, stack) {
    print('loadDetails returned error $e\n Stack trace:\n $stack');
    //Notify(e.toString());
    _loadingState = LoadingState.ERROR;
    e.toString();
    }
  }

  Future<void> loadAnswersets(libraryitem) async {
    //    print('loadAnswers called for form '+form.id.toString()+' '+form.title+', user '+this.user!.id.toString());

    Map<String, dynamic> params = {
      'targetitemtype': 'libraryitem',
      'targetitemid': libraryitem.id.toString(),
      'action': 'loadanswersets',
      'method': 'json',
      'api_key': Provider.of<UserProvider>(context, listen: false).user.token,
    };

    _apiClient.loadFormData(params)!.then((responseData) {
      setState(() {
        answersetsLoaded = true;
        var response = responseData['data'];
        //    print(response.toString());
        if (response != null) {
          answersets = response;
        }
      });
    });
  }
  Future<void> loadHashtags() async{
    if(widget._libraryItem.hashtags==null){
      print('no hashtags found for libraryitem!');
      return;
    }
    if(widget._libraryItem.hashtags!.isNotEmpty && widget._libraryItem.hashtags!=null) {
      List? _hashtags = widget._libraryItem.hashtags;
      final objectmodel.KeywordProvider keywordProvider =
      objectmodel.KeywordProvider();
      if(_hashtags!=null)
        for (var hashtag in _hashtags)
        {
          try {

            print('loading details for hashtag '+hashtag['objectid'].toString());
            dynamic details = await keywordProvider.getDetails(int.parse(hashtag['objectid']), user);
            setState(() {
              print(details.toString());
              Keyword tag = Keyword.fromJson(details);
              print('adding hashtag to the hashtags collection!');
             this.hashtags.add(tag);
         //   print('now the hashtags count is '+this.hashtags.length.toString());
            });
          } catch (e, stack) {

            print('ERROR: '+e.toString()+' $stack');
          }
        }
    }
  }
  Future<void> loadThemes() async{
    if(widget._libraryItem.themes==null){
      print('no themes found for libraryitem!');
      return;
    }
    if(widget._libraryItem.themes!.isNotEmpty && widget._libraryItem.themes!=null) {
      List? _themes = widget._libraryItem.themes;
      final objectmodel.KeywordProvider keywordProvider =
      objectmodel.KeywordProvider();
      if(_themes!=null) {
        print('Will try to load details for '+_themes.length.toString()+' themes');
        for (var theme in _themes) {
          try {
            print('loading details for theme ' + theme['objectid'].toString());
            dynamic details = await keywordProvider.getDetails(
                int.parse(theme['objectid']), user);
            setState(() {
              print('THEME details: '+details.toString());
              Keyword theme = Keyword.fromJson(details);
              print('adding theme ' + theme.keyword! +
                  ' to the themes collection!');
              this.themes.add(theme);
            });
          } catch (e) {
         print(   e.toString());
          }
        }
      }
      else print('LIBRARYITEM has NO themes');
    }
  }

  bool itemInMyBooks(List<LibraryItem> books, int id) {
    final found = books.where((book) => book.id == id);
    if (found.isNotEmpty) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
   // print('rebuilding libraryItem view');
    this.user = Provider.of<UserProvider>(context).user;
    this.myBooks = Provider.of<UserProvider>(context).myBooks;

    return Scaffold(
        backgroundColor: primary,
        body: CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(),
            _buildContentSection(),
          ],
        ),
        bottomNavigationBar: bottomNavigation(context));
  }

  List<Widget> buttons(LibraryItem libraryItem) {
    List<Widget> buttons = [];
    buttons.add(Container());
    if (libraryItem.accesslevel >= 20) {}
    return buttons;
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 240.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GestureDetector(
            onTap: () {
              if(widget._libraryItem.coverpictureurl!=null)
      Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailScreen(widget._libraryItem.coverpictureurl!);
      }));
      },
        child:
            Hero(
              tag: "LibraryItem-Tag-${widget._libraryItem.id}",
              child: widget._libraryItem.coverpictureurl != null
                  ? FadeInImage.assetNetwork(
                      fit: BoxFit.contain,
                      width: double.infinity,
                      placeholder: 'images/libraryItem-placeholder.png',
                      image: widget._libraryItem.coverpictureurl!,
                    )
                  : Image(
                      image: AssetImage('images/libraryItem-placeholder.png')),
            ),
            ),
           // BottomGradient(),
            //_buildMetaSection(libraryItem)
          ],
        ),
      ),
    );
  }

/*
  void _loadDetails(user) async {
    // print('called _loadDetails for libraryItem '+widget._libraryItem.id.toString()+', awaiting provider for details!');
    try {
      dynamic details =
          await widget.provider.getDetails(widget._libraryItem.id!, user);
      //print(details.toString());
      // print(details.runtimeType);
      setState(() => _libraryItemDetails = details.first);
    } catch (e, stack) {
      print('loadDetails returned error $e\n Stack trace:\n $stack');
      //Notify(e.toString());
      e.toString();
    }
  }

 */

  Widget _buildContentSection() {
    //final TextTheme textTheme = Theme.of(context).textTheme;
    LibraryItem libraryItem = this.libraryItem;

    print('building ContentSection for id '+libraryItem.id.toString()+'/'+widget._libraryItem.id.toString());

    List<Widget> buttons = [];


    if(itemInMyBooks(this.myBooks, libraryItem.id ?? 0)){
      //Open tasks list for finishing book
      buttons.add(ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskList(book: libraryItem)),
            );
          },
          child: Text(AppLocalizations.of(context)!.btnTasks)));
    }

    if(libraryItem.readstatus!='accepted') {
      buttons.add(
          ElevatedButton(
              onPressed: () async {
                //remove book from list
                var result = await Provider.of<UserProvider>(
                    context, listen: false).returnBook(libraryItem);
                print('result: ' + result.toString());
               //notify(String text, context)

                notifyDialog('Listan päivitys',Text('Kirjan poistaminen listalta ' +
                    (result['status'] == 'success'
                        ? 'onnistui '
                        : 'epäonnistui')),context);
              },
              child: Text(AppLocalizations.of(context)!.btnReturnBook)
          ));

    }

    if (answersets.length > 0) {
      buttons.insert(
          0,
          ElevatedButton(
            onPressed: () async {
              final objectmodel.FormProvider formProvider =
                  objectmodel.FormProvider();
              print(answersets.first.toString());
              dynamic formData = await formProvider.getDetails(
                  int.parse(answersets.first['formid']), this.user);

              iCMSForm.Form form = iCMSForm.Form.fromJson(formData);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DisplayFormAnswers(libraryItem, form)),
              );
            },
            child: Text('Näytä vastauksesi'),
          ));
    }
    if (libraryItem.videoUrl != null) buttons.insert(0,ElevatedButton.icon(
      icon: Icon(Icons.movie),
      onPressed: ()async{
        if (!await launchUrl(Uri.parse(libraryItem.videoUrl!)))
          Flushbar(
            title: AppLocalizations.of(context)!.error,
            message: AppLocalizations.of(context)!.couldNotOpenLink+' '+(libraryItem.videoUrl??''),
            duration: Duration(seconds: 10),
          ).show(context);
          //throw 'Linkin avaaminen ei onnistunut $libraryItem.videoUrl';
        },
      label: Text('Katso video'),
    ));
    if (libraryItem.readstatus == 'accepted') {
      buttons.add(Padding(
          padding: EdgeInsets.all(20),
          child: Row(children: [
            Icon(Icons.check),
            Text(AppLocalizations.of(context)!.youHaveReadThisBook)
          ])));
      buttons.add(
          Column(
              children:[
                Text(AppLocalizations.of(context)!.rateBook),
                RatingBar.builder(
                  initialRating: libraryItem.userrating ?? 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) async {
                    dynamic response = await widget.provider.addRating(rating,libraryItem,this.user);
                    String title = response['result']=='success' ? AppLocalizations.of(context)!.ratingSaved : AppLocalizations.of(context)!.oops;
                    Flushbar(
                      title: title,
                      message: response['message'].toString(),
                      duration: Duration(seconds: 3),
                    ).show(context);
                    print(rating);
                  },
                )
              ]));
    }
    //handle hashtags and themes


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
                  libraryItem.title != null
                      ? libraryItem.title.toString()
                      : AppLocalizations.of(context)!.unnamedLibraryItem,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                if (libraryItem.authors != null)
                  Container(
                    height: 8.0,
                  ),
                if (libraryItem.authors != null)
                  Text(
                    libraryItem.authors ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                Container(
                  height: 8.0,
                ),
                if (libraryItem.introduction != null)
                  Text(
                    (libraryItem.introduction??''),
                    style: const TextStyle(color: Colors.white, fontSize: 13.0),
                  ),
                Text(
                  (libraryItem.description??''),
                  style: const TextStyle(color: Colors.white, fontSize: 13.0),
                ),
                Container(
                  height: 8.0,
                ),
                if(libraryItem.pagecount!=null)
                  Text(AppLocalizations.of(context)!.pageCount+' '+libraryItem.pagecount.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 13.0),
                  ),

                if(libraryItem.pagecount!=null)
                Container(
                  height: 8.0,
                ),
                displayHashtags(),
                displayThemes(),
                //youtubePlayerWidget(libraryItem.videoId),
    if(libraryItem.objectrating!=null)
    Center(child:RatingBarIndicator(
    rating:libraryItem.objectrating ?? 0 ,

    direction: Axis.horizontal,
    itemSize: 20,
    itemCount: 5,
    //itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
    itemBuilder: (context, _) => Icon(
    Icons.star,
    color: Colors.amber,
    ),
    ))


              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: itemInMyBooks(this.myBooks, libraryItem.id ?? 0)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buttons)
              : ElevatedButton(
                  onPressed: () async {
                    //add book to myBooks list
                    var result =
                        await Provider.of<UserProvider>(context, listen: false)
                            .readBook(libraryItem);
                    print('result: ' + result.toString());
                    notify('Kirjan lisääminen listalle ' +
                        (result['status'] == 'success'
                            ? 'onnistui '
                            : 'epäonnistui'));
                  },
                  child: Text(AppLocalizations.of(context)!.btnRead)),
        ),
      ]),
    );
  }


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





/*
  Widget _buildMetaSection(LibraryItem libraryItem) {
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
                  libraryItem.title.toString(),
                  backgroundColor: Color(0xffF47663),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(libraryItem.title!,
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
  DetailScreen(String this.url,{super.key});

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