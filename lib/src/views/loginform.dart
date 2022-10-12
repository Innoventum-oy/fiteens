import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/providers/auth.dart';
import 'package:luen/src/providers/user_provider.dart';

import 'package:luen/src/util/widgets.dart';
import 'package:luen/src/views/webpagetextcontent.dart';
import 'package:provider/provider.dart';
import 'package:luen/src/util/utils.dart';
import 'package:luen/src/util/shared_preference.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info/package_info.dart';

class Login extends StatefulWidget {
  final dynamic user;

  Login({this.user});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  String? _contact, _password;
  String serverName = '';
  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  _LoginState() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) => setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    }));

    Settings().getServerName().then((val) => setState(() {
      serverName = val;
    }));
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    User? user = widget.user;
    String contact = '';
    if (user != null) {
      contact = user.phone != null
          ? user.phone!
          : user.email != null
          ? user.email!
          : '';
    }


    String? validateContact(String? value)
    {

      String? _msg;
      if(value!.isEmpty) return AppLocalizations.of(context)!.pleaseEnterPhoneOrEmail;

      //test for phone number pattern
      String pattern = r'(^(?:[+0])?[0-9]{10,12}$)';
      RegExp regExp = new RegExp(pattern);
      if (regExp.hasMatch(value)) {
        return null;
      }
      //test for email pattern
      RegExp regex = new RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      if (!regex.hasMatch(value)) {
        _msg = AppLocalizations.of(context)!.pleaseProvideValidPhoneOrEmail;
      }
      return _msg;
    }

    final contactField = TextFormField(
        autofocus: false,
        validator: validateContact,
        onSaved: (value) => _contact = value,
        decoration: buildInputDecoration(
            AppLocalizations.of(context)!.phoneOrEmail, Icons.email),
        initialValue: contact);

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.pleaseEnterPassword : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration(AppLocalizations.of(context)!.password, Icons.lock),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.authenticating)
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ElevatedButton(

          child: Text(AppLocalizations.of(context)!.forgotPassword,
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
        ElevatedButton(

          child: Text(AppLocalizations.of(context)!.createAccount, style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            auth.setRegisteredStatus(Status.NotRegistered);
            Navigator.pushNamed(context, '/register');
          },
        ),

      ],
    );
    final cancelButton = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget> [
        TextButton(

          child: Text(AppLocalizations.of(context)!.cancel,
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () async {

            //auth.logout(user);
            auth.cancellogin();
          },
        ),
      ],
    );


    var doLogin = () {
      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>> successfulMessage =
        auth.login(_contact!, _password!);

        successfulMessage.then((response) {
          if (response['status']) {
            User user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);

            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            Provider.of<UserProvider>(context, listen: false).clearUser();
            Flushbar(
              title: AppLocalizations.of(context)!.loginFailed,
              message: response['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        print("form is invalid");
      }
    };

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appName+' / '+AppLocalizations.of(context)!.loginTitle),
          elevation: 0.1,
        ),
        body:
          Container(
            color:HexColor.fromHex('#af1e53'),
          padding: EdgeInsets.all(40.0),
          child: ListView(
              children: <Widget>[
                 Center(
                  child:
                  Image.asset('images/riveillalogo.png'),
                  ),
                Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.0),
                label(AppLocalizations.of(context)!.emailOrPhoneNumber),
                SizedBox(height: 5.0),
                contactField,
                SizedBox(height: 20.0),
                label(AppLocalizations.of(context)!.yourPassword),
                SizedBox(height: 5.0),
                passwordField,
                SizedBox(height: 20.0),
                auth.loggedInStatus == Status.Authenticating
                    ? loading
                    : longButtons(AppLocalizations.of(context)!.btnLogin, doLogin),
                SizedBox(height: 5.0),
                forgotLabel,
                SizedBox(height: 15.0),
                auth.loggedInStatus == Status.Authenticating
                    ? cancelButton : Container(),
                getVersionInfo(),
                policyLink(),
              ],

            ),
          ),
        ]
        ),

        )
      ),

    );
  }
  Widget trailingWidget(String currentname) {
    return (serverName == currentname)
        ? Icon(Icons.check, color: Colors.blue)
        : Icon(null);
  }
  Widget getVersionInfo() {
    return Text(appName + ' v.' + version + '(' + buildNumber + ')',
        style: TextStyle(color: Color(0xFFffe8d7)));
  }
  Widget policyLink(){
    return TextButton(
        onPressed: () {
         //View policy page
          setState((){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ContentPageView('privacy-policy'))
            );
          });
        },
        child: Text(AppLocalizations.of(context)!.privacyPolicy,style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Color(0xFFffe8d7)
        ))
    );
  }
}