import 'package:core/core.dart' as core;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/bottomnavigation.dart';


class ScreenScaffold extends StatefulWidget{
  final String title; // Page title
  final Widget child; // Page contents
  final List<Widget>? appBarButtons;  // Buttons to show on top appBar
  final int? navigationIndex;  // index for bottomNavigation
  final bool refresh; // refresh view indicator
  final Function? onRefresh;// refresh functionality, causes refresh button to appear
  const ScreenScaffold({super.key, required this.title, required this.child, this.appBarButtons,this.navigationIndex=1,this.refresh=false,this.onRefresh});

  @override
  State<ScreenScaffold> createState() => _ScreenScaffoldState();
}

class _ScreenScaffoldState extends State<ScreenScaffold>{

  core.User? user;

  @override
  Widget build(BuildContext context) {

    core.User user = Provider.of<core.UserProvider>(context).user;
    core.UserProvider userProvider = Provider.of<core.UserProvider>(context,listen:false);
    if(kDebugMode)
    {
      print('building screen scaffold ${widget.title}');
    }
    ImageProvider image;
    String? avatar = user.data?['avatar'];
    if(avatar!=null) {
      image = Image.asset(avatar.replaceAll('"', ''),
          width:20,
          height:20,
          fit:BoxFit.cover
      ).image;
    } else if (user.image != null && user.image!.isNotEmpty) {
      image = Image
          .network(
          width: 30,
          user.image!.replaceAll('"', ''),
          fit: BoxFit.cover
      )
          .image;
    }
    else {
      image = Image
          .asset('images/profile.png',
          width: 30,
          fit: BoxFit.cover
      )
          .image;
    }
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
        elevation: 0.1,
        leading: (Navigator.canPop(context) && ModalRoute.of(context)!.canPop) ? const BackButton() : ClipOval(child:Image.asset('images/logo.png',
          fit: BoxFit.scaleDown,
        )
        ),
        actions: [
          if(user.id!=null)CircleAvatar(
            radius:20,
              backgroundImage: image,
          ),
          if(widget.onRefresh!=null) IconButton(onPressed: ()=> widget.onRefresh!(), icon: const Icon(Icons.refresh)),
          ...?widget.appBarButtons,
          if(user.id!=null) IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                core.User loggedInUser =
                    userProvider.user;
                await Provider.of<core.AuthProvider>(context, listen: false)
                    .logout(loggedInUser);
                userProvider.clearCurrentUser();

                setState(() {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                });
              }),
        ],
      ),
      body: widget.child,
      bottomNavigationBar: (user.id!=null) ? bottomNavigation(context,currentIndex: widget.navigationIndex??1):null,
    );
  }
}