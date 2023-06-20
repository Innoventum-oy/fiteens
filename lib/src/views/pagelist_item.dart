import 'package:core/core.dart' as core;
import 'package:flutter/material.dart';
import 'package:fiteens/src/util/navigator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class WebPageListItem extends StatelessWidget{
  WebPageListItem(this.webPage);
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
         child:Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              minLeadingWidth: 80,
              leading: webPage.thumbnailUrl!=null ? Image.network(
                 webPage.thumbnailUrl!,
                  fit:BoxFit.fitWidth

): Icon(Icons.book),
              title: Text((webPage.pagetitle != null ? webPage.pagetitle: AppLocalizations.of(context)!.unnamedWebPage)!),
              subtitle: Text((webPage.author??'')+"\n\n"

                  ,
                  overflow: TextOverflow.ellipsis,
                  maxLines:10),
               isThreeLine: true,
            ),
/*
        if(WebPage.objectrating!=null)
         RatingBarIndicator(
           rating:WebPage.objectrating ?? 0 ,
           itemSize: 20,

           direction: Axis.horizontal,

           itemCount: 5,
           // itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
           itemBuilder: (context, _) => Icon(
             Icons.star,
             color: Colors.amber,
           ),
         ),

 */
     /* if(WebPage.readlistdate !=null)
       Align(
       alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left:20,right:20),
            child:Text(AppLocalizations.of(context)!.addedToList+' '+DateFormat('dd.MM.yyyy').format(WebPage.readlistdate ?? DateTime.now()),
            style: TextStyle(fontSize:11))
            ),
        ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: buttons,
            ),
          ]
        )
      )
    )
    );
  }
}