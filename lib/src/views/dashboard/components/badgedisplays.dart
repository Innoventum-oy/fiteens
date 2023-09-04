/// Widget list creator for available activity badges */
import 'package:flutter/cupertino.dart';
import 'badgedisplay.dart';

List<Widget> badgeDisplays(badges, activityCount,context) {

  List<Widget> data = [];
  bool firstVisibleBadgeSet = false;
  if (badges.isEmpty) return data;
  for (var badge in badges) {
    Key badgeKey = Key('badge-' + badge.id.toString());
    data.add(badgeDisplay(badge, activityCount, badgeKey,context!));
    if (!firstVisibleBadgeSet) {
      double percentage = badge.getValue('requiredactivitycount') != null
          ? activityCount / badge.getValue('requiredactivitycount')
          : 1;
      if (percentage < 1) {
        //ensure this badge is visible
        // print('ensuring badge '+badge.name+' should be visible, percentage is '+percentage.toString());
        firstVisibleBadgeSet = true;
        if (context != null)
          Scrollable.ensureVisible(context!);
      }
    }
  }
  return data;
}