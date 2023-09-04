import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/bottomnavigation.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScreenScaffold extends StatefulWidget{
  final String title; // Page title
  final Widget child; // Page contents
  final List<Widget>? appBarButtons;  // Buttons to show on top appBar
  final int navigationIndex;  // index for bottomNavigation
  const ScreenScaffold({Key? key, required this.title, required this.child, this.appBarButtons,this.navigationIndex=1}) : super(key:key);

  @override
  State<ScreenScaffold> createState() => _ScreenScaffoldState();
}

class _ScreenScaffoldState extends State<ScreenScaffold>{

  User? user;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<UserProvider>(context).user;

    if(kDebugMode)
    {
      print('building screen scaffold ${widget.title}');
    }
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
        elevation: 0.1,
        leading: const BackButton(),
        actions: [
          CircleAvatar(
            radius:20,
            child: user.image != null ? Image.network(user.image ??'') : const Icon(Icons.account_circle_outlined),
          ),

          ...?widget.appBarButtons,
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                Provider.of<UserProvider>(context, listen: false).clearUser();
                setState(() {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                });
              }),
        ],
      ),
      body: widget.child,
      bottomNavigationBar: bottomNavigation(context,currentIndex: widget.navigationIndex),
    );
  }
}