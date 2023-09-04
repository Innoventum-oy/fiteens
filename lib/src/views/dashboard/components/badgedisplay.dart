
/* Single badge progress indicator */
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../util/utils.dart';
import '../../badge.dart';

Widget badgeDisplay(badge, activityCount, key,context) {
  double percentage = badge.getValue('requiredActivityCount') != null
      ? activityCount / badge.getValue('requiredActivityCount')
      : 1;
  if (percentage > 1) percentage = 1;
  //print('badge color: '+badge.color);
  return Padding(
    //Indicator 1/X
    padding: EdgeInsets.only(left: 5),
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
              Text((percentage * 100).round().toString() + '%',
                  style: TextStyle(fontSize: 9, color: Colors.black)),
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