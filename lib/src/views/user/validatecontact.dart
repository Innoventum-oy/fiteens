import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:core/core.dart' as core;

class ValidateContact extends StatefulWidget {
  final core.ContactMethod? contactMethod;

  const ValidateContact({super.key, this.contactMethod});
  @override
  ValidateContactState createState() => ValidateContactState();
}

class ValidateContactState extends State<ValidateContact> {
  final formKey = GlobalKey<FormState>();
  bool contactsLoaded = false;
  List<core.ContactMethod> contactItems = [];
  core.ContactMethod? selectedMethod;

  String?  _confirmKey, _contact;
  String? errorMessage;

  @override
  void initState(){

    if(widget.contactMethod!=null) {
      String address =widget.contactMethod!.address ??'null';
      _contact = address;
      selectedMethod = widget.contactMethod;
    }
   // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {


    // });
    super.initState();

  }
  @override
  @protected
  @mustCallSuper
  void didChangeDependencies() {
    //Provider.of<UserProvider>(context, listen: false).getContactMethods();
    if(widget.contactMethod!=null) {
      contactItems.add(widget.contactMethod!);
    } else if(!contactsLoaded) {

      Provider
          .of<core.UserProvider>(context)
          . getContactMethods();

      contactsLoaded = true;
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    core.AuthProvider auth = Provider.of<core.AuthProvider>(context);
    core.User user = Provider.of<core.UserProvider>(context).user;
    contactItems = Provider
        .of<core.UserProvider>(context)
        .contacts;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.validateContactTitle),
          elevation: 0.1,
            actions: const [

    ]
        ),
        body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Column(
              children:
              [Form(
                  key: formKey,
                  child: contactValidationFormBody(auth,user)
              ),
                bottomNavigation(auth),
              ]
          ),
        ),
      ),
    );
  }

  Widget contactValidationFormBody(auth,user)
  {
    switch(auth.verificationStatus)
    {
      case core.VerificationStatus.userNotFound:
      case core.VerificationStatus.codeNotRequested:
        return getConfirmationKeyForm(auth,user);

      case core.VerificationStatus.codeReceived:
        return enterConfirmationKeyForm(auth);

      case core.VerificationStatus.verified:
        return successForm();
      default:
        return Container();
    }
  }

  Widget getConfirmationKeyForm(auth,user) {

    getVerificationCode() {
      final form = formKey.currentState;

      if (form!.validate()) {
        form.save();

        final Future<Map<String, dynamic>?> successfulMessage =
        core.Auth().getConfirmationKey(_contact!);

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
              message: response?['message'].toString(),
              duration: const Duration(seconds: 3),
            ).show(context);
          }
        });
      }
    }

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const CircularProgressIndicator(),
        Text(AppLocalizations.of(context)!.processing)
      ],
    );

    /*  final contactField = TextFormField(
      controller: _contactController,
      autofocus: false,
      validator: validateContact,
      onSaved: (value) => _contact = value,
      decoration: buildInputDecoration(
          AppLocalizations.of(context)!.email, Icons.email),
    );
*/



    Widget contactFieldItem(contactmethod) {
      return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Radio<core.ContactMethod>(
                onChanged:(core.ContactMethod? value){
                  setState(()
                  {
                    selectedMethod = value;
                    _contact = value!.address;
                  });
                },
                value:contactmethod,
                groupValue: selectedMethod ,
              ),
              title: Text(contactmethod.address),
              subtitle: Text(contactmethod.verified ? AppLocalizations.of(context)!.verified : AppLocalizations.of(context)!.notVerified),
            ),

          ]
      );
    }
    Widget contactField(user) {
      // User user = Provider.of<UserProvider>(context).user;
      if(contactItems.isNotEmpty) {
        return ListView.builder(
            itemCount: contactItems.length,
            itemBuilder: (BuildContext context, int index) {

              return contactFieldItem(contactItems[index]);
            });
      } else {
        //No contact methods found error
        return Text(AppLocalizations.of(context)!.noContactMethodsFound);

      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 15.0),
        Text(AppLocalizations.of(context)!.contactMethod, style: Theme.of(context).textTheme.headlineSmall,),
        const SizedBox(height: 5.0),
        widget.contactMethod!=null ? Text(_contact ?? '') : SizedBox(
          height:200,
          child:contactField(user),
        ),


        const SizedBox(height: 20.0),
        auth.verificationStatus == core.VerificationStatus.validating
            ? loading
            : longButtons(AppLocalizations.of(context)!.getCode,
            getVerificationCode),
        const SizedBox(height: 5.0),

      ],
    );
  }

  Widget contactField(user) {
    // User user = Provider.of<UserProvider>(context).user;
    if(contactItems.isNotEmpty) {
      return ListView.builder(
          itemCount: contactItems.length,
          itemBuilder: (BuildContext context, int index) {

            return contactFieldItem(contactItems[index]);
          });
    } else {
      return const Placeholder();
    }
  }

  Widget contactFieldItem(contactmethod) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Radio<core.ContactMethod>(
              onChanged:(core.ContactMethod? value){
                setState(()
                {
                  selectedMethod = value;
                  _contact = value!.address;
                });
              },
              value:contactmethod,
              groupValue: selectedMethod ,
            ),
            title: Text(contactmethod.address),
            subtitle: Text(contactmethod.verified ? AppLocalizations.of(context)!.verified : AppLocalizations.of(context)!.notVerified),
          ),

        ]
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
        core.Auth().sendConfirmationKey(userid: auth.userId,contact: auth.contactMethodId, code:_confirmKey!.toString());

        successfulMessage.then((response) {
          if (response['status'] == 'success') {
            setState(() {
              auth.setSinglePass(response['singlepass']);
              auth.setVerificationStatus(core.VerificationStatus.verified);
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
        if(selectedMethod!=null) Text(selectedMethod!.address ?? '',style:const TextStyle(fontSize:15,fontWeight:FontWeight.bold)),
        const SizedBox(height: 15.0),
        label(AppLocalizations.of(context)!.confirmationKey),
        const SizedBox(height: 5.0),
        confirmationKeyField,

        const SizedBox(height: 20.0),
        auth.verificationStatus == core.VerificationStatus.validating
            ? loading
            : longButtons(AppLocalizations.of(context)!.btnConfirm,
            sendVerificationCode),

      ],
    );
  }

  Widget successForm()
  {
    return Row(
        children:[
          const Icon(Icons.check),
          Text(AppLocalizations.of(context)!.contactInformationValidated,
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize:20)),
        ]
    );

  }
  Widget bottomNavigation(auth) {
    List<Widget> elements = [];
    if(auth.loggedInStatus != core.Status.loggedIn ) {
      elements.add(ElevatedButton(
        child: Text(AppLocalizations.of(context)!.login,
            style: const TextStyle(fontWeight: FontWeight.w300)),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
      ));
    }
    else{
      elements.add(ElevatedButton(
        child: Text(AppLocalizations.of(context)!.btnDashboard,
            style: const TextStyle(fontWeight: FontWeight.w300)),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/dashboard');
        },
      ));
    }
    elements.add(returnButton(auth));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: elements,
    );
  }
  Widget returnButton(auth)
  {
    switch(auth.verificationStatus){
      case core.VerificationStatus.verified:
      // display button to return to code request form
        return ElevatedButton(
            child: Text(AppLocalizations.of(context)!.requestNewCode,
                style: const TextStyle(fontWeight: FontWeight.w300)),
            onPressed: () async {
              setState(() {
                auth.setVerificationStatus(core.VerificationStatus.codeNotRequested);
              });
            });

      case core.VerificationStatus.validating:
      case core.VerificationStatus.userNotFound:
      case core.VerificationStatus.codeReceived:
        return ElevatedButton(
            child: Text(AppLocalizations.of(context)!.previous,
                style: const TextStyle(fontWeight: FontWeight.w300)),
            onPressed: () async {
              setState(() {
                auth.setVerificationStatus(core.VerificationStatus.codeNotRequested);
              });
            });
      default:
        return Container();
    }//switch
  }



}