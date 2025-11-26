import 'package:fiteens/src/widgets/notifydialog.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/generated/l10n.dart';
handleNotifications(dynamic notifications, context) {
  if (notifications != null) {
    List<Widget> inforows = [];
    for (String notification in notifications) {
      inforows.add(Padding(
          padding: const EdgeInsets.all(8.0), child: Text(notification)));
    }
    notifyDialog(AppLocalizations.of(context).notification,
        Column(children: inforows), context);
    //display notifications in alert dialog
  }
}