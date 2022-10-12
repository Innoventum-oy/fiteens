import 'package:luen/src/objects/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:luen/src/util/local_storage.dart';
import 'package:luen/src/util/app_url.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class EventLog{
  Future<bool> saveMessage(String message) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentContent = (prefs.getStringList('eventlog') ?? <String>[]);
    currentContent.add(message);
    prefs.setStringList('eventlog',currentContent);
    return true;
  }

  void clearLog() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("eventlog");

  }

  Future<List<String>?> getMessages() async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('eventlog');
  }

}
class UserPreferences {
  final filename = "local_user";

  Future<bool> saveUser(User user) async {
    return FileStorage.write(user, this.filename);
  }

  Future<User> getUser() async {
    final userdata = await FileStorage.read(this.filename);
   // print('USERDATA from UserPreferences:');
   // print(userdata);
    return(userdata!=false ? User.fromJson(userdata) : User());
  }

  void removeUser() async {
    FileStorage.delete(this.filename);

  }
  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token").toString();
    return token;
  }
}

class Settings{

  Future<String> getLanguage() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String systemLocale = Intl.getCurrentLocale();

    String language = prefs.getString('language') ?? systemLocale ;

    return language ;
  }
  Future<String> getServer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = prefs.getString('server') ?? AppUrl.servers.values.first ;

    return server ;
  }
  Future<String> getServerName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String server = prefs.getString('servername') ?? AppUrl.servers.keys.first ;

    return server  ;
  }
  Future<String> getValue(arg) async {
    print('retrieving '+arg);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(arg).toString() ;
    return token;
  }
  Future<bool> setValue(String arg,dynamic val) async {
    print('storing '+arg+':'+val);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(arg,val);
    return true;
  }
}