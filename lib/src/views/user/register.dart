import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:core/core.dart' as core;

enum ContactMethod{
  Phone,
  Email
}
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
  String? _firstname,
      _lastname,
      _guardianname,
      _email,
      _phone,
      _guardianphone,
      _password,
      _confirmPassword,
      _registrationCode;
  bool isOver13 = true;
  ContactMethod selectedContactMethod = ContactMethod.Phone;
  Map<String,TextEditingController> controllers = {
    'lastname' : new TextEditingController(),
    'firstname': new TextEditingController(),
    'email' : new TextEditingController(),
    'phone' : new TextEditingController(),
    'code' : new TextEditingController(),
    'password' : new TextEditingController(),
    'guadianname' : new TextEditingController(),
    'guardianphone' : new TextEditingController()
  };

 List<Widget> formButtons(auth)
  {
    var doRegister = () {
      final form = formKey.currentState;
      if (form!.validate()) {
        form.save();
        _auth.register(
            firstname:_firstname.toString(),
            lastname: _lastname.toString(),
            email:_email.toString(),
            phone: _phone.toString(),
            password:_password.toString(),
            passwordConfirmation:_confirmPassword.toString(),
            registrationCode: _registrationCode.toString(),
           guardianName: _guardianname.toString(),
           guardianPhone: _guardianphone.toString()
        )!.then((responsedata) {
          var response = responsedata['data'] ?? responsedata;
          if(response!=null) if( response['status']!=null) {

            switch(response['status']) {
              case 'error':
                Flushbar(
                  title: AppLocalizations.of(context)!.registrationFailed,
                  message: response['message'] !=null ? response['message'].toString() : response['error'].toString(),
                  duration: Duration(seconds: 10),
                ).show(context);

                break;

              case 'success':
                if (response['user'] != null) {
                  var userData = response['user'];
                  print('saving users to UserPreferences');
                  core.User authUser = core.User.fromJson(userData);

                  core.UserPreferences().saveUser(authUser);

                  auth.setLoggedInStatus(core.Status.loggedIn);
                  auth.setContactMethodId(response['contactmethodid']);
                  Provider.of<core.UserProvider>(context, listen: false).setUser(
                      authUser);
                  setState(() {
                    print('setting registeredStatus to Registered');
                    auth.setRegisteredStatus(core.Status.registered);
                  });
                }
            }
          } else {
            Flushbar(
              title: AppLocalizations.of(context)!.registrationFailed,
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
    String? validateName(String? value) {
      String? _msg;

      if (value!.isEmpty) {
        _msg = AppLocalizations.of(context)!.pleaseProvideYourName;
      }
      return _msg;
    }
    String? validatePhone(String? value)
    {

      String? _msg;
      if(value!.isEmpty) return AppLocalizations.of(context)!.pleaseEnterPhoneNumber;

      //test for phone number pattern
      String pattern = r'(^(?:[+0])?[0-9]{8,12}$)';
      RegExp regExp = new RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        _msg = AppLocalizations.of(context)!.pleaseProvideValidPhoneNumber;
      }

      return _msg;
    }

    String? validateGuardianPhone(String? value)
    {
          String? _msg;
          if(this.isOver13) return null;
          if(value!.isEmpty) return AppLocalizations.of(context)!.pleaseEnterPhoneNumber;

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
    /*
    String? validateCode(String? value) {
      String? _msg;
      if (value!.isEmpty) {
        _msg = AppLocalizations.of(context)!.pleaseProvideRegistrationCode;
      }
      return _msg;
    }
*/
    final firstnameField = TextFormField(
      autofocus: false,
      controller : controllers['firstname'],
      validator: validateName,
      onSaved: (value) => _firstname = value,
      decoration: buildInputDecoration(AppLocalizations.of(context)!.firstName,Icons.person ),
    );
    final lastnameField = TextFormField(
      autofocus: false,
      controller: controllers['lastname'],
      validator: validateName,
      onSaved: (value) => _lastname = value,
      decoration: buildInputDecoration(AppLocalizations.of(context)!.lastName,Icons.person ),
    );
    final guardianNameField = TextFormField(
      autofocus: false,
      controller: controllers['guardianname'],
      validator: (value) => value!.isEmpty && !this.isOver13 ? AppLocalizations.of(context)!.valueIsRequired : null,
      onSaved: (value) => _guardianname = value,
      decoration: buildInputDecoration(AppLocalizations.of(context)!.guardianName,Icons.person ),
    );
    final codeField = TextFormField(
      autofocus: false,
      controller: controllers['code'],
     // validator: validateCode,
      onSaved: (value) => _registrationCode = value,
      decoration: buildInputDecoration(AppLocalizations.of(context)!.groupCode, Icons.code),

    );
    final emailField = TextFormField(
      autofocus: false,
      controller: controllers['email'],
      validator: validateEmail,
      onSaved: (value) => _email = value,
      decoration: buildInputDecoration(AppLocalizations.of(context)!.email, Icons.email),
    );
    final phoneField = TextFormField(
      autofocus: false,
      controller: controllers['phone'],
      validator: validatePhone,
      onChanged: (value) => _phone = value,
      decoration: buildInputDecoration(AppLocalizations.of(context)!.phone, Icons.phone_iphone),
    );
    final guardianPhoneField = TextFormField(
      autofocus: false,
      controller: controllers['guardianphone'],
      validator: validateGuardianPhone,
      onChanged: (value) => _guardianphone = value,
      decoration: buildInputDecoration(AppLocalizations.of(context)!.guardianPhone, Icons.phone_iphone),
    );
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: controllers['password'],
      validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.pleaseEnterPassword : null,
      onChanged: (value) => _password = value,
      decoration: buildInputDecoration(AppLocalizations.of(context)!.enterPassword, Icons.lock),
    );

    final confirmPasswordField = TextFormField(
      autofocus: false,
      validator: (value) { if(value != _password) {
      //  print(value.toString()+' != '+_password.toString());
          return AppLocalizations.of(context)!.passwordsDontMatch;
        }
        if(value!.isEmpty)  return AppLocalizations.of(context)!.passwordIsRequired;
        return null;

      },
      onSaved: (value) => _confirmPassword = value,
      obscureText: true,
      decoration: buildInputDecoration(AppLocalizations.of(context)!.confirmPassword, Icons.lock),
    );



    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.pleaseWaitRegistering)
      ],
    );

    List <Widget> formfields = [
      label(AppLocalizations.of(context)!.firstName),
      SizedBox(height: 5.0),
      firstnameField,
      SizedBox(height: 10.0),
      label(AppLocalizations.of(context)!.lastName),
      SizedBox(height: 5.0),
      lastnameField,
      SizedBox(height:10.0),
      label(AppLocalizations.of(context)!.ageOver13),
      AgeSelectDisplay(options:[{'value':'Yes','id':1},{'value':'No','id':0}]),

      ];
      if(!this.isOver13){
        formfields.addAll([
          SizedBox(height: 10.0),
          label(AppLocalizations.of(context)!.guardianInfo),
          SizedBox(height: 5.0),
          guardianNameField,
          guardianPhoneField,
          SizedBox(height: 10.0),
        ]);
      }
    formfields.addAll([
      SizedBox(height: 10.0),
      label(AppLocalizations.of(context)!.password),
      SizedBox(height: 5.0),
      passwordField,
      SizedBox(height: 10.0),
      label(AppLocalizations.of(context)!.confirmPassword),
      SizedBox(height: 5.0),
      confirmPasswordField,

      SizedBox(height: 10.0),
  ]);
    switch(selectedContactMethod) {
      case ContactMethod.Email:
        //add email field + change to phone field button
      //clear possible phone field value
      _phone='';
      controllers['phone']!.clear();
      formfields.add(label(AppLocalizations.of(context)!.email));
      formfields.add(emailField);
      formfields.add(TextButton(
          onPressed: () {
            // Change to phone field
            setState((){
              selectedContactMethod = ContactMethod.Phone;
            });
          },
          child: Text(AppLocalizations.of(context)!.btnUsePhone,style: TextStyle(fontWeight: FontWeight.w300)))
      );
        break;

      default:
        // add phone field + change to email button

        //clear possible email field value
        _email = '';
        controllers['email']!.clear();
        formfields.add(label(AppLocalizations.of(context)!.phone));
        formfields.add(phoneField);
        formfields.add(TextButton(
        onPressed: () {
          // Change to email field
          setState((){
            selectedContactMethod = ContactMethod.Email;
         });
        },
        child: Text(AppLocalizations.of(context)!.btnUseEmail,style: TextStyle(fontWeight: FontWeight.w300)))
        );

    }
    formfields.add(SizedBox(height: 10.0));
    formfields.add(label(AppLocalizations.of(context)!.groupCode));
    formfields.add(SizedBox(height: 5.0));
    formfields.add(codeField);
   formfields.add( SizedBox(height: 10.0));
    formfields.add( auth.registeredStatus == core.Status.authenticating
    ? loading
        : longButtons(AppLocalizations.of(context)!.createAccount, doRegister));
    formfields.add(ElevatedButton(
      onPressed: () {
      // Navigate back to the first screen by popping the current route
      // off the stack.
        Navigator.pushReplacementNamed(context, '/login');

      },
      child: Text(AppLocalizations.of(context)!.btnReturn,style: TextStyle(fontWeight: FontWeight.w300)))
    );

    return formfields;
  }

  Widget registerViewBody(auth)
  {
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.pleaseWaitRegistering)
      ],
    );

    switch(auth.registeredStatus){

      case core.Status.notRegistered:
       return Container(
          padding: EdgeInsets.all(40.0),
          child: Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                formButtons(auth),

            ),
          ),
        );


      case core.Status.registering:
        // display spinner
      return loading;


      case core.Status.registered:
        //print('Status.Registered switch handler');

        return  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                /*Padding(
                  padding:EdgeInsets.all(10),
                  child:Row(
                    children:[
                      Icon(Icons.check),
                      Text(AppLocalizations.of(context)!.accountCreated,
                          style:TextStyle(fontSize:20)),
                    ]),),
                SizedBox(height: 15.0),
                ElevatedButton(
                    onPressed: () {
                      // Navigate to validatecontact
                      Navigator.pushReplacementNamed(context, '/validatecontact');
                    },
                    child: Text(AppLocalizations.of(context)!.btnValidateContact,style: TextStyle(fontWeight: FontWeight.w300))),

                 */
                SizedBox(height: 15.0),
                ElevatedButton(
                    onPressed: () {
                      // Navigate to dashboard
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                    child: Text(AppLocalizations.of(context)!.btnContinue,style: TextStyle(fontWeight: FontWeight.w300)))
              ],
        );



      default:
        return Container();

    }
  }

  @override
  Widget build(BuildContext context) {
   print('building registration form');
   core.AuthProvider auth = Provider.of<core.AuthProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.createAccount),
          elevation: 0.1,
        ),
        body: SingleChildScrollView(
            child:registerViewBody(auth)
        )
      ),
    );
  }
}

class AgeSelectDisplay extends StatefulWidget {
  final List<dynamic> options;
  final int? selectedOption;  // default / original selected option

  AgeSelectDisplay({required this.options,this.selectedOption});

  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}


class RadioGroupWidget extends State<AgeSelectDisplay> {

  // Default Radio Button Item
  int? selectedOptionValue;


  Widget build(BuildContext context) {

    //  print('building radio group; group value is '+this.selectedOptionValue.toString());

    return    Container(
      //height: 350.0,
      child: Column(
          children:[

            ...widget.options.map((data) => RadioListTile<dynamic>(
              title: Text("${data['value']}"),
              groupValue: this.selectedOptionValue,
              value: data['id'],
              onChanged: (val) {
                setState(() {
                //   print('selecting: '+data.value.toString()+' ('+data.id.toString()+')');
                this.selectedOptionValue = data['id'];
                Register.of(context)!.setState(() {
                  Register.of(context)!.isOver13 = data['id'] == 1 ? true : false;
                });
               print('is over 13?' + Register.of(context)!.isOver13.toString());


                });
              },
            )).toList(),
          ]),
    );


  }
}