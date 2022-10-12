import 'package:flutter/foundation.dart';
import 'package:luen/src/objects/badge.dart';
import 'package:luen/src/objects/contactmethod.dart';
import 'package:luen/src/objects/libraryitem.dart';
import 'package:luen/src/objects/elearningcourse.dart';
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/providers/objectprovider.dart' as objectmodel;
import 'package:luen/src/util/api_client.dart';
import 'package:luen/src/util/app_url.dart';
import 'package:luen/src/util/shared_preference.dart';


class UserProvider with ChangeNotifier {
  UserProvider();
  User _user = new User();
  ApiClient _apiClient = ApiClient();

  User get user => _user;
  List<LibraryItem> libraryItems = [];
  List<LibraryItem> get myBooks => libraryItems;
  List<ContactMethod> contacts = [];
  List<ContactMethod> get contactMethods => contacts;
  List<Badge> badges = [];
  List<Badge> get myBadges => badges;
  ElearningCourse? station;

  void setUser(User user) {
    print('setUser called, notifying listeners');
    _user = user;
    notifyListeners();
  }
  void setUserSilent(User user) {
    _user = user;
  }

  void clearUser(){
    _user = new User();
    libraryItems = [];
    contacts = [];
    badges = [];
    notifyListeners();
  }

  Future<dynamic> getDetails(int userId,user){
    return _apiClient.getDetails('iuser',userId,user);
  }

  Future<void> refreshUser({String? fields}) async {

    print('refreshing user information from server');
    try {

      User u = this.user;
      dynamic userData =
          await this.getDetails(u.id!, this._user);
     

      // keep token
      userData = userData['data'];
     // userData['access_token'] = u.token;
     // userData['renewal_token'] = u.renewaltoken;
       print('user score: '+userData['availablescore'].toString());
          u = u.copyWith(
            firstname: userData['firstname'],
            lastname: userData['lastname'],
            email: userData['email'],
            phone: userData['phone'],
            type: userData['type'],
            token: userData['access_token'],
            renewaltoken: userData['renewal_token'],
            qrcode: userData['qrcode'],
            image: userData['image'],
            awardedscore: userData['awardedscore'],
            availablescore : userData['availablescore'],
            themesofbooksread : userData['themesofbooksread'],
            currentstation: userData['currentstation'] is String ? {'objectid':userData['currentstation']} : userData['currentstation'],

          );
          this.setUser(u);
          UserPreferences().saveUser(u);
          //Update badgelist and booklist
        this.getBadgeList();
        this.getBookList();
    } catch (e, stack) {

      print(
          'refreshing user information returned error $e\n Stack trace:\n $stack');

    }

  }
  /*
  Accept book as read
   */
  Future<dynamic> acceptBook(LibraryItem libraryItem) async{


    print('accepting book '+libraryItem.id.toString());
    if(libraryItem.id==null) {
      print('no item selected. cannot add.');
      return false;
    }
    final Map<String, String> params = {
      'action' :'acceptbook',
      'libraryitemid' : libraryItem.id.toString(),
      'api-key':this._user.token!,
      'api_key':this._user.token!,

    };
    var result = await _apiClient.dispatcherRequest('library',params);
    print(result);
    this.refreshUser(fields:'awardedscore,availablescore');
    this.getBookList();
    this.getBadgeList();
    notifyListeners();
    return result;
  }
  /*
  Add book to reading list
   */
  Future<dynamic> readBook(LibraryItem libraryItem) async{


    print('reading book '+libraryItem.id.toString());
    if(libraryItem.id==null) {
      print('no item selected. cannot add.');
      return false;
    }
    final Map<String, String> params = {
      'action' :'read',
      'libraryitemid' : libraryItem.id.toString(),
      'api-key':this._user.token!,
      'api_key':this._user.token!,

    };
    var result = await _apiClient.dispatcherRequest('library',params);
    getBookList();
    getBadgeList();
    //notifyListeners();
    return result;
  }
  /*
  Remove book from reading list
   */
  Future<dynamic> returnBook(LibraryItem libraryItem) async{

    final Map<String, String> params = {
      'action' :'return',
      'libraryitemid' : libraryItem.id.toString(),
      'api-key':this._user.token!,
      'api_key':this._user.token!,

    };
    var result = await _apiClient.dispatcherRequest('library',params);
    this.getBookList();
    this.getBadgeList();
    //notifyListeners();
    return result;
  }
  /*
  * get current available score for user
   */

