import 'package:feedback/feedback.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // important

import 'package:core/core.dart';

import '../widgets/handlenotifications.dart';
enum LoadingState { idle, done, loading, waiting, error }

final dollarFormat = NumberFormat("#,##0.00", "en_US");
final sourceFormat = DateFormat('yyyy-MM-dd');
final dateFormat = DateFormat.yMMMMd("en_US");

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
}
/// Return initials for user object
Widget getInitials(user) {
  String initials = '';
  if (user.firstname!= null && user.firstname.isNotEmpty) initials += user.firstname[0];
  if (user.lastname != null && user.lastname!.isNotEmpty) initials += user.lastname[0];
  return Text(initials);
}

/// enable querying color from hex values
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

/// Convert List (array) to (comma) - separated string
String concatListToString(List<dynamic> data, String mapKey,{String separator= ", "}) {
  StringBuffer buffer = StringBuffer();
  buffer.writeAll(data.map<String>((map) => map[mapKey]).toList(), separator);
  return buffer.toString();
}

String formatNumberToDollars(int amount) => '\$${dollarFormat.format(amount)}';

String formatDate(String date) {
  try {
    return dateFormat.format(sourceFormat.parse(date));
  } catch (exception) {
    return "";
  }
}

String formatReadtime(int runtime) {
  int hours = runtime ~/ 60;
  int minutes = runtime % 60;

  return '${hours}h ${minutes}m';
}

MaterialColor createMaterialColor(hexcode) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  Color sourceColor = HexColor.fromHex(hexcode);
  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    swatch[(strength * 1000).round()] = sourceColor;
  }
  return MaterialColor(sourceColor.value, swatch);
}

Future<File> writeImageToStorage(Uint8List feedbackScreenshot) async {
  final Directory output = await getTemporaryDirectory();
  final String screenshotFilePath = '${output.path}/feedback.png';
  final File screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  //return screenshotFilePath;
  return screenshotFile;
}

Future<void> feedbackAction(BuildContext context, User user) async {
  String appName = '';

  String version = '';
  String feedbackText = AppLocalizations.of(context)!.feedback;
  await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    appName = packageInfo.appName;
    version = packageInfo.version;
  });

  final ApiClient apiClient = ApiClient();
  apiClient.buildContext = context;
  if(context.mounted) {
    BetterFeedback.of(context).show((UserFeedback feedback) async {
      Map<String, dynamic> params = {
        'method': 'json',
        'modulename': 'feedback',
        'moduletype': 'pages',
        'action': 'saveobject',
        'api_key': user.token
      };

      final screenshotFile = await writeImageToStorage(feedback.screenshot);
      Map<String, dynamic> data = {
        'objecttype': 'feedback',
        'objectid': 'create',
        'data_email': user.email,
        'data_phone': user.phone,
        'data_sender': '${user.lastname!} ${user.firstname!}',
        'data_subject': '$appName $version $feedbackText',
        'data_content': feedback.text,
        'file_file': screenshotFile
      };
      apiClient.sendFeedback(params, data)!.then((var response) async {
        switch (response['status']) {
          case 'success':
            String title = AppLocalizations.of(context)!.feedbackSent;
            String content = AppLocalizations.of(context)!.thankyouForFeedback;
            showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: Text(title),
                      content: Text(content),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Ok'),
                          onPressed: () => Navigator.pop(context, 'Ok'),
                        )
                      ],
                    ));
        }
        if (response['error'] != null) {
          handleNotifications([response['error']], context);
        }
      });
    });
  }
}
String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
