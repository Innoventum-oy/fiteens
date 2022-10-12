import 'package:flutter/material.dart';
import 'package:luen/src/objects/libraryitem.dart';
import 'package:luen/src/objects/elearningcourse.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectmodel;
import 'package:luen/src/views/libraryitem.dart';
import 'package:luen/src/views/elearningcourse.dart';
goToStation(BuildContext context, ElearningCourse item) {
 // objectmodel.LibraryCollectionProvider collectionProvider = objectmodel.LibraryCollectionProvider();
  objectmodel.ElearningCourseProvider elearningCourseProvider = objectmodel.ElearningCourseProvider();
  objectmodel.ImageProvider imageprovider = objectmodel.ImageProvider();
  _pushWidgetWithFade(context, ElearningCourseView(item.id, elearningCourseProvider,imageprovider));
}
goToLibraryItem(BuildContext context, LibraryItem item,{replace:false}) {
  //print('goToLibraryItem called with item id '+item.id.toString());
  //print(item.toString());
  objectmodel.LibraryItemProvider provider = objectmodel.LibraryItemProvider();
  objectmodel.ImageProvider imageprovider = objectmodel.ImageProvider();
  _pushWidgetWithFade(context, LibraryItemView(item, provider,imageprovider),replace:replace);
}
_pushWidgetWithFade(BuildContext context, Widget widget,{replace:false}) {
  PageRouteBuilder route = PageRouteBuilder(
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return widget;
      });
  if(replace)
    Navigator.of(context).pushReplacement(route);
  else Navigator.of(context).push(route);

}