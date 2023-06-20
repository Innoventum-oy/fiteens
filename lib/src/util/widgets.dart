import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

handleNotifications(dynamic notifications, context) {
  if (notifications != null) {
    List<Widget> inforows = [];
    for (String notification in notifications) {
      inforows.add(Padding(
          padding: const EdgeInsets.all(8.0), child: Text(notification)));
    }
    notifyDialog(AppLocalizations.of(context)!.notification,
        Column(children: inforows), context);
    //display notifications in alert dialog
  }
}

popupDialog(String? titleText, Widget dialogContent, BuildContext context,
    {List<Widget>? actions}) {
  print(context.toString());
  showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(titleText != null
                ? titleText
                : 'Huomio'), //Text(AppLocalizations?.of(context)!=null ? AppLocalizations.of(context)!.notification),
            content: dialogContent,
            actions: actions ??
                <Widget>[
                  ElevatedButton(
                      child:
                          Text('Ok'), //Text(AppLocalizations.of(context)!.ok),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      })
                ],
          ));
}

notifyDialog(String? titleText, Widget text, BuildContext context) {
  print(context.toString());
  showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(titleText != null
                ? titleText
                : 'Huomio'), //Text(AppLocalizations?.of(context)!=null ? AppLocalizations.of(context)!.notification),
            content: SingleChildScrollView(child: text),
            actions: <Widget>[
              ElevatedButton(
                  child: Text('Ok'), //Text(AppLocalizations.of(context)!.ok),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  })
            ],
          ));
}

Widget bottomNavigation(context, {int currentIndex = 0}) {
  /*
  final objectmodel.ElearningCourseProvider courseProvider =
      objectmodel.ElearningCourseProvider();
  objectmodel.ImageProvider imageprovider = objectmodel.ImageProvider();

   */
  return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_gymnastics),
          label: 'Routines',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          label: 'Resources',
        ),
      ],
      selectedItemColor: Colors.white,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamedAndRemoveUntil(
                context, '/dashboard', (Route<dynamic> route) => false);
            break;
          case 1:
            /*  Navigator.of(context)
                .pushAndRemoveUntil(MaterialPageRoute(
                builder: (context) =>
                    StationsView(courseProvider, imageprovider)), (Route<dynamic> route) => false);
            */

            break;

          case 2:
            Navigator.pushNamedAndRemoveUntil(
                context, '/resources', (Route<dynamic> route) => false);

            break;
        }
      });
}

MaterialButton longButtons(String title, Function()? fun,
    {Color color = const Color(0xFF299fe0), Color textColor = Colors.white}) {
  return MaterialButton(
    onPressed: fun,
    textColor: textColor,
    color: color,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
    height: 45,
    minWidth: 600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}

label(String title) => Text(title);

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon),
    hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}
