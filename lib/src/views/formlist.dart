import 'package:flutter/material.dart';
import 'package:fiteens/src/util/utils.dart';
import 'package:fiteens/src/widgets/widgets.dart';
import 'package:fiteens/src/views/fillform.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:core/core.dart' as core;

class FormList extends StatefulWidget {

  final core.FormCategoryProvider formCategoryProvider =
  core.FormCategoryProvider();
  final core.FormProvider formProvider = core.FormProvider();


  FormList();

  @override
  _FormListState createState() => _FormListState();
}
/*
class Item extends iCMSForm.Form {
  bool isExpanded = false;
  Item({id, title, description,isExpanded}) : super(id:id, title:title, description:description);

}
*/

class _FormListState extends State<FormList> {

  List<Widget> categoryWidgets = [];
  List<core.FormCategory> categories = [];
  List<core.Form> tasks=[];

  bool categoriesLoaded = false;
  bool tasksLoaded = false;
  core.User? user;

  @override
  void initState(){
    print('initing FormList view state');
    this.loadFormCategories();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("WidgetsBinding");
      if(!categoriesLoaded)
        this.loadFormCategories();
    });
    super.initState();
  }

  Future<void> loadForms(formCategory)
  async {
    print('loadForms called for category '+formCategory.name);
    core.User user = Provider.of<core.UserProvider>(context, listen: false).user;
    Map<String,dynamic> params={
      'status' :'active',
      'accesslevel' : 'read',
      'api_key': user.token ,

    };
    params['category']=formCategory.id.toString();
    print('loadingstatus for Category '+formCategory.loadingStatus.toString());
    if(formCategory.loadingStatus==core.LoadingStatus.idle) {
      formCategory.loadingStatus = core.LoadingStatus.loading;
      dynamic result = await widget.formProvider.loadItems(params);

      setState(() {
        print(result.length.toString() + ' forms found for category ' +
            formCategory.name);
        formCategory.loadingStatus = core.LoadingStatus.ready;
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

    Map<String,dynamic> params={
      'displayinapp' : 'true',
      'api_key': this.user!=null ? this.user!.token :null,
    };
    dynamic result = await widget.formCategoryProvider.loadItems(params);


    print(result.length.toString()+' categories loaded.');
    if(result!=null)
    this.categories = result;
    categoriesLoaded = true;
    if(this.categories.isNotEmpty)
    {
      print(result.toString());
      for(core.FormCategory c in this.categories) {
        print(c.toString());
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
    this.user = Provider.of<core.UserProvider>(context).user;
    for(core.FormCategory c in categories) {
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
            title: Text(AppLocalizations.of(context)!.forms),
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
                        MaterialPageRoute(builder: (context) => DisplayForm(i))
                    );

                  },

                  child: Text(
                    AppLocalizations.of(context)!.choose,
                    style: TextStyle(
                      // fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            )

          ]
      );

  }

  Widget _getTasks(formCategory,user) {
    print('getTasks called for formCategory '+formCategory.name.toString()+' having '+formCategory.forms.length.toString()+' items and loadingStatus '+formCategory.loadingStatus.toString());


    switch (formCategory.loadingStatus) {
      case core.LoadingStatus.ready:

      //data loaded
      // List<iCMSForm.Form> tasks = formCategory.forms;
        if(formCategory.forms.isEmpty)
          return Align(alignment:Alignment.center,
            child:Center(
              child:ListTile(
                leading:Icon(Icons.info),
                title: Text(AppLocalizations.of(context)!.noFormsFound,textAlign: TextAlign.left),
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
          children: formCategory.forms.map<ExpansionPanel>((core.Form form){
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(title:Text(form.title.toString())
                );
              },
              body: ListTile(
                title: Text(form.description.toString()),
                trailing: ElevatedButton(
                  onPressed: () {

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DisplayForm(form))
                    );

                  },

                  child: Text(
                    AppLocalizations.of(context)!.choose,
                    style: TextStyle(
                      // fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
