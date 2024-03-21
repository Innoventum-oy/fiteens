import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:core/core.dart' as core;

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  ResetPasswordState createState() => ResetPasswordState();
}

class ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();

  String? _contact, _confirmKey, _password;

  // core.ApiClient _apiClient = core.ApiClient();
  final core.Auth _auth = core.Auth();
  Widget getConfirmationKeyForm(auth) {
    final contactController = TextEditingController();
    getVerificationCode() {
      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>?> successfulMessage =
        _auth.getConfirmationKey(_contact!);

        successfulMessage.then((response) {

          if (response?['status'] == 'success') {
            setState(() {
              auth.setContactMethodId(response?['contactmethodid']);
              if(response?['userid']!=null) auth.setUserId(response?['userid']);

              auth.setVerificationStatus(core.VerificationStatus.codeReceived);
            });

          } else {

            Flushbar(
              title: AppLocalizations.of(context)!.requestFailed,
              message: response?['message'].toString()??AppLocalizations.of(context)!.requestFailed,
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
      }
    }

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.processing)
      ],
    );

    String? validateContact(String? value)
    {

      String? msg;
      if(value!.isEmpty) return AppLocalizations.of(context)!.pleaseEnterPhoneOrEmail;

      //test for phone number pattern
      String pattern = r'(^(?:[+0])?[0-9]{10,14}$)';
      RegExp regExp = RegExp(pattern);
      if (regExp.hasMatch(value)) {
        return null;
      }
      //test for email pattern
      RegExp regex = RegExp(
          r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      if (!regex.hasMatch(value)) {
        msg = AppLocalizations.of(context)!.pleaseProvideValidPhoneOrEmail;
      }
      return msg;
    }

    final contactField = TextFormField(
      controller: contactController,
      autofocus: false,
      validator: validateContact,
      onSaved: (value) => _contact = value,
      decoration: buildInputDecoration(
          AppLocalizations.of(context)!.emailOrPhoneNumber, Icons.email),
    );


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15.0),
        label(AppLocalizations.of(context)!.emailOrPhoneNumber),
        const SizedBox(height: 5.0),
        contactField,
        const SizedBox(height: 20.0),
        auth.verificationStatus == core.VerificationStatus.validating
            ? loading
            : longButtons(AppLocalizations.of(context)!.getCode,
            getVerificationCode),
        const SizedBox(height: 5.0),

      ],
    );
  }


  Widget enterConfirmationKeyForm(auth) {
    final confirmationController = TextEditingController();
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.processing)
      ],
    );

    final confirmationKeyField = TextFormField(
      autofocus: true,
      controller: confirmationController,
      validator: (value) =>
      value!.isEmpty ? AppLocalizations.of(context)!.pleaseEnterConfirmationKey : null,
      onSaved: (value) => _confirmKey = value,
      decoration: buildInputDecoration(
          AppLocalizations.of(context)!.confirmationKey, Icons.vpn_key),
    );

    sendVerificationCode() {
      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>> successfulMessage =
        _auth.sendConfirmationKey(userid: auth.userId,contact: auth.contactMethodId, code:_confirmKey!.toString());

        successfulMessage.then((response) {
          if (response['status'] == 'success') {
            setState(() {
              auth.setSinglePass(response['singlepass']);
              auth.setVerificationStatus(core.VerificationStatus.verified);
            });

          } else {
            String msg = '';
            if(response['messages']!=null) msg+= response['messages'].join(', ');

            Flushbar(
              title: AppLocalizations.of(context)!.requestFailed,
              message: msg,
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15.0),
        label(AppLocalizations.of(context)!.confirmationKey),
        const SizedBox(height: 5.0),
        confirmationKeyField,

        const SizedBox(height: 20.0),
        auth.verificationStatus == core.VerificationStatus.validating
            ? loading
            : longButtons(AppLocalizations.of(context)!.btnSend,
            sendVerificationCode),

      ],
    );
  }

  Widget updatePasswordForm(auth) {

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.processing)
      ],
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) =>
      value!.isEmpty ? AppLocalizations.of(context)!.pleaseEnterPassword : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration(
          AppLocalizations.of(context)!.confirmPassword, Icons.lock),
    );

    setPassword() {
      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();
        final Future<Map<String, dynamic>> successfulMessage =
        _auth.changePassword(userid: auth.userId, password:_password, singlepass: auth.singlePass);

        successfulMessage.then((response) {
          if (response['status'] == 'success') {
            setState(() {
              auth.setVerificationStatus(core.VerificationStatus.passwordChanged);

            });

          } else {
            Flushbar(
              title: AppLocalizations.of(context)!.requestFailed,
              message: response['message'].toString(),
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15.0),
        label(AppLocalizations.of(context)!.password),
        const SizedBox(height: 5.0),
        passwordField,
        const SizedBox(height: 20.0),
        auth.loggedInStatus == core.Status.authenticating
            ? loading
            : longButtons(AppLocalizations.of(context)!.btnSetNewPassword,
            setPassword),
        const SizedBox(height: 5.0),

      ],
    );
  }
  Widget successForm()
  {
    return Text(AppLocalizations.of(context)!.passwordChanged,
        style: const TextStyle(fontWeight: FontWeight.w300));

  }
  Widget bottomNavigation(auth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(child:ElevatedButton(
          child: Text(AppLocalizations.of(context)!.login,
              style: const TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        )),
        const SizedBox(width:10),
        Expanded(child:ElevatedButton(

          child: Text(AppLocalizations.of(context)!.signUp,
              style: const TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
        ),),
      // returnButton(auth),
      ],
    );
  }
  Widget returnButton(auth)
  {
    switch(auth.verificationStatus){
      case core.VerificationStatus.verified:
      // display button to return to code request form
        return TextButton(
            child: Text(AppLocalizations.of(context)!.requestNewCode,
                style: const TextStyle(fontWeight: FontWeight.w300)),
            onPressed: () async {
              setState(() {
                auth.setVerificationStatus(core.VerificationStatus.codeReceived);
              });
            });

      default:
        return TextButton(
            child: Text(AppLocalizations.of(context)!.previous,
                style: const TextStyle(fontWeight: FontWeight.w300)),
            onPressed: () async {
              setState(() {
                auth.setVerificationStatus(core.VerificationStatus.codeNotRequested);
              });
            });

    }//switch
  }

  @override
  Widget build(BuildContext context) {
    core.AuthProvider auth = Provider.of<core.AuthProvider>(context);


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.requestNewPasswordTitle),
          elevation: 0.1,
        ),
        body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Column(
              children:
              [Form(
                  key: formKey,
                  child: passwordRetrievalFormBody(auth)
              ),
             //   bottomNavigation(auth),
              ]
          ),
        ),
      ),
    );
  }

  Widget passwordRetrievalFormBody(auth)
  {


    switch(auth.verificationStatus)
    {
      case core.VerificationStatus.userNotFound:
      case core.VerificationStatus.codeNotRequested:
        return getConfirmationKeyForm(auth);

      case core.VerificationStatus.codeReceived:
        return enterConfirmationKeyForm(auth);

      case core.VerificationStatus.verified:
        return updatePasswordForm(auth);
      case core.VerificationStatus.passwordChanged:
        return successForm();
      default:
        return Container();
    }
  }
}