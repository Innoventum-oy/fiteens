import 'dart:developer';
import 'package:another_flushbar/flushbar.dart';
import 'package:core/core.dart' as core;
import 'package:fiteens/src/views/mywellbeing/components/question.dart';
import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../util/constants.dart' as constants;
import '../../util/utils.dart';

/// Wellbeing assessment 
class AssessmentScreen extends StatefulWidget {
  final core.Form form;
  final int navIndex;
  final bool refresh;
  const AssessmentScreen({required this.form,this.navIndex=2,this.refresh=false,super.key});

  @override
  State<StatefulWidget> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {

  final _pageViewController = PageController(initialPage: 0);
  final formKey = new GlobalKey<FormState>();
  Map<int, core.FormElementData> selectedOptions = {};
  int? answersetKey;
  Map<int, dynamic> formData = {};
  final core.ApiClient _apiClient = core.ApiClient();

  bool loading = false;

  @override
  void dispose(){
    _pageViewController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
   // log(formData.toString());
    return ScreenScaffold(
        title: AppLocalizations.of(context)!.navitem('mywellbeing'),
        navigationIndex: widget.navIndex,
        refresh: widget.refresh ,
        onRefresh:(){

          constants.Router.navigate(context,'mywellbeing',widget.navIndex,refresh: true);
        },
        child: assessmentView(),
    );
  }
  Widget assessmentView(){

    var sendForm = () {
      final formState = formKey.currentState;
      if (formState!.validate()) {
        formState.save();
        bool hasData = false;
        Map<String, dynamic> requestData = {};
        this.formData.forEach((key, value) {
          if (value != null) hasData = true;
          if (value.runtimeType.toString() == 'bool' && value != false) {
            hasData = true;

          }
          if (value.runtimeType.toString() == 'String' && value.isNotEmpty && value!='null') {
            hasData = true;

          }

          if(hasData)
            requestData.putIfAbsent('element_' + key.toString(), () => value);
        });
        setState(() {
          loading = true;
        });
        Map<String, dynamic> params = {
          'method': 'json',
          'action': 'saveanswers',
          'formid': widget.form.id.toString(),

        };
        if (this.answersetKey != null) {
          params['answersetid'] = this.answersetKey.toString();
        }
        if (hasData)
          _apiClient
              .saveFormData(params, requestData)!
              .then((var response) async {
            if (response['answersetid'] is int) {
              this.answersetKey = response['answersetid'];
            }
            setState(() {
              loading = false;
            });
            switch (response['status']) {
              case 'fail':
              case 'error':
                if(kDebugMode) log(response.toString());
                Flushbar(
                  title: AppLocalizations.of(context)!.savingDataFailed,
                  message: response['message'] != null
                      ? response['message'].toString()
                      : response.toString(),
                  duration: Duration(seconds: 10),
                ).show(context);
                if(response['data']!=null && kDebugMode)
                  response['data'].forEach((key,dataset){
                    log(key.toString()+': '+dataset.toString());
                  });
                break;

              case 'success':
                Flushbar(
                  title: AppLocalizations.of(context)!.answerSaved,
                  message: response['message'] != null
                      ? response['message'].toString()
                      : AppLocalizations.of(context)!.answerSaved,
                  duration: Duration(seconds: 10),
                ).show(context);

                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title:
                      Text(AppLocalizations.of(NavigationService.navigatorKey.currentContext ?? context)!.answerSaved),
                      content: SingleChildScrollView(
                          child: Text(
                            response['message'] != null
                                ? response['message'].toString()
                                : AppLocalizations.of(NavigationService.navigatorKey.currentContext ?? context)!.answerSaved,
                          )),
                      actions: <Widget>[
                        ElevatedButton(
                            child:
                            Text(AppLocalizations.of(NavigationService.navigatorKey.currentContext ?? context)!.great),
                            onPressed: () {
                              setState(() {

                                Navigator.of(context, rootNavigator: true).pop();
                                constants.Router.navigate(context,'mywellbeing',widget.navIndex,refresh: true);
                              });
                            })
                      ],
                    ));
            }
          });
        else {
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

    Iterable<core.FormElement> pages = widget.form.elements?.where((element) => element.type=='radio') ?? [];

    Widget loadedContent = Form(key: formKey,child:PageView.builder(

      controller: _pageViewController,
      itemCount: pages.length,
      itemBuilder:(context,index) {
      List<Widget> buttons = [];
      core.FormElement e = pages.elementAt(index);
        if (index>0) {

          // add button to previous page
          buttons.add(ElevatedButton.icon(onPressed: () =>
              _pageViewController.previousPage( duration: Duration(
                  milliseconds: 300), curve: Curves.linear),
              icon: Icon(Icons.arrow_back),
                  label: Text(AppLocalizations.of(context)!.previous)));
        }
        if (index < pages.length-1) {
          // add button to next page

          buttons.add(ElevatedButton.icon(onPressed: () {
              if (_pageViewController.hasClients)
              _pageViewController.nextPage( duration: Duration(
                  milliseconds: 300), curve: Curves.linear);},
              icon: Icon(Icons.arrow_forward),
              label: Text(AppLocalizations
                  .of(context)!.next)));
        }
        else if (index == pages.length-1){
          // add submit button if every (required) question has an answer
          buttons.add(
            ElevatedButton.icon(
              onPressed: ()=>loading ? null : sendForm(),
              icon:loading ? CircularProgressIndicator() : Icon(Icons.send),
              label: Text(loading ? AppLocalizations.of(context)!.loading : AppLocalizations.of(context)!.sendAnswer)
            )
          );
        }


      return SingleChildScrollView(child:
          Question(element:e,onChanged: (val){
            log('Setting formdata-${e.id} to $val');
            log('Current formdata:');
            log(formData.toString());
            //advance to next page if answering new question
            bool advance = formData[e.id]==null ? true : false;
            setState(() {
              if(e.id!=null) formData[e.id??0] = val;
            });
            if(advance && index < pages.length) {

              _pageViewController.nextPage( duration: Duration(
                milliseconds: 300), curve: Curves.linear);
            }
      }, selectedOption: formData[e.id] ?? null,
      buttons: buttons,
      index:index+1,
      pageCount: pages.length),
      );
    }),
    );
    return defaultContent(loadedContent);
  }
}
Widget defaultContent(contentChild){
  return Padding(
      padding:EdgeInsets.all(30),
      child:Center(
          child:contentChild)

  );

}
