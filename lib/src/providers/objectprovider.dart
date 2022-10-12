import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:luen/src/objects/badge.dart';
import 'package:luen/src/objects/elearningcourse.dart';
import 'package:luen/src/objects/form.dart' as iCMSForm;
import 'package:luen/src/objects/formcategory.dart';
import 'package:luen/src/objects/formelement.dart';
import 'package:luen/src/objects/keyword.dart';
import 'package:luen/src/objects/message.dart';
import 'package:luen/src/objects/score.dart';
import 'package:luen/src/objects/user.dart';
import 'package:luen/src/objects/libraryitem.dart';
import 'package:luen/src/objects/librarycollection.dart';
import 'package:luen/src/objects/image.dart';
import 'package:luen/src/util/api_client.dart';

abstract class ObjectProvider with ChangeNotifier {
  User? user;
  Future<List<dynamic>> loadItems(params);
  Future<dynamic> getDetails(int itemId,user);
}

class ImageProvider extends ObjectProvider{
  ImageProvider();
  ApiClient _apiClient = ApiClient();

  @override
  Future<List<ImageObject>> loadItems(params) async {
    return _apiClient.loadImages(params);
  }

  @override
  Future<dynamic> getDetails(int imageId, user) {
    return _apiClient.getImageDetails(imageId,user);
  }

}

class LibraryItemProvider extends ObjectProvider {
  LibraryItemProvider();
  ApiClient _apiClient = ApiClient();

  List<Keyword> hashtags = [];
  List<Keyword> themes = [];
  @override
  Future<List<LibraryItem>> loadItems(params) async {
    print('called LibraryItemProvider > loadItems');
    return _apiClient.loadLibraryItems(params);

  }
  Future<List<LibraryItem>> loadCollectionItems(params) async {
    return _apiClient.loadLibraryCollection(params);
  }

// returns json-decoded response
  @override
  Future<dynamic> getDetails(int libraryItemId,user) {
    return _apiClient.getLibraryItemDetails(libraryItemId,user);
  }
  //work in progress
  Future<void> getHashtags([User? loadingUser]) async {

    final Map<String, dynamic> params = {
      'method' : 'json',
      ''

      'api_key': loadingUser!=null ? (loadingUser.token ??'') : this.user?.token ?? '',
    };

    this.hashtags =(await _apiClient.getDataList('keyword',params).then((data) {

      notifyListeners();
      if(data==null) return [];
      //print(data);
      if(data['data']==null) return [];
      return data['data']
          .map<Keyword>((data) => Keyword.fromJson(data))
          .toList();
    }));
  }

  Future<dynamic> addRating(double rating,LibraryItem libraryItem,user){
    final Map<String, dynamic> params = {
      'method' : 'json',
      'action' : 'addrating',
      'objecttype' : 'libraryitem',
     // 'objectid' : libraryItem.id.toString(),
      'userid' :user.id.toString(),
      'libraryitemid' : libraryItem.id.toString(),
      'rating' : rating.toString(),
      'api_key': user.token,
    };

  //  dynamic response = _apiClient.setRating('objectrating',params);
    dynamic response = _apiClient.dispatcherRequest('library', params);
    return response;
  }

}

class KeywordProvider extends ObjectProvider{
  KeywordProvider();
  ApiClient _apiClient = ApiClient();
  @override
  Future<List<Keyword>> loadItems(params) async {

    return _apiClient.loadKeywords(params);

  }
// returns json-decoded response
  @override
  Future<dynamic> getDetails(int id,user) {
    return _apiClient.getKeywordDetails(id,user);
  }
}


class ElearningCourseProvider extends ObjectProvider {
  ElearningCourseProvider();
  ApiClient _apiClient = ApiClient();

  @override
  Future<List<ElearningCourse>> loadItems(params) async {

    return _apiClient.loadCourses(params);

  }
// returns json-decoded response
  @override
  Future<dynamic> getDetails(int courseId,user) {
    return _apiClient.getCourseDetails(courseId,user);
  }
}

class LibraryCollectionProvider extends ObjectProvider {
  LibraryCollectionProvider();
  ApiClient _apiClient = ApiClient();

  @override
  Future<List<LibraryCollection>> loadItems(params) async {

    return _apiClient.loadCollections(params);

  }
// returns json-decoded response
  @override
  Future<dynamic> getDetails(int collectionId,user) {
    return _apiClient.getCollectionDetails(collectionId,user);
  }
}

class BadgeProvider extends ObjectProvider {
  BadgeProvider();

  ApiClient _apiClient = ApiClient();

  @override
  Future<List<Badge>> loadItems(params) async {
    return _apiClient.loadBadges(params);
  }

// returns json-decoded response
  @override
  Future<dynamic> getDetails(int badgeId, user) {
    return _apiClient.getBadgeDetails(badgeId, user);
  }
}

class FormProvider extends ObjectProvider {

  FormProvider();
  List<Message> messages = [];
  ApiClient _apiClient = ApiClient();

  @override
  Future<List<iCMSForm.Form>> loadItems(params) async {

  return _apiClient.loadForms(params);

  }
// returns json-decoded response
  @override
  Future<dynamic> getDetails(int formId,user) {
    return _apiClient.getFormDetails(formId,user);
  }

  Future<void> getMessages([User? loadingUser]) async {

    final Map<String, dynamic> params = {
      'objecttype' : 'formanswerset',
      'method' : 'json',
       'api_key': loadingUser!=null ? (loadingUser.token ??'') : this.user?.token ?? '',
    };

    this.messages =(await _apiClient.loadMessageList(params).then((data) {

      notifyListeners();

      return data;
    }));
  }

}

class FormCategoryProvider extends ObjectProvider {
  FormCategoryProvider();
  ApiClient _apiClient = ApiClient();

  @override
  Future<List<FormCategory>> loadItems(params) async {

    return _apiClient.loadFormCategories(params);

  }
// returns json-decoded response
  @override
  Future<dynamic> getDetails(int id,user) {
    return _apiClient.getFormCategoryDetails(id,user);
  }
}
class FormElementProvider extends ObjectProvider {
  FormElementProvider();
  ApiClient _apiClient = ApiClient();

  @override
  Future<List<FormElement>> loadItems(params) async {

    return _apiClient.loadFormElements(params);

  }
  Future<List<FormElement>> getElements(params) async {

    return _apiClient.getElements(params);

  }
// returns json-decoded response
  @override
  Future<dynamic> getDetails(int id,user) {
    return _apiClient.getFormElementDetails(id,user);
  }

}
class ScoreProvider extends ObjectProvider {
  ScoreProvider();
  ApiClient _apiClient = ApiClient();

  @override
  Future<List<Score>> loadItems(params) async {

    return _apiClient.loadScoreItems(params);

  }
// returns json-decoded response
  @override
  Future<dynamic> getDetails(int id,user) {
    return _apiClient.getScoreDetails(id,user);
  }

}