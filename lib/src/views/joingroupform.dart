import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/src/util/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:core/core.dart' as core;

enum CodeStatus {
  Idle,
  Authenticating,
  Accepted

}
class JoinGroupForm extends StatefulWidget {
  @override
  _JoinGroupFormState createState() => _JoinGroupFormState();
}

class _JoinGroupFormState extends State<JoinGroupForm> {
  final formKey = new GlobalKey<FormState>();
  //final core.ApiClient _apiClient = core.ApiClient();
  String?  _registrationCode;
  CodeStatus formStatus = CodeStatus.Idle;
  core.User? user;

  Map<String,TextEditingController> controllers = {

    'code' : new TextEditingController()
  };

  List<Widget> formButtons()
  {
    var joinGroup = () {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        Provider.of<core.UserProvider>(context).joinGroup(
             _registrationCode.toString(),
            this.user ?? new core.User()
        ).then((responsedata) {
          var response = responsedata['data'] ?? responsedata;
          if(response!=null) if( response['status']!=null) {

            switch(response['status']) {
              case 'error':
                Flushbar(
                  title: AppLocalizations.of(context)!.joiningGroupFailed,
                  message: response['message'] !=null ? response['message'].toString() : response['error'].toString(),
                  duration: Duration(seconds: 10),
                ).show(context);

                break;

              case 'success':
             // spell out something
              setState(() {
                formStatus = CodeStatus.Accepted;
              });
                Flushbar(
                  title: AppLocalizations.of(context)!.joinedToGroup,
                  message: response['message'] !=null ? response['message'].toString() : response.toString(),
                  duration: Duration(seconds: 10),
                ).show(context);
            }
          } else {
            Flushbar(
              title: AppLocalizations.of(context)!.joiningGroupFailed,
              message: response['error'] !=null ? response['error'].toString() : response.toString(),
              duration: Duration(seconds: 10),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: AppLocalizations.of(context)!.errorsInForm,
          message: AppLocalizations.of(context)!.pleaseCompleteFormProperly,
          duration: Duration(seconds: 10),
        ).show(context);
      }

    };

/*
    String? validateCode(String? value) {
      String? _msg;
      if (value!.isEmpty) {
        _msg = AppLocalizations.of(context)!.pleaseProvideRegistrationCode;
      }
      return _msg;
    }
*/
    final codeField = TextFormField(
      autofocus: false,
      controller: controllers['code'],
      // validator: validateCode,
      onSaved: (value) => _registrationCode = value,
      decoration: buildInputDecoration(AppLocalizations.of(context)!.groupCode, Icons.code),

    );



    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.pleaseWaitSendingCode)
      ],
    );

    List <Widget> formfields = [];

    formfields.add(SizedBox(height: 10.0));
    formfields.add(label(AppLocalizations.of(context)!.enterGroupCode));
    formfields.add(SizedBox(height: 5.0));
    formfields.add(codeField);
    formfields.add( SizedBox(height: 10.0));
    formfields.add( this.formStatus == CodeStatus.Authenticating
        ? loading
        : longButtons(AppLocalizations.of(context)!.useCode, joinGroup));


    return formfields;
  }

  Widget joinGroupFormBody(status)
  {
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.loading)
      ],
    );

    switch(status){

      case CodeStatus.Idle:
        return Container(
          padding: EdgeInsets.symmetric(vertical:10,horizontal: 30),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Align(
                  alignment:Alignment.centerLeft,
                  child:Text(
                    AppLocalizations.of(context)!.joiningToUserGroup,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ...formButtons(),
]
            ),
          ),
        );


      case CodeStatus.Authenticating:
      // display spinner
        return loading;


      case CodeStatus.Accepted:
      //print('Status.Registered switch handler');

        return  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding:EdgeInsets.all(10),
              child:Row(
                  children:[
                    Icon(Icons.check),
                    Text(AppLocalizations.of(context)!.codeAccepted,
                        style:TextStyle(fontSize:20)),
                  ]),),
            SizedBox(height: 15.0),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    this.formStatus = CodeStatus.Idle;
                  });
                },
                child: Text(AppLocalizations.of(context)!.enterNewCode,style: TextStyle(fontWeight: FontWeight.w300))),


          ],
        );

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {

    this.user = Provider.of<core.UserProvider>(context).user;
    return joinGroupFormBody(this.formStatus);


  }
}