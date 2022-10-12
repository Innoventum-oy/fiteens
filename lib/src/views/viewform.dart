//import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:luen/src/objects/formelement.dart';
import 'package:luen/src/objects/libraryitem.dart';
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectModel;
import 'package:luen/src/objects/form.dart' as iCMSForm;
import 'package:luen/src/providers/user_provider.dart';
import 'package:luen/src/util/api_client.dart';
import 'package:luen/src/util/utils.dart';
import 'package:luen/src/util/widgets.dart';
import 'package:luen/src/views/fillform.dart';
import 'package:provider/provider.dart';

class DisplayFormAnswers extends StatefulWidget {
  final objectModel.FormElementProvider formElementProvider =
  objectModel.FormElementProvider();
  final LibraryItem book;
  final iCMSForm.Form form;
  DisplayFormAnswers(this.book,this.form);
  @override
  _DisplayFormAnswersState createState() => new _DisplayFormAnswersState();
  static _DisplayFormAnswersState? of(BuildContext context) =>
      context.findAncestorStateOfType<_DisplayFormAnswersState>();
}

class _DisplayFormAnswersState extends State<DisplayFormAnswers>{

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
              print('setting  answer to ' + data['answer'].toString() +
                  ', type: ' + data['answer'].runtimeType.toString());
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

              case 'radio':

                if(e.data!=null) {
                  print(formData.toString());
                  input = RadioGroupDisplay(element: e,options:e.data as dynamic,selectedOption: this.formData.containsKey(e.id) ? (this.formData[e.id] is int ? this.formData[e.id] : int.parse(this.formData[e.id])) : e.data!.first.id);
                }
                else input = Text('no entry data found in '+e.data.toString());
                break;



              default:
                String t = (this.formData.containsKey(e.id) && this.formData[e.id]!=null) ? this.formData[e.id] :'';
                input = Text(t);

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
              longButtons(AppLocalizations.of(context)!.edit, (){
                LibraryItem libraryItem = widget.book;
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DisplayForm(libraryItem,form))
                );
              }),
            ]

        );
      default:
        if(form.loadingStatus==iCMSForm.LoadingStatus.Idle && !elementsLoaded)
          this.loadElements(widget.form);
        return loader;
    }
  }

}




class RadioGroupDisplay extends StatefulWidget {
  final FormElement element;
  final List<dynamic> options;
  final int? selectedOption;  // default / original selected option

  RadioGroupDisplay({required this.element,required this.options,this.selectedOption});

  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}


class RadioGroupWidget extends State<RadioGroupDisplay> {

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
                // do nothing, this is only a display
              },
            )).toList(),
          ]),
    );


  }
}