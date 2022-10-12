
class Keyword {
  int? id;
  String? keyword;
  String? favoritestitle;
  String? icon;
  int? unicodeicon;
  String? colour;
  int accessLevel;


  Keyword({
    this.id,
    this.keyword,
    this.favoritestitle,
    this.colour,
    this.icon,
    this.unicodeicon,
    this.accessLevel=0,

  });



  factory Keyword.fromJson(Map<String, dynamic> response) {

    Map<String, dynamic> responseData =  response['data'];
    int accessLevel = responseData['accesslevel'] is int  ? responseData['accesslevel'] : int.parse(responseData['accesslevel']);
    String? icon = responseData['unicodeicon'];
    return Keyword(
      id: responseData['objectid'] !=null ? int.parse(responseData['objectid']) : null,
      keyword: responseData['keyword'],
      favoritestitle: responseData['favoritestitle'] ?? responseData['keyword'],
      icon:responseData['icon'],
      unicodeicon:icon!=null && icon!='' ? int.parse('0x$icon') : null,
      colour: responseData['colour'].length>0 ? responseData['colour'] : null,
      accessLevel:  accessLevel,
    );
  }

  Map toJson() => {
    'id' : id,
    'keyword' : keyword,
    'favoritestitle' : favoritestitle,
    'colour' : colour,
    'icon' : icon,
  };
}

