import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:intl/intl.dart';
//import 'package:luen/generated/l10n.dart';
import 'package:luen/src/objects/formelement.dart';
import 'package:file_picker/file_picker.dart';
import 'package:luen/src/objects/libraryitem.dart';
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectModel;
import 'package:luen/src/objects/form.dart' as iCMSForm;
import 'package:luen/src/providers/user_provider.dart';
import 'package:luen/src/util/api_client.dart';
import 'package:luen/src/util/utils.dart';
import 'package:luen/src/util/widgets.dart';
import 'package:provider/provider.dart';
import 'package:luen/src/util/navigator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DisplayForm extends StatefulWidget {
  final objectModel.FormElementProvider formElementProvider =
  objectModel.FormElementProvider();
  final objectModel.LibraryItemProvider bookProvider = objectModel.LibraryItemProvider();
  final LibraryItem book;
  final iCMSForm.Form form;
  DisplayForm(this.book,this.form);
  @override
  _DisplayFormState createState() => new _DisplayFormState();
  static _DisplayFormState? of(BuildContext context) =>
      context.findAncestorStateOfType<_DisplayFormState>();
}

class _DisplayFormState extends State<DisplayForm>{

    final formKey = new GlobalKey<FormState>();
    final ApiClient _apiClient = ApiClient();

    User? user;
    bool elementsLoaded = false;
    bool answersLoaded = false;
    Map<int, FormElementData> selectedOptions = {};
    int? answersetKey;
    Map<int,dynamic> formData = {};

    Future<void> loadElements(form)
    async {
      elementsLoaded = true;
     // print('loadElements called for form '+form.title+' which has status '+form.loadingStatus.toString());

      Map<String,dynamic> params={
        'targetitemtype' :'libraryitem',
        'targetitemid' : widget.book.id.toString(),
        'api_key': this.user!=null ? this.user!.token :null,
      };

      params['formid']=form.id.toString();
      if(form.loadingStatus==iCMSForm.LoadingStatus.Idle) {
        form.loadingStatus = iCMSForm.LoadingStatus.Loading;
        dynamic result = await widget.formElementProvider.getElements(params);

        setState(() {

     //     print(result.length.toString() + ' elements found for form ' + form.title);
          form.loadingStatus = iCMSForm.LoadingStatus.Ready;
          form.elements.clear();
          for(var i in result)
            form.elements.add(i);
          //if(result.isNotEmpty()) form.elements.addAll(result);
          loadAnswers(form);
        });
      }
    }

    Future<void> loadAnswers(form)
    async {

  //    print('loadAnswers called for form '+form.id.toString()+' '+form.title+', user '+this.user!.id.toString());

      Map<String,dynamic> params={
        'formid' : form.id.toString(),
        'targetitemtype' :'libraryitem',
        'targetitemid' : widget.book.id.toString(),
        'action' :'loadanswers',
        'method' :'json',
        'api_key': this.user!=null ? this.user!.token :null,
      };

       _apiClient.loadFormData(params)!.then((responseData) {
          setState(() {
            answersLoaded = true;
            var response = responseData['data'];
        //    print(response.toString());
            if(response!=null)
            response.forEach((key,data) {
              print(data['formelementid']);
              int eid = data['formelementid'] is int ? data['formelementid'] : int.parse(data['formelementid']);
              if(data['answer']!=null) {
                dynamic answer;
                print('setting  answer to "' + data['answer'].toString() +
                    '", type: ' + data['answer'].runtimeType.toString());
                try {
                  answer = json.decode(data['answer']);
                } on FormatException {
                  answer = data['answer'];
                }
                if (data['answertype'] == 'checkbox') {
                  if (this.formData[eid] == null || !(this.formData[eid] is List)) {
                    this.formData[eid] = [];
                  }
                  formData[eid].add(answer);
                }
                else
                  formData[eid] = answer;
              }
            });

        });
      });
    }

