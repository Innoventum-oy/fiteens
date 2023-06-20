import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/src/util/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:core/core.dart' as core;

enum ActionStatus {
  Idle,
  Loading,
  Success,
  Fail

}
class DeleteAccountAction extends StatefulWidget {
  @override
  _DeleteAccountActionState createState() => _DeleteAccountActionState();
}

class _DeleteAccountActionState extends State<DeleteAccountAction> {
  final formKey = new GlobalKey<FormState>();

  ActionStatus formStatus = ActionStatus.Idle;
  core.User? user;

  void deleteAccount() {
    //final form = this.formKey.currentState;

    Provider.of<core.UserProvider>(context, listen: false).deleteUserAccount(
        this.user ?? new core.User()
    ).then((responsedata) async {
      var response = responsedata['data'] ?? responsedata;
      if(response!=null) if( response['status']!=null) {

        switch(response['status']) {
          case 'error':
            Flushbar(
              title: AppLocalizations.of(context)!.deletingAccountFailed,
              message: response['message'] !=null ? response['message'].toString() : response['error'].toString(),
              duration: Duration(seconds: 10),
            ).show(context);

            break;

          case 'success':
          // spell out something
           await Flushbar(
              title: AppLocalizations.of(context)!.accountDeleted,
              message: response['message'] !=null ? response['message'].toString() : response.toString(),
              duration: Duration(seconds: 10),
            ).show(context);
            Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);

            Provider.of<core.UserProvider>(context, listen: false).clearUser();
            core.UserPreferences().removeUser();
        }
      } else {
        Flushbar(
          title: AppLocalizations.of(context)!.deletingAccountFailed,
          message: response['error'] !=null ? response['error'].toString() : response.toString(),
          duration: Duration(seconds: 10),
        ).show(context);
      }
    });


  }

  List<Widget> formButtons()
  {
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.pleaseWaitSendingCode)
      ],
    );

    List <Widget> formfields = [];

    formfields.add(SizedBox(height: 10.0));
    formfields.add(label(AppLocalizations.of(context)!.deleteYourAccount));
    formfields.add(SizedBox(height: 5.0));

    formfields.add( this.formStatus == ActionStatus.Loading
        ? loading
        : longButtons(AppLocalizations.of(context)!.deleteAccount, confirmDeleteAccount));


    return formfields;
  }

  Widget deleteAccountBody(status)
  {
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.loading)
      ],
    );

    switch(status){

      case ActionStatus.Idle:
        return Container(
          padding: EdgeInsets.symmetric(vertical:10,horizontal: 30),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
              Text(
                AppLocalizations.of(context)!.accountDeletion,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              ...formButtons(),
]
            ),
          ),
        );


      case ActionStatus.Loading:
      // display spinner
        return loading;

      case ActionStatus.Success:

        return  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding:EdgeInsets.all(10),
              child:Row(
                  children:[

                    Icon(Icons.check),
                    Text(AppLocalizations.of(context)!.accountDeleted,
                        style:TextStyle(fontSize:20)),
                  ]),),
            SizedBox(height: 15.0),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    this.formStatus = ActionStatus.Idle;
                  });
                },
                child: Text(AppLocalizations.of(context)!.enterNewCode,style: TextStyle(fontWeight: FontWeight.w300))),


          ],
        );

      default:
        return Container();
    }
  }
  void confirmDeleteAccount()
  {
    String title = AppLocalizations.of(context)!.confirmDeletingAccount;
    String content = AppLocalizations.of(context)!.deletingAccountCannotUndone;
    List<Widget> dialogActions = [
      ElevatedButton(
        child: Text(AppLocalizations.of(context)!.cancel),
        onPressed:() => Navigator.of(context, rootNavigator: true).pop('dialog')
      ),
      ElevatedButton(
          child: Text(AppLocalizations.of(context)!.deleteAccount),
          onPressed:() {
            deleteAccount();
            Navigator.of(context, rootNavigator: true).pop('dialog');
          }

      ),
    ];
    showDialog<String>(
        context: context,
        builder:(BuildContext context) =>AlertDialog(
          title: Text(title),
          content: Text(content),

          actions:dialogActions,
        )
    );
  }
  @override
  Widget build(BuildContext context) {

    this.user = Provider.of<core.UserProvider>(context).user;
    return deleteAccountBody(this.formStatus);


  }
}