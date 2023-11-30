import 'package:core/core.dart';
import 'package:fiteens/src/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
                  left:0,
                  right: 0,
                  child:Container(
                    decoration: BoxDecoration(
                      color: secondaryThemeColor,
                    ),
                  child: Padding(

                      padding: EdgeInsets.all(5),
                      child:
                  Text(activityClass.name?? '??',
                      style: TextStyle(fontSize: 18))
                  )
              ),
              )
            ]
        ),
      ),
    );
  }

}