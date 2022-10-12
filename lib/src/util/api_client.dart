import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:luen/src/objects/contactmethod.dart';
import 'package:luen/src/objects/form.dart' as iCMSForm;
import 'package:luen/src/objects/formcategory.dart';
import 'package:luen/src/objects/formelement.dart';
import 'package:luen/src/objects/keyword.dart';
import 'package:luen/src/objects/librarycollection.dart';
import 'package:luen/src/objects/libraryitem.dart';
import 'package:luen/src/objects/message.dart';
import 'package:luen/src/objects/score.dart';
import 'package:luen/src/objects/webpage.dart';
import 'package:luen/src/util/app_url.dart';
import 'package:luen/src/objects/elearningcourse.dart';
import 'package:luen/src/objects/badge.dart';
import 'package:luen/src/objects/image.dart';
import 'package:luen/src/objects/user.dart';
import 'package:package_info/package_info.dart';

class ApiClient {

  static final _client = ApiClient._internal();
  //final _http = HttpClient();
  ApiClient._internal();

  final String baseUrl = AppUrl.baseURL;
  final int appId = AppUrl.appId;
  factory ApiClient() => _client;

  /*
  * _postJson handles POST request and returns the json decoded data from server back to caller function
  */
  Future<dynamic> _postJson(Uri uri, Map<String, dynamic> data,{requestType='POST'}) async
  {

    Map softwareInfo = {
      'appName': '',
      'packageName':'',
      'version':'',
      'buildNumber' :'',

    };
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      softwareInfo['appName'] = packageInfo.appName;
      softwareInfo['packageName'] = packageInfo.packageName;
      softwareInfo['version'] = packageInfo.version;
      softwareInfo['buildNumber'] = packageInfo.buildNumber;
    });
    Map<String,String> headers= {
      'Content-Type': 'application/json',
      'User-Agent': softwareInfo['appName']+' / '+softwareInfo['version']+' '+softwareInfo['buildNumber']
    };
    var request = new http.MultipartRequest(requestType, uri);
    headers.forEach((k,v){ request.headers[k]=v;});

    print('POSTing dat as MultipartRequest:');
    data.forEach((key, value) async {
          if (value is File) {
            print('adding file '+key);
            request.files.add(await http.MultipartFile.fromPath(key, value.path));
          }
          else {
            print('adding $key = $value');
            request.fields[key] = json.encode(value);
          }
    });
   // request.fields['appid'] = appId.toString();
    print('calling (post) '+uri.toString());
    http.Response response = await http.Response.fromStream(await request.send());
    //var response = await request.send();

    /*
    var response = await http.post(uri,
      body: json.encode(data),
      headers: headers,
    );

     */
    if (response.statusCode == 200) {
     // print(response.toString());
      //  print(response.headers.toString());
      if(response.body.isNotEmpty) {
        //print('RESPONSE');
        //print(response.body);
        try {
          Map<String, dynamic> responseData = json.decode(response.body);
          //debug
          //print(responseData);
          return responseData;
        }
        catch(e) {
          print(e.toString());
        }

      }
      else{
        print('response body was empty');
        return false;
      }

    }
    else{
     // print('statuscode: '+response.statusCode.toString());
      if(response.body.isNotEmpty) {
        print(response.body);
        Map<String, dynamic> responseData = json.decode(response.body);
        //debug

        return(responseData);
      }
      return false;
    }

  }

  /*
  * _getJson handles request and returns the json decoded data from server back to caller function
  */
  Future<dynamic> _getJson(Uri uri) async {
    //print('calling (get) '+uri.toString());
    Map softwareInfo = {
      'appName': '',
      'packageName':'',
      'version':'',
      'buildNumber' :'',

    };
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      softwareInfo['appName'] = packageInfo.appName;
      softwareInfo['packageName'] = packageInfo.packageName;
      softwareInfo['version'] = packageInfo.version;
      softwareInfo['buildNumber'] = packageInfo.buildNumber;
    });
    Map<String,String> headers= {
      'User-Agent': softwareInfo['appName']+' / '+softwareInfo['version']+' '+softwareInfo['buildNumber']
    };
    var response = await http.get(uri,headers:headers);
    //print(response.statusCode);
    if(response.statusCode==200) {
      if(response.body.isNotEmpty) {
     //  print(response.body);
        Map<String, dynamic> body = json.decode(response.body);
       /* if(body['query']!=null)
          print('_getJson - Query executed on server: ' + body['query']);
        else print('Server did not respond with query information');
*/
         /* print('GETJSON DATA RECEIVED:');
          body.forEach((key, value) {
            //if (key != 'data')
              print('$key = $value');
          });
          print('END GETJSON');
          */


          return (body);

      }
      else {
        print('response body was empty.');
        return false;
      }
    }
    else return false;

  }



    /*
    * Request verificationcode / confirmation key from server
    */
    Future<Map<String, dynamic>> getConfirmationKey(String contactAddress) async {
     // print( 'requesting getverificationcode for '+email);
      final Map<String, dynamic> params = {
        'method' : 'json',
        'action': 'getverificationcode',
        'email': contactAddress
      };
      var url = Uri.https(AppUrl.baseURL, AppUrl.requestValidationToken,params);
      return _getJson(url).then((json){
        return json;
      });
  }

  /*
  * Send the received confirmation key, entered by user, back to server
  * on success returns singlepass for changing user password
  */
  Future<Map<String, dynamic>> sendConfirmationKey({contact,code,userid}) async {
    final Map<String, dynamic> params = {
      'method' : 'json',
      'action': 'verify',
      'field': contact,
      'contactmethodid': contact,
      'userid' : userid,
      'code': code
    };
    var url = Uri.https(AppUrl.baseURL, AppUrl.checkValidationToken,params);
    //   var response = _getJson(url) as Map<String, dynamic>;

    return _getJson(url).then((json){
     // print(json);
      return json;
    });
  }

  /* Send user registration information (register.dart) to server
  * Required data: first name, last name, email or phone, password.
  * On success, returns user object.
  * returns status (success / error) + possible related message from server
   */
  Future<Map<String, dynamic>>? register({required String firstname, required String lastname,String? phone,String? email, required String password, String? passwordConfirmation,String? registrationCode,String? guardianName,String? guardianPhone}) async {

    final Map<String, dynamic> registrationData = {
      'user': {
        'firstname' : firstname,
        'lastname' : lastname,
        'phone': phone ?? false,
        'email': email,
        'password': password,
        'guardianname' : guardianName ?? false,
        'guardianphone' : guardianPhone ?? false
       // 'password_confirmation': passwordConfirmation ?? false
      },
      'registrationcode' : registrationCode ?? false
    };
    var url = Uri.https(AppUrl.baseURL,AppUrl.registration);

    return _postJson(url,registrationData).then((json){
       //print(json);
      return json!=null ? json : false;
    });
  }

  /*
  * Send new password and required singlepass to authorize password change to server
   */
  Future<Map<String, dynamic>> changePassword({password,userid,singlepass}) async {

    final Map<String, dynamic> params = {
      'method' : 'json',
      'action': 'setpassword',
      'singlepass':singlepass,
      'userid' : userid,
      'password': password,
      'verification' : password
    };
   //params.forEach((key, value) {print('$key = $value');});
    var url = Uri.https(AppUrl.baseURL, AppUrl.checkValidationToken,params);
    //   var response = _getJson(url) as Map<String, dynamic>;
    return _getJson(url).then((json){
      return json;

    });

  }
  /*
  * Join usergroup based on joincode
   */
  Future<Map<String, dynamic>> joinGroup(String joincode,User loggedInUser) async {

    final Map<String, dynamic> params = {
      'method' : 'json',
      'action': 'joingroup',
      'joincode':joincode,
      'api-key': loggedInUser.token,
      'api_key':loggedInUser.token,
      'appid':appId.toString()
    };
    var url = Uri.https(baseUrl,'api/dispatcher/registration/',params);

    return _getJson(url).then((json){
    //  print(json);
      return json!=null ? json : false;
    });
  }

  /*
  * Join usergroup based on joincode
   */
  Future<Map<String, dynamic>> deleteUserAccount(User loggedInUser) async {

    final Map<String, dynamic> params = {
      'method' : 'json',
      'action': 'deleteownuseraccount',
      'api-key': loggedInUser.token,
      'api_key':loggedInUser.token,
      'appid':appId.toString()
    };
    var url = Uri.https(baseUrl,'api/dispatcher/registration/',params);

    return _getJson(url).then((json){
   //   print(json);
      return json!=null ? json : false;
    });
  }

  Future<dynamic> dispatcherRequest(String targetModule,Map<String,dynamic> params) async {
    params['method'] ='json';
   // params['appid'] =appId;
    var url = Uri.https(baseUrl, 'api/dispatcher/$targetModule/', params);

    return _getJson(url).then((data)  {
    //  print(data);
      return data;
    });

  }

  Future<dynamic> getDetails(String objectType,int objectId,User loggedInUser,{fields}) async{
    var idString = objectId.toString();
    var url = Uri.https(baseUrl, 'api/$objectType/$idString', { 'method' :'json', 'api-key': loggedInUser.token,'api_key':loggedInUser.token,'appid':appId.toString()});

    return _getJson(url).then((json) => json['data']).then((data) {
    //print(data);

      return data!=null && data.isNotEmpty? data.first : null;
    });
  }

  Future<dynamic> getDataList(String datatype,Map<String,dynamic> params) async {
    params['method'] = 'json';

    var url = Uri.https(baseUrl, 'api/$datatype/', params);
  //  print(url.toString());
    return _getJson(url).then((json) {
      if(json==false) return [];
    //  print(json);
      return(json['data']?? []);

    });

  }
  Future<Map<String, dynamic>>? saveFormData(Map<String,dynamic> params, Map<String,dynamic> data) async {


    var url = Uri.https(baseUrl,'api/dispatcher/forms/',params);

    return _postJson(url,data).then((json) {
  //    print(json);
      return json!=null ? json : false;
    });
  }
  Future<Map<String, dynamic>>? loadFormData(Map<String,dynamic> params) async {


    var url = Uri.https(baseUrl,'api/dispatcher/forms/',params);

    return _getJson(url).then((json){
      //print(json);
      return json!=null ? json : false;
    });
  }
  Future<Map<String, dynamic>>? setRating(String objecttype,Map<String,dynamic> data,{requestType:'PUT'}) async {

    var url = Uri.https(baseUrl,'api/$objecttype/');

    return _postJson(url,data).then((json){
   //   print(json);
      return json!=null && json!=false ? json : {};
    });
  }

  /*
    * Get user contactmethods from server
    */
  Future<List<ContactMethod>> getContactMethods(User user) async {


    final Map<String, dynamic> params = {
      'method' : 'json',
      'action': 'getcontactmethods',
      'userid': user.id.toString(),
      'api-key':user.token,
      'api_key':user.token,
    };
    return this.dispatcherRequest('registration',params).then((data) {

   // return _getJson(url).then((json) => json['data']).then((data) {
      if(data==null) return [];
      return data
          .map<ContactMethod>((data) => ContactMethod.fromJson(data))
          .toList();
    });
  }