    @override
    void initState(){
      //print('initing FillForm view state');
      // this.loadFormCategories();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.form.loadingStatus = iCMSForm.LoadingStatus.Idle;
        if(!elementsLoaded)
        this.loadElements(widget.form);

     });
     super.initState();
    }

    @override
    Widget build(BuildContext context)
    {
      //Get user provider
      this.user = Provider.of<UserProvider>(context).user;
      //Get current form
      iCMSForm.Form form = widget.form;

      //tester status sets display of bug reporting button
      bool isTester = false;
      if(this.user!.data!=null) {
        if (this.user!.data!['istester'] != null) {
          if (this.user!.data!['istester'] == 'true') isTester = true;
        }
      }
      return Scaffold(
          appBar: AppBar(
            title: Text(form.title!),
            elevation: 0.1,
              actions: [
              if(isTester)
                IconButton(
                  icon: Icon(Icons.bug_report),
                  onPressed:(){feedbackAction(context,this.user!); }
                ),
              ]
          ),
          body: SingleChildScrollView(
      child:Form(
              key: formKey,
              child:formBody(form)
            ),
          ),
      );
    }
    Widget formBody(iCMSForm.Form form)
    {
      /**
       * Function that sends the form data to server
       */
      var sendForm = () {
        final form = formKey.currentState;
        if (form!.validate()) {
          form.save();
          bool formIsEmpty = true;
        bool hasData = false;
          Map<String,dynamic> requestData = {};
          this.formData.forEach((key,value){
            hasData = false;
            if (value.runtimeType==bool && value!=false) {
              hasData = true;
              print('value is boolean ' + value.toString());
            }
            else if (value.runtimeType==String){
              if(value.isNotEmpty && value!=null) {
                hasData = true;
                print('value is non-empty String: ' + value);
              }
              else print('value is empty String.');
            }
            else if(value!=null) {
              print('value of type ' +value.runtimeType.toString()+' is non-null:'+value.toString());
              hasData = true;
            }
              if(hasData) {
                print('formData field ' + key.toString() + ' has value "' +
                    value.toString() + '" of type ' +
                    value.runtimeType.toString());
                formIsEmpty = false;
              }
              else print('formData field '+key.toString()+' of type '+value.runtimeType.toString()+' is empty:'+value.toString());

              requestData.putIfAbsent('element_'+key.toString(), ()=> value);
          });
          if(formIsEmpty)
            {
              Flushbar(
                title: AppLocalizations.of(context)!.formIsEmpty,
                message:  AppLocalizations.of(context)!.cannotSaveEmptyForm,
                duration: Duration(seconds: 10),
              ).show(context);
              return;
            }
          Map<String,dynamic> params={
            'method' :'json',
            'action' :'saveanswers',
            'formid' : widget.form.id.toString(),
            'targetitemtype' :'libraryitem',
            'targetitemid' : widget.book.id.toString(),
            'api_key': this.user!=null ? this.user!.token :null,
          };
          if(this.answersetKey!=null) {
            print('UPDATING ANSWERSET '+this.answersetKey.toString());
            params['answersetid'] = this.answersetKey.toString();
          }
          if(!formIsEmpty)
            _apiClient.saveFormData(params,requestData)!.then((var response) async {

            if(response['answersetid'] is int)
              this.answersetKey = response['answersetid'];

              switch(response['status']) {
                case 'fail':
                case 'error':
                  Flushbar(
                    title: AppLocalizations.of(context)!.savingDataFailed,
                    message: response['message'] != null ? response['message']
                        .toString() : response.toString(),
                    duration: Duration(seconds: 10),
                  ).show(context);

                  break;

                case 'success':
                  Flushbar(
                    title: AppLocalizations.of(context)!.answerSaved,
                    message: response['message'] != null ? response['message']
                        .toString() : AppLocalizations.of(context)!.yourAnswerHasBeenSaved,
                    duration: Duration(seconds: 10),
                  ).show(context);

                  var result = await Provider.of<UserProvider>(
                      context, listen: false).acceptBook(widget.book);
                  bool success = false;
                  if(result!=null && result['status'] == 'success') success = true;

                 handleNotifications(result['notifications'],context);
                  popupDialog(AppLocalizations.of(context)!.bookStatusUpdated,Column(children:[SingleChildScrollView(
                      child:Text('Kirja' +
                          (
                              success ? ' merkitty luetuksi! '
                                  : 'n hyväksyminen epäonnistui'),
                      )
                  ),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) async{
                        dynamic response = await widget.bookProvider.addRating(rating,widget.book,this.user);
                        String title = response['result']=='success' ? AppLocalizations.of(context)!.ratingSaved : AppLocalizations.of(context)!.oops;
                        Flushbar(
                          title: title,
                          message: response['message'].toString(),
                          duration: Duration(seconds: 3),
                        ).show(context);
                        print(rating);
                      },
                    ),
                  ]),context,actions:<Widget>[
                    ElevatedButton(
                        child: Text(success ? AppLocalizations.of(context)!.great : AppLocalizations.of(context)!.buggers),
                        onPressed:(){
                          setState(() {

                            goToLibraryItem(context, widget.book,replace:true);
                          });
                        }
                    )
                  ]);


              }
          });

          else{
            Flushbar(
              title: AppLocalizations.of(context)!.errorsInForm,
              message: AppLocalizations.of(context)!.pleaseCompleteFormProperly,
              duration: Duration(seconds: 10),
            ).show(context);
          }
        } else {
          Flushbar(
            title: AppLocalizations.of(context)!.errorsInForm,
            message: AppLocalizations.of(context)!.pleaseCompleteFormProperly,
            duration: Duration(seconds: 10),
          ).show(context);

        }

      };

      var loader=Align(
        alignment: Alignment.center,
        child: Center(
          child: ListTile(
            leading: CircularProgressIndicator(),
            title: Text(AppLocalizations.of(context)!.loading,
                textAlign: TextAlign.center),
          ),
        ),
      );
      List<Widget> inputs = [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.book.title ?? '',
            style: Theme.of(context).textTheme.headlineMedium),
          ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(form.description.toString(),
          ),
        )
      ];
      Widget input = Placeholder();
  //    print('loading status: '+form.loadingStatus.toString());
      switch(form.loadingStatus)
      {

        case iCMSForm.LoadingStatus.Ready:
          if(!(answersLoaded && elementsLoaded)) return loader;
          if(form.elements.isNotEmpty)
            {
              for(var e in form.elements){
            //    print(e.id.toString()+': '+e.type.toString());
                //create input field matching element type
                switch(e.type.toString()) {
                  case 'textarea':
                    //print('handling textarea');
                    Map<String,dynamic>p = {'maxlines':10};
                    input = TextFormFieldItem(element: e,value:this.formData.containsKey(e.id) ? this.formData[e.id] :'',params:p);
                    break;
                  case 'radio':

                    if(e.data!=null) {

                      input = RadioGroup(element: e,options:e.data as dynamic,selectedOption: this.formData.containsKey(e.id) ? (this.formData[e.id] is int ? this.formData[e.id] : int.parse(this.formData[e.id])) : e.data!.first.id);
                    }
                    else input = Text('no entry data found in '+e.data.toString());
                    break;

                  case 'file':
                   // print('handling file');
                    input = ElevatedButton(
                      onPressed: () async {

                        FilePickerResult? result = await FilePicker.platform.pickFiles();

                        if(result != null) {
                          File file = File(result.files.single.path as String);
                          this.formData[e.id??0] = file;
                        } else {
                          // User canceled the picker
                        }


                      },
                      child: Text(
                        AppLocalizations.of(context)!.chooseFile,
                        style: TextStyle(
                          // fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                    break;

                  default:
                    input = TextFormFieldItem(
                      element: e,
                      value:this.formData.containsKey(e.id) ? this.formData[e.id] :'',
                    );

                }
                //add the input with label and surrounding element to list
                inputs.add(Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment:Alignment.centerLeft,
                    child:Text(e.title.toString(),
                      style: Theme.of(context).textTheme.headlineSmall),
                )
                )
                );
                inputs.add(Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: input,
                ));
              }
            }
          return Column(
              children:[
              //  Text(form.elements.length.toString()+' elements found:'),
                ...inputs,
              longButtons(AppLocalizations.of(context)!.sendAnswer, sendForm),
              ]

          );
        default:
          if(form.loadingStatus==iCMSForm.LoadingStatus.Idle && !elementsLoaded)
            this.loadElements(widget.form);
          return loader;
      }
    }

  }

