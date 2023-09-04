import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LibraryScreen extends StatefulWidget {

  const LibraryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(title: AppLocalizations.of(context)!.library, child: const LibraryView());
  }
}

class LibraryView extends StatefulWidget {

  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {

  Widget defaultContent = const CircularProgressIndicator();

  @override
  Widget build(BuildContext context) {
    /// Todo: implement screen contents
    return defaultContent;
  }

}