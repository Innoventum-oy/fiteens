
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class User {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  String? type;
  String? token;
  String? renewaltoken;
  String? image;
  String? qrcode;
  int? awardedscore;
  int? availablescore;
  Map<String,dynamic>? currentstation;
  int? currentline;
  Map<String,dynamic>? data;
  List<dynamic>? themesofbooksread;
  bool loginPopupDisplayed = false;

  factory User.fromJson(Map<String, dynamic> responseData) {
    //print("Current station for user: "+responseData['currentstation']['objectid'].toString());

    return User(
      id: responseData['id'] is int ? responseData['id'] : int.parse(responseData['id']),
      firstname: responseData['firstname'],
      lastname: responseData['lastname'],
      email: responseData['email'],
      phone: responseData['phone'],
      type: responseData['type'],
      token: responseData['access_token']??responseData['token'],
      renewaltoken: responseData['renewal_token'],
      qrcode: responseData['qrcode'],
      image: responseData['image'],
      awardedscore:   (responseData['awardedscore']  != null )? responseData['awardedscore'] :  0,
      availablescore: responseData['availablescore']!=null ?  (responseData['availablescore']  is int ? responseData['availablescore'] : int.parse(responseData['availablescore'])) : 0,
      currentstation: (responseData['currentstation'] is String || responseData['currentstation'] is int ) ? {'objectid': (responseData['currentstation'])} : responseData['currentstation'],
      themesofbooksread : responseData['themesofbooksread'],
      data: responseData,
    );

  }
  int? getCurrentStation()
  {
    if(this.currentstation != null)
      if (this.currentstation!.isNotEmpty) {
        // print('returning station '+this.currentstation!["objectid"]);
        return this.currentstation!["objectid"] is int? this.currentstation!["objectid"] : this.currentstation!["objectid"] is String?  int.parse(this.currentstation!["objectid"]): null;
      }
    return null;
  }
  Map<String, dynamic> toJson() => {
    'id': id.toString(),
    'firstname': firstname,
    'lastname': lastname,
    'email': email,
    'phone': phone,
    'type': type,
    'token': token,
    'image': image,
    'qrcode': qrcode,
    'awardedscore' : awardedscore,
    'availablescore' : availablescore,
    'renewaltoken': renewaltoken,
    'currentstation': currentstation,
    'currentline' : currentline,
    'themesofbooksread' : themesofbooksread,
    'data' : data,
  };

//<editor-fold desc="Data Methods">

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.type,
    this.token,
    this.renewaltoken,
    this.image,
    this.qrcode,
    this.awardedscore,
    this.availablescore,
    this.currentstation,
    this.currentline,
    this.themesofbooksread,
    this.data,
    this.loginPopupDisplayed = false
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          firstname == other.firstname &&
          lastname == other.lastname &&
          email == other.email &&
          phone == other.phone &&
          type == other.type &&
          token == other.token &&
          renewaltoken == other.renewaltoken &&
          image == other.image &&
          qrcode == other.qrcode &&
          awardedscore == other.awardedscore &&
          availablescore == other.availablescore &&
          currentstation == other.currentstation);

  @override
  int get hashCode =>
      id.hashCode ^
      firstname.hashCode ^
      lastname.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      type.hashCode ^
      token.hashCode ^
      renewaltoken.hashCode ^
      image.hashCode ^
      qrcode.hashCode ^
      awardedscore.hashCode ^
      availablescore.hashCode ^
      currentstation.hashCode ^
      currentline.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' id: $id,' +
        ' firstname: $firstname,' +
        ' lastname: $lastname,' +
        ' email: $email,' +
        ' phone: $phone,' +
        ' type: $type,' +
        ' token: $token,' +
        ' renewaltoken: $renewaltoken,' +
        ' image: $image,' +
        ' qrcode: $qrcode,' +
        ' awardedscore: $awardedscore,' +
        ' availablescore: $availablescore,' +
        ' currentstation: $currentstation,' +
        ' currentline: $currentline,' +
        ' themesofbooksread: $themesofbooksread'+
        '}';
  }

  User copyWith({
    int? id,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? type,
    String? token,
    String? renewaltoken,
    String? image,
    String? qrcode,
    int? awardedscore,
    int? availablescore,
    Map<String, dynamic>? currentstation,
    Map<String,dynamic>? data, themesofbooksread,

  }) {
    return User(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      type: type ?? this.type,
      token: token ?? this.token,
      renewaltoken: renewaltoken ?? this.renewaltoken,
      image: image ?? this.image,
      qrcode: qrcode ?? this.qrcode,
      awardedscore:  awardedscore ?? this.awardedscore,
      availablescore: availablescore ?? this.availablescore,
      currentstation: currentstation ?? this.currentstation,
      currentline: currentline ?? this.currentline,
      themesofbooksread: themesofbooksread ?? this.themesofbooksread,
      loginPopupDisplayed: this.loginPopupDisplayed,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'firstname': this.firstname,
      'lastname': this.lastname,
      'email': this.email,
      'phone': this.phone,
      'type': this.type,
      'token': this.token,
      'renewaltoken': this.renewaltoken,
      'image': this.image,
      'qrcode': this.qrcode,
      'awardedscore': this.awardedscore,
      'availablescore': this.availablescore,
      'currentstation': this.currentstation,
      'currentline' : this.currentline,
      'themesofbooksread' :this.themesofbooksread,
      'data': this.data,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      firstname: map['firstname'] as String,
      lastname: map['lastname'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      type: map['type'] as String,
      token: map['token'] as String,
      renewaltoken: map['renewaltoken'] as String,
      image: map['image'] as String,
      qrcode: map['qrcode'] as String,
      awardedscore: map['awardedscore'] as int,
      availablescore: map['availablescore'] as int,
      currentstation: map['currentstation'] as Map<String, dynamic>,
      currentline: map['currentline'] as int,
      themesofbooksread: map['themesofbooksread'] as List<Map<String,dynamic>>,
      data : map['data'] as Map<String, dynamic>,
    );
  }

//</editor-fold>
}

