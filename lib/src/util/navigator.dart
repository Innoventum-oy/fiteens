import 'package:flutter/material.dart';
import 'package:fiteens/src/views/webpageview.dart';
import '../views/activity/activity.dart';
import 'package:core/core.dart' as core;

goToActivity(BuildContext context, core.Activity item) {
  print('goToActivity called for #'+item.id.toString());
  print(item);
  core.ActivityProvider provider = core.ActivityProvider();
  core.ImageProvider imageprovider = core.ImageProvider();
  _pushWidgetWithFade(context, ActivityView(item, provider,imageprovider));
}
goToWebPage(BuildContext context, core.WebPage item, {replace = false}) {
  //print('goToLibraryItem called with item id '+item.id.toString());
  //print(item.toString());
  core.WebPageProvider provider = core.WebPageProvider();
  core.ImageProvider imageprovider = core.ImageProvider();
  _pushWidgetWithFade(context, WebPageView(item, provider, imageprovider),
      replace: replace);
}

_pushWidgetWithFade(BuildContext context, Widget widget, {replace = false}) {
  PageRouteBuilder route = PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return widget;
      });
  if (replace)
    Navigator.of(context).pushReplacement(route);
  else
    Navigator.of(context).push(route);
}
