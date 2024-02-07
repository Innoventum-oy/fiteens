import 'dart:developer';
import 'dart:math' as math;
import 'package:collection/collection.dart';
import 'package:core/core.dart' as core;
import 'package:fiteens/src/views/mywellbeing/assessmentscreen.dart';
import 'package:fiteens/src/widgets/screenscaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import '../../util/constants.dart' as constants;
import '../../util/navigator.dart';
/// My Wellbeing screen
class WellbeingScreen extends StatefulWidget {
  final int navIndex;
  final bool refresh;
  const WellbeingScreen({this.navIndex=2,this.refresh=false,super.key});

  @override
  State<StatefulWidget> createState() => _WellbeingScreenState();
}

class _WellbeingScreenState extends State<WellbeingScreen> {
  int answers = (math.Random().nextInt(3) + 1);
  List<dynamic> userAnswersets = [];
  List<dynamic> features = [];
  bool loaded = false;
  bool answersLoaded = false;
  bool featuresLoaded = false;
  late core.FormProvider formProvider;
  core.Form form = core.Form();
  final core.ApiClient apiClient = core.ApiClient();

  @override
  void initState() {
    /// Load form. The app only makes use of one form with commonname assessment
    formProvider = core.FormProvider();
    if (kDebugMode) {
      log('Loading assessment form and answers');
    }
    load();
    super.initState();
  }

  void load() async {
    log('Loading forms');
    await formProvider.loadItems(
        {'commonname': 'assessment'}).then((forms) {
      form = forms.first;
      setState(() {
        log('loaded ${forms.length} form(s)');

        loadGroups(form);
        loadElements(form);
      });
    });
  }

  /// Loads form element groups
  Future<void> loadGroups(core.Form form) async {
    if (kDebugMode) {
      log('loading groups for form ${form.id}');
    }
    Map<String, dynamic> params = {
      'formid': form.id.toString(),
      'action': 'loadelementgroups',
      'method': 'json',
    };

    apiClient.loadFormData(params).then((responseData) {
      setState(() {
        featuresLoaded = true;
        log("RESPONSE:: ${responseData?['data']}");
        features = responseData?['data'] ?? [];
      });
      return features;
    });
  }

  /// Loads form elements
  Future<void> loadElements(core.Form form) async {
    if (kDebugMode) {
      log('loading elements for form ${form.id}');
    }
    String formId = form.id.toString();
    Map<String, dynamic> params = {
      'formid': formId
    };

    List<core.FormElement>? result = await core.FormElementProvider()
        .getElements(params);

    log("${result.length} elements loaded");
    setState(() {
      form.loadingStatus = core.LoadingStatus.ready;

      form.elements?.clear();
      for (var i in result) {
        form.elements?.add(i);
      }
      loadAnswersets(form);
    });
  }

  /// Loads user answers to form, max 5 latest..

