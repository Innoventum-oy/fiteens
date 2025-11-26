import 'dart:developer';
import 'package:another_flushbar/flushbar.dart';
import 'package:core/core.dart' as core;
import 'package:fiteens/src/views/mywellbeing/components/question.dart';
import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fiteens/generated/l10n.dart';
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
  final formKey = GlobalKey<FormState>();
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
        title: AppLocalizations.of(context).navitem('mywellbeing'),
        navigationIndex: widget.navIndex,
        refresh: widget.refresh ,
        onRefresh:(){

          constants.Router.navigate(context,'mywellbeing',widget.navIndex,refresh: true);
        },
        child: assessmentView(),
    );
  }
  Widget assessmentView(){

    // Debug logging to diagnose form content issues
    if (kDebugMode) {
      log('=== AssessmentView Debug Info ===', name: 'AssessmentScreen');
      log('Form ID: ${widget.form.id}', name: 'AssessmentScreen');
      log('Form elements: ${widget.form.elements?.length ?? 0}', name: 'AssessmentScreen');
      log('Form loading status: ${widget.form.loadingStatus}', name: 'AssessmentScreen');

      if (widget.form.elements != null) {
        log('All form elements:', name: 'AssessmentScreen');
        for (var i = 0; i < widget.form.elements!.length; i++) {
          var element = widget.form.elements![i];
          log('  Element $i: id=${element.id}, type=${element.type}, title=${element.title}', name: 'AssessmentScreen');
        }

        // Count elements by type
        var radioElements = widget.form.elements!.where((e) => e.type == 'radio').toList();
        log('Radio elements found: ${radioElements.length}', name: 'AssessmentScreen');

        if (radioElements.isEmpty) {
          log('WARNING: No radio elements found! Element types:', name: 'AssessmentScreen');
          var types = widget.form.elements!.map((e) => e.type).toSet();
          log('  Available types: ${types.join(", ")}', name: 'AssessmentScreen');
        }
      } else {
        log('ERROR: widget.form.elements is null!', name: 'AssessmentScreen');
      }
      log('=================================', name: 'AssessmentScreen');
    }

    sendForm() {
      final formState = formKey.currentState;
      if (formState!.validate()) {
        formState.save();
        bool hasData = false;
        Map<String, dynamic> requestData = {};
        formData.forEach((key, value) {
          if (value != null) hasData = true;
          if (value.runtimeType.toString() == 'bool' && value != false) {
            hasData = true;
          }
          if (value.runtimeType.toString() == 'String' && value.isNotEmpty && value!='null') {
            hasData = true;
          }

          if(hasData) {
            requestData.putIfAbsent('element_$key', () => value);
          }
        });
        setState(() {
          loading = true;
        });
        Map<String, dynamic> params = {
          'method': 'json',
          'action': 'saveanswers',
          'formid': widget.form.id.toString(),

        };
        if (answersetKey != null) {
          params['answersetid'] = answersetKey.toString();
        }
        if (hasData) {
          _apiClient
              .saveFormData(params, requestData)
              .then((var response) async {

            if (kDebugMode) {
              log('=== SAVE FORM DEBUG ===', name: 'AssessmentScreen');
              log('Response: $response', name: 'AssessmentScreen');
              log('Response type: ${response.runtimeType}', name: 'AssessmentScreen');
              if (response != null) {
                log('Response status: ${response['status']}', name: 'AssessmentScreen');
                log('Response answersetid: ${response['answersetid']}', name: 'AssessmentScreen');
              }
              log('=======================', name: 'AssessmentScreen');
            }

            if (response?['answersetid'] is int) {
              answersetKey = response?['answersetid'];
            }

            setState(() {
              loading = false;
            });

            // Check for success - handle both null and non-null cases
            String status = response?['status']?.toString() ?? 'unknown';

            if (status == 'success') {
              // Success case
              if (kDebugMode) {
                log('Form saved successfully!', name: 'AssessmentScreen');
              }

              String successMessage = response?['message']?.toString() ??
                                     AppLocalizations.of(context).answerSaved;

              Flushbar(
                title: AppLocalizations.of(context).answerSaved,
                message: successMessage,
                duration: const Duration(seconds: 3),
              ).show(context);

              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(AppLocalizations.of(context).answerSaved),
                    content: SingleChildScrollView(
                        child: Text(successMessage)),
                    actions: <Widget>[
                      ElevatedButton(
                          child: Text(AppLocalizations.of(context).great),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            constants.Router.navigate(context,'mywellbeing',widget.navIndex,refresh: true);
                          })
                    ],
                  ));
            } else if (status == 'fail' || status == 'error') {
              // Error case
              if(kDebugMode) log('Form save failed: $response', name: 'AssessmentScreen');

              String errorMessage = response?['message']?.toString() ??
                                   response.toString();

              Flushbar(
                title: AppLocalizations.of(context).savingDataFailed,
                message: errorMessage,
                duration: const Duration(seconds: 10),
              ).show(context);

              if(response?['data']!=null && kDebugMode) {
                response?['data'].forEach((key,dataset){
                  log('$key: $dataset', name: 'AssessmentScreen');
                });
              }
            } else {
              // Unknown status
              if(kDebugMode) {
                log('Unknown response status: $status', name: 'AssessmentScreen');
              }
              Flushbar(
                title: AppLocalizations.of(context).error,
                message: 'Unexpected response: $status',
                duration: const Duration(seconds: 5),
              ).show(context);
            }
          }).catchError((error) {
            if (kDebugMode) {
              log('Error saving form: $error', name: 'AssessmentScreen');
            }
            setState(() {
              loading = false;
            });
            Flushbar(
              title: AppLocalizations.of(context).error,
              message: error.toString(),
              duration: const Duration(seconds: 10),
            ).show(context);
          });
        } else {
          Flushbar(
            title: AppLocalizations.of(context).errorsInForm,
            message: AppLocalizations.of(context).pleaseCompleteFormProperly,
            duration: const Duration(seconds: 10),
          ).show(context);
        }
      } else {
        Flushbar(
          title: AppLocalizations.of(context).errorsInForm,
          message: AppLocalizations.of(context).pleaseCompleteFormProperly,
          duration: const Duration(seconds: 10),
        ).show(context);
      }
    }

    Iterable<core.FormElement> pages = widget.form.elements?.where((element) => element.type=='radio') ?? [];

    // Show error message if no pages found
    if (pages.isEmpty) {
      if (kDebugMode) {
        log('ERROR: No radio elements found for assessment!', name: 'AssessmentScreen');
      }
      return defaultContent(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.orange),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context).errorsInForm,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'No assessment questions found.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Form ID: ${widget.form.id}\nElements: ${widget.form.elements?.length ?? 0}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context).btnReturn),
            ),
          ],
        ),
      );
    }

    Widget loadedContent = Form(key: formKey,child:PageView.builder(

      controller: _pageViewController,
      itemCount: pages.length,
      itemBuilder:(context,index) {
      List<Widget> buttons = [];
      core.FormElement e = pages.elementAt(index);
        if (index>0) {

          // add button to previous page
          buttons.add(ElevatedButton.icon(onPressed: () =>
              _pageViewController.previousPage( duration: const Duration(
                  milliseconds: 300), curve: Curves.linear),
              icon: const Icon(Icons.arrow_back),
                  label: Text(AppLocalizations.of(context).previous)));
        }
        if (index < pages.length-1) {
          // add button to next page

          buttons.add(ElevatedButton.icon(onPressed: () {
              if (_pageViewController.hasClients) {
                _pageViewController.nextPage( duration: const Duration(
                  milliseconds: 300), curve: Curves.linear);
              }},
              icon: const Icon(Icons.arrow_forward),
              label: Text(AppLocalizations
                  .of(context).next)));
        }
        else if (index == pages.length-1){
          // add submit button if every (required) question has an answer
          buttons.add(
            ElevatedButton.icon(
              onPressed: ()=>loading ? null : sendForm(),
              icon:loading ? const CircularProgressIndicator() : const Icon(Icons.send),
              label: Text(loading ? AppLocalizations.of(context).loading : AppLocalizations.of(context).sendAnswer)
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

              _pageViewController.nextPage( duration: const Duration(
                milliseconds: 300), curve: Curves.linear);
            }
      }, selectedOption: formData[e.id],
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
      padding:const EdgeInsets.all(30),
      child:Center(
          child:contentChild)

  );

}