/*
* Load list of Badges
 */

  Future<List<Badge>> loadBadges(Map<String,dynamic> params) async{
    //params['appid'] =appId;
    return getDataList('badge',params).then((data) {
      if (data == null) return [];
      return data
          .map<Badge>((data) => Badge.fromJson(data))
          .toList();
    });
  }

  /*
  * Load detailed activity information for selected badge
   */
  Future<dynamic> getBadgeDetails(int id, User user) async {

    return this.getDetails('badge',id,user);

  }
/*
  * Load list of FormCategoriess
  */

  Future<List<FormCategory>> loadFormCategories(Map<String,dynamic> params) async{
  //  params['appid'] =appId;
    return getDataList('formcategory',params).then((data) {
      if (data == null) return [];
      return data
          .map<FormCategory>((data) => FormCategory.fromJson(data))
          .toList();
    });
  }

  /*
  * Load detailed activity information for selected form
   */
  Future<dynamic> getFormCategoryDetails(int id, User user) async {

    return this.getDetails('formcategory',id,user);

  }
  /*
  * Load list of Forms
  */

  Future<List<iCMSForm.Form>> loadForms(Map<String,dynamic> params) async{
    //params['appid'] =appId;
    return getDataList('form',params).then((data) {
      if (data == null) return [];
      return data
          .map<iCMSForm.Form>((data) => iCMSForm.Form.fromJson(data))
          .toList();
    });
  }

  /*
  * Load detailed activity information for selected form
   */
  Future<dynamic> getFormDetails(int id, User user) async {
    return this.getDetails('form',id,user);
  }

  /*
  * Load list of Forms
  */

  Future<List<FormElement>> loadFormElements(Map<String,dynamic> params) async{

    return getDataList('formelement',params).then((data) {
      if (data == null) return [];
      return data
          .map<Form>((data) => iCMSForm.Form.fromJson(data))
          .toList();
    });
  }

  /*
  * Load detailed activity information for selected form
   */
  Future<dynamic> getFormElementDetails(int id, User user) async {

    return this.getDetails('formelement',id,user);

  }
