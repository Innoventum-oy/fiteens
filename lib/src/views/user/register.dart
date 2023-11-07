import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:core/core.dart' as core;

import '../dashboard/components/useravatar.dart';

enum ContactMethod { Phone, Email }

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();

  static _RegisterState? of(BuildContext context) =>
      context.findAncestorStateOfType<_RegisterState>();
}

class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();

  //final core.ApiClient _apiClient = core.ApiClient();
  final core.Auth _auth = core.Auth();
  Map <String,dynamic> _formData = {};
  Map <String,bool> _showPassword = {};
  bool isOver13 = true;
  ContactMethod selectedContactMethod = ContactMethod.Phone;

  Map<String, TextEditingController> controllers = {
    'lastname': new TextEditingController(),
    'firstname': new TextEditingController(),
    'email': new TextEditingController(),
    'phone': new TextEditingController(),
    'registrationCode': new TextEditingController(),
    'password': new TextEditingController(),
    'confirmPassword' : new TextEditingController(),
    'guardianName': new TextEditingController(),
    'guardianPhone': new TextEditingController()
  };

  List<Widget> formButtons(auth, userProvider) {
    var doRegister = () {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        _formData.updateAll((key, value) => value.toString());
        _auth.register(
          firstname: _formData['firstname'],
          lastname: _formData['lastname'],
          email: _formData['email'],
          phone: _formData['phone'],
          password: _formData['password'],
          passwordConfirmation: _formData['confirmPassword'],
          registrationCode: _formData['registrationCode'],
          guardianName: _formData['guardianname'],
          guardianPhone: _formData['guardianphone'],
          data: {'avatar': _formData['avatar']},
        )!.then((responseData) {
          var response = responseData['data'] ?? responseData;
          if (response != null) if (response['status'] != null) {
            switch (response['status']) {
              case 'error':
                Flushbar(
                  title: AppLocalizations.of(context)!.registrationFailed,
                  message: response['message'] != null
                      ? response['message'].toString()
                      : response['error'].toString(),
                  duration: Duration(seconds: 10),
                ).show(context);

                break;

              case 'success':
                if (response['user'] != null) {
                  var userData = response['user'];
                  print('saving users to UserPreferences');
                  core.User authUser = core.User.fromJson(userData);

                  core.UserPreferences.saveUser(authUser);

                  auth.setLoggedInStatus(core.Status.loggedIn);
                  auth.setContactMethodId(response['contactmethodid']);
                  Provider.of<core.UserProvider>(context, listen: false)
                      .setUser(authUser);
                  setState(() {
                    print('setting registeredStatus to Registered');
                    auth.setRegisteredStatus(core.Status.registered);
                  });
                }
            }
          } else {
            Flushbar(
              title: AppLocalizations.of(context)!.registrationFailed,
              message: response['error'] != null
                  ? response['error'].toString()
                  : response.toString(),
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
    String? validateName(String? value) {
      String? _msg;
      if (value!.isEmpty) {
        _msg = AppLocalizations.of(context)!.pleaseProvideYourName;
      }
      return _msg;
    }

    String? validatePhone(String? value) {
      String? _msg;
      if (value!.isEmpty)
        return AppLocalizations.of(context)!.pleaseEnterPhoneNumber;

      //test for phone number pattern
      String pattern = r'(^(?:[+0])?[0-9]{8,12}$)';
      RegExp regExp = new RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        _msg = AppLocalizations.of(context)!.pleaseProvideValidPhoneNumber;
      }

      return _msg;
    }

    String? validateGuardianPhone(String? value) {
      String? _msg;
      if (this.isOver13) return null;
      if (value!.isEmpty)
        return AppLocalizations.of(context)!.pleaseEnterPhoneNumber;

      //test for phone number pattern
      String pattern = r'(^(?:[+0])?[0-9]{8,12}$)';
      RegExp regExp = new RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        _msg = AppLocalizations.of(context)!.pleaseProvideValidPhoneNumber;
      }
      return _msg;
    }

    String? validateEmail(String? value) {
      String? _msg;
      RegExp regex = new RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      if (value!.isEmpty) {
        _msg = AppLocalizations.of(context)!.pleaseProvideValidEmail;
      } else if (!regex.hasMatch(value)) {
        _msg = AppLocalizations.of(context)!.pleaseProvideValidEmail;
      }
      return _msg;
    }

    Widget showTextIconButton(field){
      return IconButton(
        icon: Icon(
          // Based on passwordVisible state choose the icon
          _showPassword[field] !=null && _showPassword[field]!
              ? Icons.visibility
              : Icons.visibility_off,
          //  color:  Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          // Update the state i.e. toogle the state of passwordVisible variable
          setState(() {
            _showPassword[field] =_showPassword[field] == null || !_showPassword[field]! ? true : false;
          });
        },
      );
    }

    Widget registrationField({
      required String field,
      required String title,
      bool autoFocus = false,
      IconData? icon,
      TextEditingController? controller,
      String? Function(String?)? validatorFunction,
      Function? onSave,
      bool isPassword = false
    }){
      Widget? suffix = isPassword ?showTextIconButton(field) : null;
      return Column(
        children:[
          label(title),
          SizedBox(height: 5.0),
          TextFormField(
          obscureText: (isPassword && _showPassword[field]==null || _showPassword[field]==false) ? true : false,
          autofocus: autoFocus,
          controller: controller,
          validator: validatorFunction,
          onSaved: onSave != null ? onSave() : (value)=> _formData[field] = value,
          decoration: buildInputDecoration(title, icon,suffixIcon: suffix),

          ),
          SizedBox(height: 10.0),
        ]
      );
    }

    final firstnameField = registrationField(
        field: 'firstname',
        title: AppLocalizations.of(context)!.firstName,
        icon : Icons.person,
        controller: controllers['firstname'],
        validatorFunction: validateName
        );

    final lastnameField = registrationField(
        field: 'lastname',
        title:AppLocalizations.of(context)!.lastName,
        icon:Icons.person,
        controller: controllers['lastname'],
      validatorFunction: validateName);

    final guardianNameField = registrationField(
      title: AppLocalizations.of(context)!.guardianName,
      icon: Icons.person,
      validatorFunction: (value) => value!.isEmpty && !this.isOver13
          ? AppLocalizations.of(context)!.valueIsRequired
          : null,
      controller:  controllers['guardianName'],
      field: 'guardianName',
    );

    final codeField = registrationField(
      field: 'registrationCode',
      title: AppLocalizations.of(context)!.groupCode,
      icon: Icons.code,
      controller: controllers['registrationCode']
    );

    final emailField = registrationField(
      field: 'email',
      title: AppLocalizations.of(context)!.email,
      icon: Icons.email,
      controller: controllers['email'],
      validatorFunction: validateEmail,
    );

    final phoneField = registrationField(
      field: 'phone',
      title: AppLocalizations.of(context)!.phone,
      icon: Icons.phone_iphone,
      controller: controllers['phone'],
      validatorFunction: validatePhone,
    );

    final guardianPhoneField = registrationField(
      field: 'guardianPhone',
      title: AppLocalizations.of(context)!.guardianPhone,
      icon: Icons.phone_iphone,
      controller: controllers['guardianPhone'],
      validatorFunction: validateGuardianPhone,
    ) ;

    final passwordField = registrationField(
      field: 'password',
      title: AppLocalizations.of(context)!.enterPassword,
      icon: Icons.lock,
      controller:controllers['password'],
      validatorFunction: (value) => value!.isEmpty
          ? AppLocalizations.of(context)!.pleaseEnterPassword
          : null,
      isPassword: true
    );

    final confirmPasswordField = registrationField(
      field:'confirmPassword',
      title:AppLocalizations.of(context)!.confirmPassword,
      icon: Icons.lock,
      validatorFunction: (value) {
        if (value != _formData['password']) {
          return AppLocalizations.of(context)!.passwordsDontMatch;
        }
        if (value!.isEmpty)
          return AppLocalizations.of(context)!.passwordIsRequired;
        return null;
      },
      isPassword: true,
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.pleaseWaitRegistering)
      ],
    );

    List<Widget> formFields = [
      Center(
          child: Column(children: [
        userAvatar(userProvider.user, context, currentAvatar: _formData['avatar'],
            onTap: (image) {
          setState(() {
            _formData['avatar'] = image;
          });
          Navigator.pop(context);
        }),
        if (_formData['avatar'] == null)
          Text(AppLocalizations.of(context)!.clickPictureToChooseAvatar)
      ])),

      firstnameField,

      lastnameField,

      label(AppLocalizations.of(context)!.ageOver13),
      AgeSelectDisplay(options: [
        {'value': AppLocalizations.of(context)!.yes, 'id': 1},
        {'value': AppLocalizations.of(context)!.no, 'id': 0}
      ]),
    ];
    if (!this.isOver13) {
      formFields.addAll([

        guardianNameField,
        guardianPhoneField,

      ]);
    }
    formFields.addAll([
      passwordField,
      confirmPasswordField,
    ]);
    switch (selectedContactMethod) {
      case ContactMethod.Email:
        //add email field + change to phone field button
        //clear possible phone field value
        _formData['phone'] = '';
        controllers['phone']!.clear();
        formFields.add(emailField);
        formFields.add(TextButton(
            onPressed: () {
              // Change to phone field
              setState(() {
                selectedContactMethod = ContactMethod.Phone;
              });
            },
            child: Text(AppLocalizations.of(context)!.btnUsePhone,
                style: TextStyle(fontWeight: FontWeight.w300))));
        break;

      default:
        // add phone field + change to email button

        //clear possible email field value
        _formData['email'] = '';
        controllers['email']!.clear();
        formFields.add(phoneField);
        formFields.add(TextButton(
            onPressed: () {
              // Change to email field
              setState(() {
                selectedContactMethod = ContactMethod.Email;
              });
            },
            child: Text(AppLocalizations.of(context)!.btnUseEmail,
                style: TextStyle(fontWeight: FontWeight.w300))));
    }

    formFields.add(codeField);
    formFields.add(SizedBox(height: 10.0));
    formFields.add(auth.registeredStatus == core.Status.authenticating
        ? loading
        : longButtons(AppLocalizations.of(context)!.createAccount, doRegister));

    return formFields;
  }

  Widget registerViewBody(auth, userProvider) {
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.pleaseWaitRegistering)
      ],
    );

    switch (auth.registeredStatus) {
      case core.Status.notRegistered:
        return Container(
          padding: EdgeInsets.all(40.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: formButtons(auth, userProvider),
            ),
          ),
        );

      case core.Status.registering:
        // display spinner
        return loading;

      case core.Status.registered:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 15.0),
            ElevatedButton(
                onPressed: () {
                  // Navigate to dashboard
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
                child: Text(AppLocalizations.of(context)!.btnContinue,
                    style: TextStyle(fontWeight: FontWeight.w300)))
          ],
        );

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('building registration form, avatar: ${_formData['avatar']}');
    core.AuthProvider auth = Provider.of<core.AuthProvider>(context);
    core.UserProvider userProvider = Provider.of<core.UserProvider>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.createAccount),
            elevation: 0.1,
          ),
          body: SingleChildScrollView(
              child: registerViewBody(auth, userProvider))),
    );
  }
}

class AgeSelectDisplay extends StatefulWidget {
  final List<dynamic> options;
  final int? selectedOption; // default / original selected option

  AgeSelectDisplay({required this.options, this.selectedOption});

  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class RadioGroupWidget extends State<AgeSelectDisplay> {
  // Default Radio Button Item
  int? selectedOptionValue;

  Widget build(BuildContext context) {
    //  print('building radio group; group value is '+this.selectedOptionValue.toString());

    return Container(
      //height: 350.0,
      child: Column(children: [
        ...widget.options
            .map((data) => RadioListTile<dynamic>(
                  title: Text("${data['value']}"),
                  groupValue: this.selectedOptionValue,
                  value: data['id'],
                  onChanged: (val) {
                    setState(() {
                      //   print('selecting: '+data.value.toString()+' ('+data.id.toString()+')');
                      this.selectedOptionValue = data['id'];
                      Register.of(context)!.setState(() {
                        Register.of(context)!.isOver13 =
                            data['id'] == 1 ? true : false;
                      });
                      print('is over 13?' +
                          Register.of(context)!.isOver13.toString());
                    });
                  },
                ))
            .toList(),
      ]),
    );
  }
}
