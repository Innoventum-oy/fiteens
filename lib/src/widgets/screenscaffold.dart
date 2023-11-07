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
  const ScreenScaffold({Key? key, required this.title, required this.child, this.appBarButtons,this.navigationIndex=1,this.refresh=false,this.onRefresh}) : super(key:key);

  @override
  State<ScreenScaffold> createState() => _ScreenScaffoldState();
}

class _ScreenScaffoldState extends State<ScreenScaffold>{

  core.User? user;

  @override
  Widget build(BuildContext context) {

    core.User user = Provider.of<core.UserProvider>(context).user;

    if(kDebugMode)
    {
      print('building screen scaffold ${widget.title}');
    }
    ImageProvider image;
    String? avatar = user.data?['avatar'];
    if(avatar!=null)
      image = Image.asset(avatar,
          width:20,
          height:20,
          fit:BoxFit.cover
      ).image;
    else if (user.image != null && user.image!.isNotEmpty)
      image = Image.network(
          width:30,
          user.image!,
          fit: BoxFit.cover
      ).image;
    else image = Image.asset('images/profile.png',
          width:30,
          fit:BoxFit.cover
      ).image;
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
        elevation: 0.1,
        leading: (Navigator.canPop(context) && ModalRoute.of(context)!.canPop) ? const BackButton() : ClipOval(child:Image.asset('images/logo.png',
          fit: BoxFit.scaleDown,
        )
        ),
        actions: [
          CircleAvatar(
            radius:20,
              backgroundImage: image,
          ),
          if(widget.onRefresh!=null) IconButton(onPressed: ()=> widget.onRefresh!(), icon: Icon(Icons.refresh)),
          ...?widget.appBarButtons,
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                Provider.of<core.UserProvider>(context, listen: false).clearCurrentUser();

                setState(() {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                });
              }),
        ],
      ),
      body: widget.child,
      bottomNavigationBar: bottomNavigation(context,currentIndex: widget.navigationIndex??1),
    );
  }
}