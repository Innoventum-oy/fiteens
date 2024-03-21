import 'package:core/core.dart' as core;
import 'package:flutter/material.dart';
import 'package:fiteens/src/util/navigator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../util/styles.dart';


class WebPageListItem extends StatelessWidget{
  const WebPageListItem(this.webPage, {super.key});
  //ApiClient _apiClient = ApiClient();
  final core.WebPage webPage;

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }
  @override
  Widget build(BuildContext context){

   List<Widget> buttons=[];

    buttons.add(ElevatedButton(
      child: Text(AppLocalizations.of(context)!.readMore),
      onPressed: () {
        /* open library view */
        goToWebPage(context, webPage);
      },
    ));
    buttons.add(const SizedBox(width: 8));

    if(webPage.accesslevel >= 20) {
      //user has modify access
      }
    return Center(
      child:
      Card(
        child: InkWell(
          onTap: () => goToWebPage(context, webPage),
         child:
         Stack(
             fit: StackFit.expand,
             //  crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [webPage.thumbnailUrl!=null ? Image.network(
               webPage.thumbnailUrl!, fit: BoxFit.cover,) : Image.asset('images/logo.png', fit: BoxFit.cover,),


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
                         Text( webPage.pagetitle ?? AppLocalizations.of(context)!.unnamedWebPage,
                             style: const TextStyle(fontSize: 18))
                     )
                 ),
               )
             ]
         ),
        ),
    )
    );
  }
}