/*
  * Load list of elements of selected form
   */
  Future<List<FormElement>> getElements(Map<String,dynamic> params) async {
    params['action'] = 'getelements';

    return this.dispatcherRequest('forms',params).then((data) {
      if(data==null) return [];
      if(data['items']==null){
        return [];
      }
      return data['items']
          .map<FormElement>((data) => FormElement.fromJson(data))
          .toList();
    });
  }
  /*
  * Load list of libraryitems
   */
  Future<List<LibraryItem>> loadLibraryItems(Map<String,dynamic> params) async {
   // params['appid'] =appId;
    return getDataList('libraryitem',params).then((data) {

      if (data == null) return [];
      return data
          .map<LibraryItem>((data) => LibraryItem.fromJson(data))
          .toList();
    });
  }

  Future<List<LibraryItem>> loadLibraryItemsList(Map<String,dynamic> params) async {

      return this.dispatcherRequest('library',params).then((data) {

        if(data==null || data ==false || data['data']==null) return [];
        return data['data']
            .map<LibraryItem>((data) => LibraryItem.fromJson(data))
            .toList();
      });


  }

/*
  * Load list of libraryitems
   */
    Future<List<LibraryItem>> loadLibraryCollection(Map<String,dynamic> params) async {
      return getDataList('libraryitem', params).then((data){
        if(data==null) return [];
        return data
            .map<LibraryItem>((data) => LibraryItem.fromJson(data))
            .toList();
      });
      /* ALTERNATIVE approach by querying dispatcherrequest.
      issue with loading related objects (hashtags and themes)
      return this.dispatcherRequest('library',params).then((data) {
        if(data==null) return [];
        return data['data']
            .map<LibraryItem>((data) => LibraryItem.fromJson(data))
            .toList();
      });

       */
    }

  /*
  * Load list of gameboard steps (elearning courses)
   */
  Future<List<ElearningCourse>> loadCourses(Map<String,dynamic> params) async {

    return getDataList('elearningcourse',params).then((data) {
      if(data==null) return [];
      return data
          .map<ElearningCourse>((data) => ElearningCourse.fromJson(data))
          .toList();
    });

  }
  /*
  * Load list of libraryitem collections
   */
  Future<List<LibraryCollection>> loadCollections(Map<String,dynamic> params) async {
    //debug: print params
    //params.forEach((key, value) {print('$key = $value');});

    return getDataList('librarycollection',params).then((data) {
      if(data==null) return [];
      return data
          .map<LibraryCollection>((data) => LibraryCollection.fromJson(data))
          .toList();
    });

  }
