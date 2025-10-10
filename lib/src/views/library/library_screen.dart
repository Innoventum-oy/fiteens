import 'dart:developer';

import 'package:core/core.dart';
import 'package:fiteens/src/views/library/components/activityclass.dart';
import 'package:fiteens/src/views/webpage/pagelist_item.dart';
import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../util/constants.dart' as constants;

class LibraryScreen extends StatefulWidget {
  final int navIndex;
  final bool refresh;
  const LibraryScreen({this.navIndex=4,this.refresh = false,super.key});

  @override
  State<StatefulWidget> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  bool loaded = false;

  Widget defaultContent = const Center(child:CircularProgressIndicator());
  @override
  void initState(){
    super.initState();
    if(kDebugMode){
      log('challengesTab initState - loading activity classes');
    }
    // Load activity classes from API
    Map<String,dynamic> params = {
      //'activitystatus' : 'active',  // only load active items
    };
    Provider.of<ActivityClassProvider>(context,listen: false).getItems(params,reload: widget.refresh || !loaded ? true : false).then((value) => loaded= true);
  _loadPages();
  }
  _loadPages() async {

    WebPageProvider webPageProvider =  Provider.of<WebPageProvider>(context,listen:false);
    final Map<String, String> params = {
      'fields':
      'id,pagetitle,textcontents,thumbnailurl,accesslevel,commonname,pagecategory,references',
      'sort': 'pagetitle',
      'status': '2',
      'show_in_menu': '1',
      'language' : await Settings().getValue('language'),
      //'pagecategory' : "IS SET"
    };

    webPageProvider .loadItems(params).then((value){
      if(kDebugMode) {
        log('${webPageProvider.list?.length} pages loaded');
      }
      webPageProvider.loadingStatus = DataLoadingStatus.loaded;
    });

  }
  @override
  Widget build(BuildContext context) {

    // Libraryview consists of a tabbar with N tabs: One tab for challenges and one tab for each pagecategory of WebPages
    // Challenges are Activities
    // Provider provides us with the data
   // if(webPageProvider.)
    //Create TabBar
    TabBar tabBar = TabBar(
      tabs: [
        Tab(text: AppLocalizations.of(context)!.challenges),
        Tab(text: AppLocalizations.of(context)!.library),
      ],
    );
    //Create TabBarView
    TabBarView tabBarView = TabBarView(
      children: [
        // Challenges
        Consumer<ActivityClassProvider>(
            builder: (context, activityClassProvider, child) {
              if (activityClassProvider.loadingStatus == DataLoadingStatus.loaded) {
                if (activityClassProvider.list != null) {
                  List<ActivityClass>? items = activityClassProvider.list;
                  return items != null ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        crossAxisCount: 2,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        // Item rendering
                        ActivityClass item = items[index];
                        return Card(child:ActivityClassItem(
                          navIndex: widget.navIndex,
                          activityClass: item,

                        ));
                      }) : Text(AppLocalizations.of(context)!.libraryIsEmpty);
                } else {
                  return Text(AppLocalizations.of(context)!.libraryIsEmpty);
                }
              } else {

                return Padding(padding:const EdgeInsets.all(20),child:Column(children:[defaultContent,Text(AppLocalizations.of(context)!.loading)]));
              }
            }),
        // Library
        Consumer<WebPageProvider>(
            builder: (context, pageProvider, child) {
              if (pageProvider.loadingStatus == DataLoadingStatus.loaded) {
                if (pageProvider.list != null) {
                  List<WebPage>? items = pageProvider.list?.where((element) => element.getValue('pagecategory')!=null).toList();
                  log("Found ${items?.length} pages with pagecategory");
                  // sort items by pagetitle, converting the first 1-3 digits in the beginning of the title to number.
                  // If it starts with digits , use the number , otherwise use 0.
                  // Remember the number can be >10, so we can't just use the first digit.
                  // Parse the first letters as long as they are digits and then parse the result in to number
                  items?.sort((a,b){
                    String aTitle = a.getValue('pagetitle');
                    String bTitle = b.getValue('pagetitle');
                    int aNumber = 0;
                    int bNumber = 0;
                    int i = 0;
                    while(i<aTitle.length && int.tryParse(aTitle[i])!=null){
                      i++;
                    }
                    if(i>0){
                      aNumber = int.parse(aTitle.substring(0,i));
                    }
                    i = 0;
                    while(i<bTitle.length && int.tryParse(bTitle[i])!=null){
                      i++;
                    }
                    if(i>0){
                      bNumber = int.parse(bTitle.substring(0,i));
                    }
                    return aNumber.compareTo(bNumber);
                  });

                  return items != null ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        crossAxisCount: 2,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        // Item rendering
                        WebPage item = items[index];
                        return Card(child:WebPageListItem(
                           item,

                        ));
                      }) : Text(AppLocalizations.of(context)!.libraryIsEmpty);
                } else {
                  return Text(AppLocalizations.of(context)!.libraryIsEmpty);
                }
              } else {
                return defaultContent;
              }
            }),
      ],
    );

    return DefaultTabController(length: 2, child: ScreenScaffold(
        title: AppLocalizations.of(context)!.library,
        navigationIndex: widget.navIndex,
        refresh: widget.refresh,
       child: Column(
          children: [
            tabBar,
            Expanded(child: tabBarView),
          ],
        ),
        onRefresh:(){
          if(kDebugMode) {
            log('reloading page');
          }

          constants.Router.navigate(context,'library',widget.navIndex,refresh: true);
        },

        
    )
    );
  }

}