class TextFormFieldItem extends StatefulWidget{
  final FormElement element;
  final String value;
  final Map<String,dynamic>? params ;
  TextFormFieldItem({required this.element, required this.value,this.params});
  _TextFormFieldItemState createState() => _TextFormFieldItemState();
}
class _TextFormFieldItemState extends State<TextFormFieldItem>{
  late String selectedValue;
  final  _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();

   // print('textformfield initialValue in initState: '+widget.value);
    // Start listening to changes.
    _textEditingController.text = widget.value;
    _textEditingController.addListener(updateTextFieldValue);
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _textEditingController.dispose();
    super.dispose();
  }
  void updateTextFieldValue()
  {

    String? value = _textEditingController.text;
  //  print('running updateTextFieldValue, value: '+value);
    setState(() {
      this.selectedValue = value;

      DisplayForm.of(context)!.formData[widget.element.id!] = value;
    });
  }
  Widget build(BuildContext context){
  //  print('building textformfield '+widget.element.id.toString()+', initialValue: '+widget.value);
    this.selectedValue = widget.value;
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
        controller: _textEditingController,
     // initialValue: widget.value,
      maxLines: widget.params!['maxlines'] ?? 10,
      decoration: InputDecoration(
          filled:true,
          hintText: widget.element.description ?? AppLocalizations.of(context)!.writeAnswerHere,//+': '+widget.element.title.toString(),

     ),
      validator: (String? value){

        if(widget.element.required==false) {
       //   print('element is not required!');
          return null;
        }
        return value!=null ? null : AppLocalizations.of(context)!.fieldCannotBeEmpty;
      }
    );
  }
}

