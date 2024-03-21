import 'package:core/core.dart';
import 'package:fiteens/src/util/styles.dart';
import 'package:flutter/material.dart';
import '../../../util/navigator.dart';
import '../library_items_screen.dart';

class ActivityClassItem extends StatelessWidget {
  final Function? onTap;
  final int navIndex;
  final ActivityClass activityClass;

  const ActivityClassItem({super.key, this.onTap,required this.activityClass, required this.navIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap!=null ? onTap!() : ()=> {
        goToWidget(context,LibraryItemsScreen(activityClass,navIndex: navIndex,))
      },
      child: Stack(
        fit: StackFit.expand,
        //  crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [activityClass.coverpictureurl != null ? Image.network(activityClass.coverpictureurl??'', fit: BoxFit.cover,) : Image.asset('images/logo.png', fit: BoxFit.cover,),


            Positioned(
              bottom:0,
                left:0,
                right: 0,
                child:Container(
                  decoration: const BoxDecoration(
                    color: secondaryThemeColor,
                  ),
                child: Padding(

                    padding: const EdgeInsets.all(5),
                    child:
                Text(activityClass.name?? '??',
                    style: const TextStyle(fontSize: 18))
                )
            ),
            )
          ]
      ),
    );
  }

}