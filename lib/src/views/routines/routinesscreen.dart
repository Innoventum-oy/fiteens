import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoutinesScreen extends StatefulWidget {

  const RoutinesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RoutinesScreenState();
}

class _RoutinesScreenState extends State<RoutinesScreen> {

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(title: AppLocalizations.of(context)!.routines_title, child: const RoutinesView());
  }
}

class RoutinesView extends StatefulWidget {

  const RoutinesView({super.key});

  @override
  State<RoutinesView> createState() => _RoutinesViewState();
}

class _RoutinesViewState extends State<RoutinesView> {

  Widget defaultContent = const CircularProgressIndicator();

  @override
  Widget build(BuildContext context) {
    /// Todo: implement screen contents
    return defaultContent;
  }

}