class TextFieldItem extends StatefulWidget{
  final FormElement element;
  final String value;
  final Map<String,dynamic>? params ;
  TextFieldItem({required this.element, required this.value,this.params});
  @override
  _TextFieldItemState createState() => _TextFieldItemState();
}

class _TextFieldItemState extends State<TextFieldItem> {

  late String selectedValue;
  final  _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _textEditingController.addListener(updateTextFieldValue);
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _textEditingController.dispose();
    super.dispose();
  }
  void updateTextFieldValue()
  {
    String? value = _textEditingController.text;
    setState(() {
      this.selectedValue = value;

      DisplayForm.of(context)!.formData[widget.element.id!] = value;
    });
  }
  Widget build(BuildContext context) {
    this.selectedValue = widget.value;
    return TextField(
      controller: _textEditingController,
      //textDirection: TextDirection
      maxLines: widget.params!['maxlines'] ?? 10,

      decoration: InputDecoration(

          hintText: widget.element.description ?? AppLocalizations.of(context)!.writeAnswerHere,//+': '+widget.element.title.toString(),
          fillColor:createMaterialColor('#FFEDE30E')),
    );
  }
}

class RadioGroup extends StatefulWidget {
  final FormElement element;
  final List<dynamic> options;
  final int? selectedOption;  // default / original selected option

  RadioGroup({required this.element,required this.options,this.selectedOption});

  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}


class RadioGroupWidget extends State<RadioGroup> {

  // Default Radio Button Item
  int? selectedOptionValue;


  Widget build(BuildContext context) {
    if(this.selectedOptionValue==null)
      this.selectedOptionValue = (widget.selectedOption ?? '') as int?;
  //  print('building radio group; group value is '+this.selectedOptionValue.toString());

    return    Container(
              //height: 350.0,
              child: Column(
                children:[
                  if(widget.element.description != null)Text(widget.element.description ?? ''),
                ...widget.options.map((data) => RadioListTile<dynamic>(
                  title: Text("${data.value}"),
                  groupValue: this.selectedOptionValue,
                  value: data.id,
                  onChanged: (val) {
                    setState(() {
                   //   print('selecting: '+data.value.toString()+' ('+data.id.toString()+')');
                      this.selectedOptionValue = data.id ;


                      DisplayForm.of(context)!.formData[widget.element.id??0] = data.id;

                    });
                  },
                )).toList(),
              ]),
            );


  }
}