  /*
  Change Station
   */
  Future<dynamic> setStation(ElearningCourse station) async{

    final Map<String, String> params = {
      'action' :'setstation',
      'elearningcourseid' : station.id.toString(),
      'api-key':this._user.token!,
      'api_key':this._user.token!,
    };
    var result = await _apiClient.dispatcherRequest('library',params);
    this.station = station;
    this.refreshUser();

        return result;
  }
  Future<void> setLine(int line) async{
    this.user.currentline = line;
    UserPreferences().saveUser(this.user);
  }
  Future<Map<String,dynamic>> stationStatus(ElearningCourse station) async{
    if(station.id==null) {
      print('station id not set, cannot get open status');
      return {};
    }
    final Map<String, String> params = {
      'action' :'stationisopened',
      'elearningcourseid' : station.id.toString(),
      'api-key':this._user.token!,
      'api_key':this._user.token!,
    };
    var result = await _apiClient.dispatcherRequest('library',params);

    return result != null ? result : {};
  }
  Future<void> getBadgeList()
  async {
    if(this._user.id==null) return;
    print('loading awarded badges list for user');
    final objectmodel.BadgeProvider provider =
    objectmodel.BadgeProvider();
    final Map<String, String> params = {
      'users':this._user.id!.toString(),
      'application' : 'id='+AppUrl.appId.toString(),
      //'limit' : limit.toString(),
      //'offset' : offset.toString(),
      'fields' : 'id,name,color,badgeimageurl,description,badgeimageurl,requiredbookcount,assertionBakedBadgeImageUrl,assertionCertificateAsPdfUrl',
      'api-key':this.user.token!,
      'api_key':this.user.token!,
      'sort' : 'title',
    };
    this.badges = (await provider.loadItems(params)).cast<Badge>();
    print(this.badges.length.toString()+ 'badges were found for user. ');
    notifyListeners();
  }
  Future<void> getBookList()
  async {
    if(this._user.id==null) return;
    print('loading books list for user');
    final objectmodel.LibraryItemProvider provider =
    objectmodel.LibraryItemProvider();
    final Map<String, String> params = {
      'users':this._user.id!.toString(),

      //'limit' : limit.toString(),
      //'offset' : offset.toString(),
      'fields' : 'id,title,introduction,youtubelink,videoid,description,author,authors,coverpictureurl,level,identifier,readstatus,readlistdate,hashtags,themes,objectrating,objectratingcount,userrating,pagecount',
      'api-key':this.user.token!,
      'api_key':this.user.token!,
      'sort' : 'readlistdate DESC,title',
    };
    this.libraryItems = (await provider.loadItems(params)).cast<LibraryItem>();
    print(this.libraryItems.length.toString()+' read books found for user');
    notifyListeners();
  }

  Future<void> getScoreList()
  async{
    if(this._user.id==null) return;
    print('loading score list for user');
    final objectmodel.ScoreProvider provider =
    objectmodel.ScoreProvider();
    final Map<String, String> params = {
      'users':this._user.id!.toString(),

      //'limit' : limit.toString(),
      //'offset' : offset.toString(),
      'fields' : 'id,title,introduction,youtubelink,videoid,description,author,authors,coverpictureurl,level,identifier,readstatus,readlistdate,hashtags,themes,objectrating,objectratingcount,userrating,pagecount',
      'api-key':this.user.token!,
      'api_key':this.user.token!,
      'sort' : 'readlistdate DESC,title',
    };
    this.libraryItems = (await provider.loadItems(params)).cast<LibraryItem>();
    print(this.libraryItems.length.toString()+' read books found for user');
    notifyListeners();
  }

  Future<void> getContactMethods() async {
    print('getContactMethods called for user provider');
    if(this.user.id==null) return;

    final Map<String, dynamic> params = {
      'method' : 'json',
      'action': 'getcontactmethods',
      'userid': this.user.id!.toString(),

      'api_key':this.user.token,
    };
    this.contacts =(await _apiClient.dispatcherRequest('registration',params).then((data) {

      // return _getJson(url).then((json) => json['data']).then((data) {
      if(data==null) return [];
      print(data);
      return data['data']
          .map<ContactMethod>((data) => ContactMethod.fromJson(data))
          .toList();
    }));
  }

}