/*
  * Load list of score items
   */
  Future<List<Score>> loadScoreItems(Map<String,dynamic> params) async {

    return getDataList('score',params).then((data) {
      if(data==null) return [];
      return data
          .map<Score>((data) => Score.fromJson(data))
          .toList();
    });

  }
/*
  * Load list of keywords
   */
  Future<List<Keyword>> loadKeywords(Map<String,dynamic> params) async {

    return getDataList('keyword',params).then((data) {
      if(data==null) return [];
      return data
          .map<Keyword>((data) => Keyword.fromJson(data))
          .toList();
    });

  }
  /*
  * Load detailed libraryitem information
   */
  Future<dynamic> getCourseDetails(int courseId, User user) async {
    return this.getDetails('elearningcourse',courseId,user);
  }

  /*
  * Load detailed librarycollection information
   */
  Future<dynamic> getCollectionDetails(int collectionId, User user) async {
    return this.getDetails('librarycollection',collectionId,user);
  }

  /*
  * Load detailed libraryitem information
   */
  Future<dynamic> getLibraryItemDetails(int libraryItemId, User user) async {
    return this.getDetails('libraryitem',libraryItemId,user);

  }
/*
  * Load detailed score information
   */
  Future<dynamic> getScoreDetails(int id, User user) async {
    return this.getDetails('score',id,user);

  }
  /*
  * Load detailed keyword information
   */
  Future<dynamic> getKeywordDetails(int id, User user) async {
    return this.getDetails('keyword',id,user);

  }
/*
  * Load list of images
   */
  Future<List<ImageObject>> loadImages(Map<String,dynamic> params) async {
    return getDataList('image',params).then((data) {
      if(data==null) return [];
      return data
          .map<Image>((data) => ImageObject.fromJson(data))
          .toList();
    });

  }
  /*
  * Get image details based on image id
   */
  Future<dynamic> getImageDetails(int imageId, User user) async {
    return this.getDetails('image',imageId,user);
  }
  Future<Map<String, dynamic>>? sendFeedback(Map<String,dynamic> params, Map<String,dynamic> data) async {
    String baseUrl = AppUrl.baseURL;//await Settings().getServer();
    params['get_page']='common';
    var url = Uri.https(baseUrl,'api/dispatcher/common/',params);

    return _postJson(url,data).then((json){
    //  print(json);
      return json!=null ? json : false;
    });
  }

  /*
  * Load list of pages
   */
  Future<List<WebPage>> loadPages(Map<String,dynamic> params) async {

    return getDataList('page',params).then((data) {
    //  print(data);
      if(data==null) return [];
      print(data);
      return data
          .map<WebPage>((data) => WebPage.fromJson(data))
          .toList();
    });

  }
  Future<dynamic> getPageDetails(int id, User user) async {
    return this.getDetails('page',id,user);
  }

  Future<List<Message>> loadMessageList(Map<String,dynamic> params) async {
    params['action'] = 'getmessages';
    return this.dispatcherRequest('library',params).then((data) {

      if(data==null || data ==false || data['data']==null) return [];
      return data['data']
          .map<Message>((data) => Message.fromJson(data))
          .toList();
    });


  }
}
