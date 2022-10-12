
class Badge {
  int? id;
  String? name;
  String? description;
  String? badgeimageurl;
  String? assertionBakedBadgeImageUrl;
  String? assertionCertificateAsPdfUrl;
  String? color;
  int? requiredBookCount;
  //String? icon;
  int accessLevel;


  Badge({
    this.id,
    this.name,
    this.description,
    this.color,
    this.badgeimageurl,
    this.requiredBookCount,
    this.accessLevel=0,
    this.assertionBakedBadgeImageUrl,
    this.assertionCertificateAsPdfUrl
  });



  factory Badge.fromJson(Map<String, dynamic> response) {

    Map<String, dynamic> responseData =  response['data'];
    int accessLevel = responseData['accesslevel'] is int  ? responseData['accesslevel'] : int.parse(responseData['accesslevel']);
    //print(responseData['requiredbookcount'].runtimeType);
    //print('baked badge url: '+responseData['assertionbakedbadgeimageurl'].toString());
    return Badge(
        id: responseData['objectid'] !=null ? int.parse(responseData['objectid']) : null,
        name: responseData['name'],
        description: responseData['description'],
        badgeimageurl:responseData['badgeimageurl'],
        color: responseData['color'] != null && responseData['color'].length>0 ? responseData['color'] : '#000000',
        requiredBookCount: responseData['requiredbookcount'] !=null && responseData['requiredbookcount'].length>0 ? int.parse(responseData['requiredbookcount']) : null,
        accessLevel:  accessLevel,
        assertionBakedBadgeImageUrl: responseData['assertionBakedBadgeImageUrl'],
        assertionCertificateAsPdfUrl: responseData['assertionCertificateAsPdfUrl']

    );
  }

  Map toJson() => {
    'id' : id,
    'name' : name,
    'description' : description,
    'color' : color,
    'badgeimageurl' : badgeimageurl,
    'requiredbookcount' : requiredBookCount,

  };
}

