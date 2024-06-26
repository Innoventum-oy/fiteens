
import 'package:flutter/material.dart';
import 'package:fiteens/src/views/webpage/webpageview.dart';
import '../views/activity/activity.dart';
import 'package:core/core.dart' as core;

goToActivity(BuildContext context, core.Activity item,{core.ActivityVisit? visit}) {

  _pushWidgetWithFade(context, ActivityScreen(item,visit:visit));
}
goToWebPage(BuildContext context, core.WebPage item, {replace = false}) {

  core.WebPageProvider provider = core.WebPageProvider();
  core.ImageProvider imageprovider = core.ImageProvider();
  _pushWidgetWithFade(context, WebPageView(item, provider, imageprovider),
      replace: replace);
}
goToWidget(BuildContext context, Widget widget,{replace = false}){
  _pushWidgetWithFade(context, widget,replace: replace);
}
_pushWidgetWithFade(BuildContext context, Widget widget, {replace = false}) {
  PageRouteBuilder route = PageRouteBuilder(
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return widget;
      });
  if (replace) {
    Navigator.of(context).pushReplacement(route);
  } else {
    Navigator.of(context).push(route);
  }
}