  Future<void> loadAnswersets(form) async {
    Map<String, dynamic> params = {
      'formid': form.id.toString(),
      'action': 'loadanswersets',
      'limit': '5',
      'order': 'editdate DESC',
      'method': 'json',
    };

    apiClient.loadFormData(params).then((responseData) {
      setState(() {
        answersLoaded = true;
        userAnswersets = responseData?['data'] ?? [];
      });
      return userAnswersets;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (featuresLoaded && answersLoaded &&
        form.loadingStatus == core.LoadingStatus.ready) loaded = true;
    answers = (math.Random().nextInt(3) + 1);


    List<Color> colors = [
      Colors.red,
      Colors.orangeAccent,
      Colors.green,
      Colors.blueAccent,
      Colors.purpleAccent,
      Colors.deepPurple,
      Colors.white10
    ];

    /// Iterate user answer data
    List<Map<String, dynamic>> answerData = [];
    List<List<int>> data = [];
    List<Color> graphColors = [];
    if (userAnswersets.isNotEmpty) {
      int i = 0;
      userAnswersets.forEach((answerset) {
        List<int> row = [];

        /// Group data by elementgroups (features)
        features.forEach((feature) {
          int featureScore = 0;

          /// Get the form elements in each group
          form.elements?.where((element) =>
          element.data?['formelementgroup'] == feature['id']).forEach((
              element) {
            /// Find the score of answers for the elements

            List<dynamic> answers = answerset['answers'].entries.toList();

            dynamic answer = answers.firstWhereOrNull((entry) =>
            entry.value['formelementid'].toString() == element.id.toString());

            if (answer != null) {
              List options = element.data!['data'] as List;
              dynamic selectedOption = options.firstWhere((e) =>
              e['id'] == answer.value['answer']);
              featureScore += double.parse(selectedOption['score']).round();
            }
          });
          /// Calculate the score as percent of max score
          featureScore = (featureScore / (feature['maxscore'] ?? 16) * 100).round();
          row.add(featureScore);
        });
        Color c = colors[i++];
        answerData.add({
          'answerset': answerset,
          'date': DateFormat('yyyy-MM-dd HH:mm:ss').parse(
              answerset['editdate']),
          'data': row,
          'color': c
        });
        if(answerset['show']!=false){
          data.add(row);
          graphColors.add(c);
        }
      });
    }

    // Sample answersets with date
    /*
    DateTime entryDate = DateTime.now();
    for(int i = 0; i<=answers;  i++ ){
      //Generate data
      log('generating answerset $i / $answers');
      List<int> row = [];
      for(var t in features){
        row.add(math.Random().nextInt(16));
      }

      entryDate = entryDate.subtract(Duration(days:math.Random().nextInt(31)));
      answerData.add({'date':entryDate,'data':row,'color':colors[i]});
      data.add(row);
    }

    */
    List<String> featureTitles = this.features.map((
        feature) => feature['title'] as String).toList();
    List<String> featureLongTitles = this.features.map((
        feature) => feature['description'] as String).toList();
    return ScreenScaffold(
        title: AppLocalizations.of(context)!.navitem('mywellbeing'),
        navigationIndex: widget.navIndex,
        refresh: widget.refresh,
        onRefresh: () {
          if (kDebugMode) {
            log('reloading page');
          }

          constants.Router.navigate(
              context, 'mywellbeing', widget.navIndex, refresh: true);
        },
        child: loaded ? SingleChildScrollView(
            child: Column(
                children: [

                  if(userAnswersets.isNotEmpty) SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.5,
                      child: wellbeingView(
                          data, features: featureTitles, colors: graphColors)),
                  if(userAnswersets.isEmpty) Center(
                      child: Text('Fill in the self assessment')),
                  //        Center(child:Text("$answers answer times generated")),
                  if(userAnswersets.isNotEmpty) headerSheet(featureLongTitles),
                  ...answerData.map((e) => answerSheet(e, featureTitles)),
                  ElevatedButton(
                      onPressed: () => goToWidget(context, AssessmentScreen(
                        form: form, navIndex: widget.navIndex,)),
                      child: Text(
                        AppLocalizations.of(context)!.startAssessment,)
                  ),
                ]
            )
        ) : Center(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white10,),
            SizedBox(width: 10,),
            Text(AppLocalizations.of(context)!.loading, style: TextStyle(
                color: Colors.white10
            ),)
          ],
        ))
    );
  }

  Widget wellbeingView(data,
      {required List<Color> colors, required List<String> features}) {
    const ticks = [25,50, 75, 100];

    return
      RadarChart(
        ticks: ticks,
        features: features,
        data: data,
        reverseAxis: false,
        graphColors: colors,
        outlineColor: Colors.white10,
        ticksTextStyle: TextStyle(color: Colors.orange, fontSize: 12),
        featuresTextStyle: TextStyle(color: Colors.white, fontSize: 16,),
        sides: features.length,

      );
  }

  Widget headerSheet(headers) {
    List<Widget> row = [
      SizedBox(width: 60,child:Icon(Icons.visibility),),
    ConstrainedBox(constraints: BoxConstraints.tight(Size(100,20)),child: Text(AppLocalizations.of(context)!.answerDate))];
    for (String header in headers) {
      row.add(Container(
          height: 150,
          child: RotatedBox(
              quarterTurns: 3,
              child: Text(header,
                  maxLines: 2,

                  style: TextStyle()
              )))

      );
    }
    return Card(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: row
            )
        )
    );
  }

  Widget answerSheet(data, headers) {
    DateTime date = data['date'];
   // log(data['answerset'].toString());
    List<Widget> row = [
      // Icon button to set data['show'] for
      SizedBox(width: 30,child:IconButton(
          onPressed: () {setState(() {
            bool trueval = data['answerset']['show']== null ? false :  !data['answerset']['show'] ;
            userAnswersets
                .firstWhereOrNull((element) => element['id'] == data['answerset']['id'])
                ?['show'] = trueval;
            log('set visibility to $trueval');
          });

          },
          icon: Icon(data['answerset']['show'] != false
              ? Icons.visibility_sharp
              : Icons.visibility_off)),
      ),
      ConstrainedBox(constraints: BoxConstraints.tight(Size(100,20)),child: Text(DateFormat.yMMMd().format(date)))
    ];
    List<int> answerData = data['data'];
    for (int i = 0; i < headers.length; i++) {
      row.add(Text(answerData[i].toString()));
    }
    return Card(child: Container(color: data['color'],
      child: Padding(padding: EdgeInsets.all(5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: row)
      ),)
    );
  }

  Widget defaultContent(contentChild) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: Center(
            child: contentChild)
    );
  }
}