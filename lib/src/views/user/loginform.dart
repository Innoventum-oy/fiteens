import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:fiteens/src/util/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:fiteens/src/views/webpage/webpagetextcontent.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:core/core.dart' as core;

class Login extends StatefulWidget {
  final dynamic user;

  const Login({super.key, this.user});
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? _contact, _password;
  String serverName = '';
  String serverUrl ='';
  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  bool _showPassword = false;
  late core.AuthProvider auth;
  late core.UserProvider userProvider;
  late final Map? servers;


  LoginState() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) => setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    }));

    core.Settings().getServerName().then((val) => setState(() {
      serverName = val;
    }));
  }

  @override void initState() {
    if(kDebugMode){
      log("Initing loginform state");
    }
    super.initState();
    userProvider = Provider.of<core.UserProvider>(context, listen: false);
    getServers();

  }
  void getServers() async{
    servers = await core.AppSettings().getMap('servers');
  }
  @override
  void didChangeDependencies() {
     auth = Provider.of<core.AuthProvider>(context);
     userProvider = Provider.of<core.UserProvider>(context, listen: false);
    super.didChangeDependencies();
  }
  @override
  void dispose(){
    log('disposing loginform state');
  //  auth.dispose();
  //  userProvider.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    if(kDebugMode){
      log('Building loginform');
    }

    userProvider = Provider.of<core.UserProvider>(context);
    auth = Provider.of<core.AuthProvider>(context);
    core.User? user = widget.user;
    String? contact = _contact ;
    if (user != null && contact == null ) {
      contact = user.phone != null
          ? user.phone!
          : user.email != null
          ? user.email!
          : '';
    }

    Widget showTextIconButton(){
      return IconButton(
        icon: Icon(
          // Based on passwordVisible state choose the icon
            _showPassword
              ? Icons.visibility
              : Icons.visibility_off,
        //  color:  Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          // Update the state i.e. toogle the state of passwordVisible variable
          setState(() {
            _showPassword = !_showPassword;
          });
        },
      );
    }

    String? validateContact(String? value)
    {

      String? msg;
      if(value!.isEmpty) return AppLocalizations.of(context)!.pleaseEnterPhoneOrEmail;

      //test for phone number pattern
      String pattern = r'(^(?:[+0])?[0-9]{10,12}$)';
      RegExp regExp = RegExp(pattern);
      if (regExp.hasMatch(value)) {
        return null;
      }
      //test for email pattern
      RegExp regex = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      if (!regex.hasMatch(value)) {
        msg = AppLocalizations.of(context)!.pleaseProvideValidPhoneOrEmail;
      }
      return msg;
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
      obscureText: !_showPassword,
      initialValue: _password,
      style: const TextStyle(color: Colors.white),
      validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.pleaseEnterPassword : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration(
          AppLocalizations.of(context)!.password, Icons.lock,
      suffixIcon: showTextIconButton() ),

    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.authenticating)
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex:2,
    child:ElevatedButton(

          child: Text(AppLocalizations.of(context)!.forgotPassword,
              style: const TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.pushNamed(context, '/reset-password');
          },
        ),
        ),
        const SizedBox(width:10),
        Expanded(
          flex:2,
          child:
        ElevatedButton(

          child: Text(AppLocalizations.of(context)!.createAccount, style: const TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            auth.setRegisteredStatus(core.Status.notRegistered);
            Navigator.pushNamed(context, '/register');
          },
        ),
        ),
      ],
    );
    final cancelButton = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget> [
        TextButton(

          child: Text(AppLocalizations.of(context)!.cancel,
              style: const TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () async {

            //auth.logout(user);
            auth.cancelLogin();
          },
        ),
      ],
    );


    doLogin() {
      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();
        setState(() {
          isLoading = true;
          if(kDebugMode){
            log('logging in(isLoading set to true)');
          }
        });

        final Future<Map<String, dynamic>> successfulMessage =
        auth.login(_contact!, _password!);

        successfulMessage.then((response) {
          if (response['status']) {
            core.User user = response['user'];
            userProvider.setUser(user);
            // No longer required since main listens to auth state and reloads view
            // Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            // userProvider.clearUser();
            if(mounted) {
              Flushbar(
              title: AppLocalizations.of(context)!.loginFailed,
              message: response['message'].toString(),
              duration: const Duration(seconds: 3),
            ).show(context);
            }
          }
          setState(() {
            isLoading = false;

          });
        });
      }

    }


    return SafeArea(
      child: Scaffold(
    /*    appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appName+' / '+AppLocalizations.of(context)!.loginTitle),
          elevation: 0.1,
        ),*/
        body:
          Container(
           //color: appBackground,
            //color:HexColor.fromHex('#205c7b'),
          padding: const EdgeInsets.all(40.0),
          child: ListView(
              children: <Widget>[
                 Center(
                  child:
                  Image.asset('images/fiteens-logotext-white.png'),
                  ),
                Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15.0),
                label(AppLocalizations.of(context)!.emailOrPhoneNumber),
                const SizedBox(height: 5.0),
                contactField,
                const SizedBox(height: 20.0),
                label(AppLocalizations.of(context)!.yourPassword),
                const SizedBox(height: 5.0),
                passwordField,
                const SizedBox(height: 20.0),
                isLoading
                    ? loading
                    : longButtons(AppLocalizations.of(context)!.btnLogin, doLogin),
                const SizedBox(height: 15.0),
                forgotLabel,
                const SizedBox(height: 15.0),
                auth.loggedInStatus == core.Status.authenticating
                    ? cancelButton : Container(),
                Row(children:[
                  if(kDebugMode) GestureDetector(child: Text("[$serverName] "), onTap: () {
                    serverSelectDialog(context);
                  },),getVersionInfo(),
                ]),
                policyLink(),
                // Erasmus logo and Sepie logo
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Image.asset('images/erasmus-cofunded-logo-white.png',width: 100,),

                        Image.asset('images/SEPIE_erasmus_plus.gif',width: 100,),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height:10),
                Center(child: Text(fundingDisclaimer,style: const TextStyle(fontSize: 11),))
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
        ? const Icon(Icons.check, color: Colors.blue)
        : const Icon(null);
  }
  Widget getVersionInfo() {
    return Text('$appName v.$version($buildNumber)',
      // style: TextStyle(color: Color(0xFFffe8d7))
        );
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
        child: Text(AppLocalizations.of(context)!.privacyPolicy,style: const TextStyle(
            fontWeight: FontWeight.w300,
           //color: Color(0xFFffe8d7)
        ))
    );
  }
  void serverSelectDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
          title:  const Text(
              'Server'),
          content: SizedBox(
            width: double.maxFinite,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight:
                  MediaQuery.of(context).size.height *
                      0.9,
                  minHeight:
                  MediaQuery.of(context).size.height *
                      0.5,
                  maxWidth:
                  MediaQuery.of(context).size.width * 0.9,
                  minWidth:
                  MediaQuery.of(context).size.width *
                      0.9),
              child: SettingsList(sections:[SettingsSection(
                  title: const Text('Choose server'),
                  tiles: environmentOptions(context)),
            ]
            ),
            ),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          actions: <Widget>[
            ElevatedButton(
              child:
              const Text('Close'),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ]),
    );

  }
  List<SettingsTile> environmentOptions(BuildContext context) {
    
    List<SettingsTile> tiles = [];
    servers?.forEach((serverTitle, itemUrl) {
      tiles.add(SettingsTile(
        title: Text(serverTitle),

        // subtitle: serverUrl,

        leading: trailingWidget(serverTitle),
        onPressed: (BuildContext context) {
          
          serverName = serverTitle;
          serverUrl = itemUrl;
          
          core.Settings().setValue('server', serverUrl);
          core.Settings().setValue('servername', serverTitle);
          core.ApiClient().reset();
          core.UserPreferences.removeUser();
          if(kDebugMode){
            /// Clear hive
            core.FileStorage().empty();
          }
          //  Provider.of<UserProvider>(context, listen: false).clearUser();
          //  Navigator.pushReplacementNamed(context, '/login');
          Navigator.of(context, rootNavigator: true).pop();
          setState(() {

          });
        },
      ));
    });

    return tiles.isNotEmpty ? tiles : [SettingsTile(title: const Text('No servers found'))];
  }
}
