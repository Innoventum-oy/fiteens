import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fiteens/src/util/utils.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:fiteens/src/views/user/deleteaccountform.dart';
import 'package:fiteens/src/views/user/validatecontact.dart';
import 'package:fiteens/src/views/webpage/webpagetextcontent.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:core/core.dart' as core;

import 'joingroupform.dart';

/*
* User card
*/

class MyCard extends StatefulWidget {
  final core.User? user;

  MyCard({this.user});

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  List<Widget> contactItems = [];
  Map<core.Keyword,int> themes = {};
  @override
  void initState(){
    Provider.of<core.UserProvider>(context, listen: false).getContactMethods();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     // loadThemes();
    });
  }
/*
  Future<void> loadThemes() async{
    print('calling loadThemes');
    User user = Provider.of<UserProvider>(context, listen: false).user;
    if(user.themesofbooksread==null){
      print('no themes of read books found for user');
      return;
    }
    if(user.themesofbooksread!.isNotEmpty && user.themesofbooksread!=null) {
      List<dynamic> themes = user.themesofbooksread ?? [];
     // print(user.themesofbooksread.toString());
      final objectmodel.KeywordProvider keywordProvider =
      objectmodel.KeywordProvider();

        for (var theme in themes) {
          try {
            print('loading details for theme ' + theme['id'].toString());
            dynamic details = await keywordProvider.getDetails(
                int.parse(theme['id']), user);
            setState(() {
              print('THEME details: '+details.toString());
              Keyword themedata = Keyword.fromJson(details);
              print('adding theme ' + themedata.keyword! +
                  ' to the themes collection!');
              this.themes[themedata]=int.parse(theme['count']);
            });
          } catch (e) {
            print(   e.toString());
          }
        }
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    core.User user = Provider.of<core.UserProvider>(context).user;
    /*if (user.token == null) {
      Navigator.pushNamed(context, '/login');
      return Container();
    }*/
//print('user themes in build: '+user.themesofbooksread.toString());
//print('user data in build: '+user.data.toString());
    List<core.ContactMethod> myContacts = Provider.of<core.UserProvider>(context).contacts;

    if(myContacts.isNotEmpty)
      {
        contactItems.clear();
        for(var i in myContacts)
          {
            print(i.toString());
            contactItems.add(
                Row(

                    children:[Expanded(
                        flex:1,
                        child: Icon(i.type=='phone' ? Icons.phone_android :Icons.email)),
                      Expanded(
                          flex:4,
                          child: Text(i.address.toString())),
                      Expanded(
                        flex:2,
                          child:(i.verified! ? Icon(Icons.check_circle_outlined,semanticLabel:AppLocalizations.of(context)!.verified) : TextButton(
                        onPressed: () {
                          Provider.of<core.AuthProvider>(context,listen:false).setVerificationStatus(core.VerificationStatus.codeNotRequested);
                          Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ValidateContact(contactMethod:i)),
                              );
                        },
                        child:Text(
                          AppLocalizations.of(context)!.verify ,
                          style: TextStyle(
                           // fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                      )
                    ]
                )
            );

          }
      }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.userInformation),
        elevation: 0.1,
      ),
      body: ListView(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Center(child: _loggedInView(context, user)),
          /*SizedBox(height: 50),
          Center(
              child: user.qrcode != null && user.qrcode!.isNotEmpty
                  ? Image.network(user.qrcode!, height: 200)
                  : Container()),*/

          showThemes(user),
          SizedBox(height: 15),
          DeleteAccountAction(),
          SizedBox(height: 15),
        Container(

            padding: EdgeInsets.symmetric(vertical:10,horizontal: 30),
            child: Column(

                //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(
                      AppLocalizations.of(context)!.otherItems,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    TextButton(

                        onPressed: () {
                          setState((){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ContentPageView('login-info'))
                            );
                          });},
                        child: Text(AppLocalizations.of(context)!.welcomeInfo,
                        textAlign: TextAlign.left,)
                    ),
                  ]
              ),

            ),
          SizedBox(height: 15),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                Expanded(
                  child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.btnReturn)
                    ),
                  ),
                ),

                Expanded(
                  child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // auth.logout(user);
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);

                        Provider.of<core.UserProvider>(context, listen: false).clearCurrentUser();


                      },
                      child: Text(AppLocalizations.of(context)!.logout),
                    ),
                  ),

                ),
              ]
          ),
        ]),
            ]),
        bottomNavigationBar: bottomNavigation(context)
    );
  } //widget

  Widget _loggedInView(BuildContext context, user) {
    List<String> nameparts = [];
    nameparts.add(user.firstname ?? 'John');
    nameparts.add(user.lastname ?? 'Doe');

    String username = nameparts.join(' ');
    print(this.contactItems.length.toString()+' contacts for user');
    return Column(
      children: <Widget>[
        /*_drawAvatar(user.image != null && user.image!.isNotEmpty
            ? NetworkImage(user.image)
            : Image.asset('images/profile.png').image),*/
        _drawLabel(context, username),
        ...this.contactItems,

        JoinGroupForm()
      ],
    );
  }
  Widget showThemes(user)
  {
    print('number of themes: '+this.themes.length.toString());
    if(this.themes.isEmpty) return Container();
    else{

      List<Widget> tags = [];
      this.themes.forEach((hashtag, count) {
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
              Text(' x '+count.toString()),
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
      });
      return Container(
          child:Column(
              children: tags)
      );
    }
  }
  Padding _drawLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        label,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
/*
  Padding _drawAvatar(ImageProvider imageProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CircleAvatar(
        backgroundImage: imageProvider,
        backgroundColor: Colors.white10,
        radius: 48.0,
      ),
    );
  }

 */
}
