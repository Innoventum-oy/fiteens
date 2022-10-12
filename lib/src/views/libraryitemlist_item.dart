import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:luen/src/objects/libraryitem.dart';
import 'package:luen/src/util/navigator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LibraryItemListItem extends StatelessWidget{
  LibraryItemListItem(this.libraryItem);
  //ApiClient _apiClient = ApiClient();
  final LibraryItem libraryItem;

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }
  @override
  Widget build(BuildContext context){
   // User user = Provider.of<UserProvider>(context).user;
   List<Widget> buttons=[];

   if(libraryItem.readstatus=='accepted') {
     buttons.add(Icon(Icons.check));
     buttons.add(Text(AppLocalizations.of(context)!.bookIsRead));
     buttons.add(const SizedBox(width: 20));
   }
    buttons.add(ElevatedButton(
      child: Text(AppLocalizations.of(context)!.readMore),
      onPressed: () {
        /* open library view */
        goToLibraryItem(context, libraryItem);
      },
    ));
    buttons.add(const SizedBox(width: 8));
    if(libraryItem.readstatus=='rejected')
      buttons.insert(0,
          Text(AppLocalizations.of(context)!.submissionRejected,
              style:TextStyle(color:Colors.red)
          )
      );
    if(libraryItem.accesslevel >= 20) {
      //user has modify access
      }
    return Center(
      child:
      Card(
        child: InkWell(
          onTap: () => goToLibraryItem(context, libraryItem),
         child:Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              //minLeadingWidth: 80,
              leading: libraryItem.coverpictureurl!=null ? Image.network(
                  libraryItem.coverpictureurl!,
                  fit:BoxFit.fitWidth

): Icon(Icons.book),
              title: Text((libraryItem.title != null ? libraryItem.title: AppLocalizations.of(context)!.unnamedLibraryItem)!),
              subtitle: Text((libraryItem.authors??'')+"\n\n"
                  //+(libraryItem.description??'')
                  +AppLocalizations.of(context)!.addedToList+' '+DateFormat('dd.MM.yyyy').format(libraryItem.readlistdate ?? DateTime.now())
                  ,
                  overflow: TextOverflow.ellipsis,
                  maxLines:10),
               isThreeLine: true,
            ),

        if(libraryItem.objectrating!=null)
         RatingBarIndicator(
           rating:libraryItem.objectrating ?? 0 ,
           itemSize: 20,

           direction: Axis.horizontal,

           itemCount: 5,
           // itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
           itemBuilder: (context, _) => Icon(
             Icons.star,
             color: Colors.amber,
           ),
         ),
     /* if(libraryItem.readlistdate !=null)
       Align(
       alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left:20,right:20),
            child:Text(AppLocalizations.of(context)!.addedToList+' '+DateFormat('dd.MM.yyyy').format(libraryItem.readlistdate ?? DateTime.now()),
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