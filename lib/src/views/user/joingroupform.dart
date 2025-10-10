import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:fiteens/l10n/app_localizations.dart';
import 'package:core/core.dart' as core;

enum CodeStatus {
  idle,
  authenticating,
  accepted

}
class JoinGroupForm extends StatefulWidget {
  const JoinGroupForm({super.key});

  @override
  JoinGroupFormState createState() => JoinGroupFormState();
}

class JoinGroupFormState extends State<JoinGroupForm> {
  final formKey = GlobalKey<FormState>();
  //final core.ApiClient _apiClient = core.ApiClient();
  String?  _registrationCode;
  CodeStatus formStatus = CodeStatus.idle;
  core.User? user;

  Map<String,TextEditingController> controllers = {

    'code' : TextEditingController()
  };

  List<Widget> formButtons()
  {
    joinGroup() {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        Provider.of<core.UserProvider>(context,listen:false).joinGroup(
             _registrationCode.toString(),
            user ?? core.User()
        ).then((core.ApiResponse responseData) {
          dynamic response = responseData.data;
          if(response!=null && response['status']!=null) {

            switch(response['status']) {
              case 'error':
                Flushbar(
                  title: AppLocalizations.of(context)!.joiningGroupFailed,
                  message: response['message'] !=null ? response['message'].toString() : response['error'].toString(),
                  duration: const Duration(seconds: 10),
                ).show(context);

                break;

              case 'success':
             // spell out something
              setState(() {
                formStatus = CodeStatus.accepted;
              });
                Flushbar(
                  title: AppLocalizations.of(context)!.joinedToGroup,
                  message: response['message'] !=null ? response['message'].toString() : response.toString(),
                  duration: const Duration(seconds: 10),
                ).show(context);
            }
          } else {
            Flushbar(
              title: AppLocalizations.of(context)!.joiningGroupFailed,
              message: response['error'] !=null ? response['error'].toString() : response.toString(),
              duration: const Duration(seconds: 10),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: AppLocalizations.of(context)!.errorsInForm,
          message: AppLocalizations.of(context)!.pleaseCompleteFormProperly,
          duration: const Duration(seconds: 10),
        ).show(context);
      }

    }

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
        const CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.pleaseWaitSendingCode)
      ],
    );

    List <Widget> formfields = [];

    formfields.add(const SizedBox(height: 10.0));
    formfields.add(label(AppLocalizations.of(context)!.enterGroupCode));
    formfields.add(const SizedBox(height: 5.0));
    formfields.add(codeField);
    formfields.add( const SizedBox(height: 10.0));
    formfields.add( formStatus == CodeStatus.authenticating
        ? loading
        : longButtons(AppLocalizations.of(context)!.useCode, joinGroup));


    return formfields;
  }

  Widget joinGroupFormBody(status)
  {
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.loading)
      ],
    );

    switch(status){

      case CodeStatus.idle:
        return Container(
          padding: const EdgeInsets.symmetric(vertical:10,horizontal: 30),
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


      case CodeStatus.authenticating:
      // display spinner
        return loading;


      case CodeStatus.accepted:
      //print('Status.Registered switch handler');

        return  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding:const EdgeInsets.all(10),
              child:Row(
                  children:[
                    const Icon(Icons.check),
                    Text(AppLocalizations.of(context)!.codeAccepted,
                        style:const TextStyle(fontSize:20)),
                  ]),),
            const SizedBox(height: 15.0),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    formStatus = CodeStatus.idle;
                  });
                },
                child: Text(AppLocalizations.of(context)!.enterNewCode,style: const TextStyle(fontWeight: FontWeight.w300))),


          ],
        );

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {

    user = Provider.of<core.UserProvider>(context).user;
    return joinGroupFormBody(formStatus);


  }
}