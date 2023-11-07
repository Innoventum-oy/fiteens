import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../../../util/navigator.dart';
import '../libraryItemsScreen.dart';

class ActivityClassItem extends StatelessWidget {
  final Function? onTap;
  final int navIndex;
  final ActivityClass activityClass;

  ActivityClassItem({this.onTap,required this.activityClass, required this.navIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap!=null ? onTap!() : ()=> {
        goToWidget(context,LibraryItemsScreen(activityClass,navIndex: navIndex,))
      },
      child: Container(
        child:Stack(
          fit: StackFit.expand,
          //  crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [activityClass.coverpictureurl != null ? Image.network(activityClass.coverpictureurl??'', fit: BoxFit.cover,) : Image.asset('images/logo.png', fit: BoxFit.cover,),


              Positioned(
                bottom:0,
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child:
                  Text(activityClass.name?? '??',
                      style: TextStyle(backgroundColor: Colors.blue))
                  )
              )
            ]
        ),
      ),
    );
  }

}