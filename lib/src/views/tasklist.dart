import 'package:flutter/material.dart';
import 'package:luen/src/objects/formcategory.dart';
import 'package:luen/src/objects/libraryitem.dart';
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/providers/user_provider.dart';
import 'package:luen/src/util/utils.dart';
import 'package:luen/src/util/widgets.dart';
import 'package:luen/src/views/fillform.dart';
import 'package:provider/provider.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectModel;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:luen/src/objects/form.dart' as iCMSForm;
import 'package:luen/src/objects/formcategory.dart' as iCMSFormCategory;
/*
* Tasks list (forms)
*/

class TaskList extends StatefulWidget {

  final objectModel.FormCategoryProvider formCategoryProvider =
  objectModel.FormCategoryProvider();
  final objectModel.FormProvider formProvider =
  objectModel.FormProvider();
  final LibraryItem? book;

  TaskList({ this.book });

  @override
  _TaskListState createState() => _TaskListState();
}
/*
class Item extends iCMSForm.Form {
  bool isExpanded = false;
  Item({id, title, description,isExpanded}) : super(id:id, title:title, description:description);

}
*/

class _TaskListState extends State<TaskList> {

  List<Widget> categoryWidgets = [];
  List<iCMSFormCategory.FormCategory> categories = [];
  List<iCMSForm.Form> tasks=[];

  bool categoriesLoaded = false;
  bool tasksLoaded = false;
  User? user;

  @override
  void initState(){
    print('initing TaskList view state');
    this.loadFormCategories();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      if(!categoriesLoaded)
        this.loadFormCategories();
    });
    super.initState();
  }

  Future<void> loadForms(formCategory)
  async {
    print('loadForms called for category '+formCategory.name);

    Map<String,dynamic> params={
      'accesslevel' : 'read',
      'api_key': this.user!=null ? this.user!.token :null,
    };
    params['category']=formCategory.id.toString();
    if(formCategory.loadingStatus==LoadingStatus.Idle) {
      formCategory.loadingStatus = LoadingStatus.Loading;
      dynamic result = await widget.formProvider.loadItems(params);

      setState(() {
        print(result.length.toString() + ' forms found for category ' + formCategory.name);
        formCategory.loadingStatus = LoadingStatus.Ready;
        formCategory.forms.addAll(result);
     /*  formCategory.forms.map<Item>((form){
          return Item(id:form.id,title:form.title,description:form.description,isExpanded: false);
        }).toList();
        */

      });
    }
    //else formCategory.tasksLoaded = true;
  }

  Future<void> loadFormCategories()
  async {
    print('loadFormCategories called');
    Map<String,dynamic> params={
      'api_key': this.user!=null ? this.user!.token :null,
    };
    dynamic result = await widget.formCategoryProvider.loadItems(params);


      print(result.length.toString()+' categories loaded.');
      this.categories.addAll(result);
      categoriesLoaded = true;
      if(categories.isNotEmpty)
      {

        for(iCMSFormCategory.FormCategory c in categories) {
          setState(() {
            loadForms(c);
          });
          // Iterate tasks

        }

    }
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding Tasklist view');
    categoryWidgets.clear();
    this.user = Provider.of<UserProvider>(context).user;
    for(iCMSFormCategory.FormCategory c in categories) {
      categoryWidgets.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(c.name.toString(),style:TextStyle(fontSize:20)),
      ));
      categoryWidgets.add(_getTasks(c, user));
    }

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

    bool isTester = false;
    if(this.user!.data!=null) {
      if (this.user!.data!['istester'] != null) {
        if (this.user!.data!['istester'] == 'true') isTester = true;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.tasks),
        elevation: 0.1,
          actions: [
          if(isTester) IconButton(
        icon: Icon(Icons.bug_report),
    onPressed:(){feedbackAction(context,this.user!); }
    ),
    ]
      ),
      body: ListView(
        children: <Widget>[

          if(categoriesLoaded) ...categoryWidgets,
          if(!categoriesLoaded) loader ,
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                Expanded(
                  child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.btnReturn)
                    ),
                  ),
                ),


              ]
          ),

        ],
      ),
      bottomNavigationBar: bottomNavigation(context)
    );
  } //widget

  Widget formItem(i)
  {

    return
          Row(

              children: [Expanded(
                  flex: 1,
                  child: Icon(Icons.view_list)),
                Expanded(
                    flex: 4,
                    child: Text(i.title.toString())
                ),
                Expanded(
                    flex: 2,
                    child: TextButton(
                      onPressed: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DisplayForm(widget.book!,i))
                          );

                      },

                      child: Column( children:[Text(
                        AppLocalizations.of(context)!.choose,
                        style: TextStyle(
                          // fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                        if(i.data.badge!=null) Text('Ansiomerkkitehtävä!')
                        ]),
                    )
                )

              ]
          );

  }

  Widget _getTasks(formCategory,user) {
    //print('getTasks called for formCategory '+formCategory.name.toString()+' having '+formCategory.forms.length.toString()+' items and loadingStatus '+formCategory.loadingStatus.toString());


    switch (formCategory.loadingStatus) {
      case LoadingStatus.Ready:

        //data loaded
       // List<iCMSForm.Form> tasks = formCategory.forms;
        if(formCategory.forms.isEmpty)
          return Align(alignment:Alignment.center,
            child:Center(
              child:ListTile(
                leading:Icon(Icons.info),
                title: Text(AppLocalizations.of(context)!.noTasks,textAlign: TextAlign.left),
              ),
            ),
          );




        return ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
           // print(isExpanded.toString());
            setState(() {
              formCategory.forms[index].isExpanded = !isExpanded;
            });
          },
          children: formCategory.forms.map<ExpansionPanel>((iCMSForm.Form form){
          //  print(form.data?.toString());
            return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                      title:Text(form.title.toString()),
                    subtitle:  form.data?['badge']!=null ? Row(children:[Icon(Icons.emoji_events),Text('Ansiomerkkitehtävä')]) :null,
                  );
                },
                body: ListTile(
                  title: Text(form.description.toString()),

                  trailing:  Column(
                    children:[ElevatedButton(
                    onPressed: () {
                         LibraryItem libraryItem = widget.book?? new LibraryItem();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DisplayForm(libraryItem,form))
                          );

                    },
                    child:
                      Text(
                      AppLocalizations.of(context)!.choose,
                      style: TextStyle(
                        // fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ),

                    ]
                  ),

            ),
                isExpanded:form.isExpanded,
            );
        }).toList(),
        );

        default:
          return Align(
            alignment: Alignment.center,
            child: Center(
              child: ListTile(
                leading: CircularProgressIndicator(),
                title: Text(AppLocalizations.of(context)!.loading,
                    textAlign: TextAlign.center),
              ),
            ),
          );





    }
  }

}
