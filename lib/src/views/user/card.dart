import 'package:flutter/material.dart';

import 'package:fiteens/src/widgets/widgets.dart';
import 'package:fiteens/src/views/user/deleteaccountform.dart';
import 'package:fiteens/src/views/user/validatecontact.dart';

import 'package:provider/provider.dart';
import 'package:fiteens/l10n/app_localizations.dart';

import 'package:core/core.dart' as core;

import 'joingroupform.dart';

/*
* User card
*/

class MyCard extends StatefulWidget {
  final core.User? user;

  const MyCard({super.key, this.user});

  @override
  MyCardState createState() => MyCardState();
}

class MyCardState extends State<MyCard> {
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

  @override
  Widget build(BuildContext context) {
    core.User user = Provider.of<core.UserProvider>(context).user;

    List<core.ContactMethod> myContacts = Provider.of<core.UserProvider>(context).contacts;

    if(myContacts.isNotEmpty)
      {
        contactItems.clear();
        for(var i in myContacts)
          {

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
                          style: const TextStyle(
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
          const SizedBox(height: 50),
          Center(child: _loggedInView(context, user)),
          /*SizedBox(height: 50),
          Center(
              child: user.qrcode != null && user.qrcode!.isNotEmpty
                  ? Image.network(user.qrcode!, height: 200)
                  : Container()),*/

          const SizedBox(height: 15),
          const DeleteAccountAction(),
          /*
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
             */
           
          const SizedBox(height: 15),


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

    return Column(
      children: <Widget>[
        /*_drawAvatar(user.image != null && user.image!.isNotEmpty
            ? NetworkImage(user.image)
            : Image.asset('images/profile.png').image),*/
        _drawLabel(context, username),
        ...contactItems,

        const JoinGroupForm()
      ],
    );
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
