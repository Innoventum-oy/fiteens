
/* Single badge progress indicator */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../util/utils.dart';
import '../../badge.dart';

Widget badgeDisplay(badge, activityCount, key,context) {
  if(kDebugMode){
    // log activity count and required activities
    print('activity count: $activityCount');
    print('required activities: ${badge.getValue('requiredactivities')}');
  }
  double percentage = badge.getValue('requiredactivities') != null
      ? activityCount / int.parse(badge.getValue('requiredactivities'))
      : 1;
  if (percentage > 1) percentage = 1;
  //print('badge color: '+badge.color);
  return Padding(
    //Indicator 1/X
    padding: const EdgeInsets.only(left: 5),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BadgeView(badge)),
        );
      },
      child: CircularPercentIndicator(
          key: key,
          radius: 20.0,
          lineWidth: 4.0,
          percent: percentage,
          center: Center(
            child: Stack(alignment: Alignment.center, children: [
              Icon(Icons.emoji_events, size: 35.0, semanticLabel: badge.name),
              Text('${(percentage * 100).round()}%',
                  style: const TextStyle(fontSize: 9, color: Colors.black)),
            ]),
          ),
          backgroundColor: Colors.yellow,
          progressColor: badge.color != null
              ? HexColor.fromHex(badge.color)
              : Colors.green //Colors.green,
      ),
    ),
  );
}