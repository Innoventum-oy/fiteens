import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventLogView extends StatefulWidget {
  const EventLogView({super.key});


  @override
  EventLogViewState createState() => EventLogViewState();
}

class EventLogViewState extends State<EventLogView> {
  @override
  Widget build(BuildContext context) {
    Future<List<String>?> getEventLog() => EventLog().getMessages();
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.eventLog)),
      body: FutureBuilder(
        initialData: const [],
          future: getEventLog(),
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.data.length>0){
              List<String> messages = snapshot.data ?? [];
              return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {

                return ListTile(
                    title: Text(messages[index].toString()),
                );
              });
            }
            else {
              return Container();
            }
          }
      ),
    );
  }
}