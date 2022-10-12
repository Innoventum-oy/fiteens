
class LibraryItem {
  int? id;
  String? title;
  String? description;
  String? introduction;
  String? authorname;
  String? authors;
  String? level;
  String? identifier;
  String? coverpicture;
  String? coverpictureurl;
  String? videoUrl;
  String? videoId;
  String ? icon;
  double? objectrating;
  double? userrating;
  int? objectratingcount;
  int? readcount;
  int? pagecount;
  int score;
  String readstatus;
  int accesslevel;
  List<dynamic>? hashtags;
  List<dynamic>? themes;
  DateTime? readlistdate;

  LibraryItem({
    this.authorname,
    this.authors,
    this.id,
    this.title,
    this.description,
    this.introduction,
    this.level,
    this.identifier,
    this.coverpicture,
    this.coverpictureurl,
    this.icon,
    this.videoUrl,
    this.videoId,
    this.objectrating,
    this.userrating,
    this.objectratingcount :0,
    this.readcount: 0,
    this.pagecount : 0,
    this.score : 0,
    this.readstatus : 'none',
    this.accesslevel: 0,
    this.hashtags,
    this.themes,
    this.readlistdate
  });



  factory LibraryItem.fromJson(Map<String, dynamic> response) {

    Map<String, dynamic> responseData = response['data'] ?? response;
    int? objectId = responseData['objectid'] !=null ? int.parse(responseData['objectid']) : (responseData['id'] !=null ? int.parse(responseData['id']) : null);
    Map<String, dynamic>? cover = responseData['coverpicture'] ?? null;
    responseData.forEach((key, value) {
    //  print('$key = $value');
    });

    return LibraryItem(
        id: objectId,
        title: responseData['title'],
        authorname: responseData['authorname'],
        authors: responseData['authors'],
        description: responseData['description'],
        introduction: responseData['introduction'],
        level: responseData['level'],
        identifier: responseData['identifier'],
        coverpicture: cover == null ? 'default' : cover['objectid'],
        coverpictureurl: responseData['coverpictureurl'],
        videoUrl : responseData['youtubelink']!=null ?( (responseData['youtubelink'].length>0)?responseData['youtubelink']:null) : null,
        videoId: responseData['videoid'] != false ? responseData['videoid'] : null,
        icon: responseData['icon'],
        pagecount : responseData['pagecount'] != null ? int.parse(responseData['pagecount']) : null,
        objectrating: responseData['objectrating'] !=null ? responseData['objectrating'].toDouble() : null,
        userrating: responseData['userrating'] !=null ? responseData['userrating'].toDouble() : null,
        objectratingcount: responseData['objectratingcount']  ?? null,
        readcount: responseData['readcount'] !=null ? responseData['readcount'] : 0,
        readlistdate: responseData['readlistdate'] !=null ? DateTime.parse(responseData['readlistdate']) : null,
        score: responseData['score'] != null ? int.parse(responseData['score']) : 0,
        readstatus : responseData['readstatus'] != null ? responseData['readstatus'] : 'none',
        hashtags : responseData['hashtags'],
        themes: responseData['themes'],
        accesslevel: responseData['accesslevel'] is int ? responseData['accesslevel'] : int.parse(responseData['accesslevel'])
    );
  }

  Map toJson() => {
    'id' : id,
    'title': title,
    'authorname' :authorname,
    'authors' : authors,
    'description' : description,
    'introduction' : introduction,
    'level' : level,
    'identifier' : identifier,
    'coverpicture':coverpicture,
    'coverpictureurl' : coverpictureurl,
    'icon' : icon,
    'score' : score,
    'pagecount ' : pagecount,
    'videoid' : videoId,
    'youtubelink' : videoUrl,
    'readstatus' : readstatus,
    'readlistdate' : readlistdate,
    'themes' : themes,
    'hashtags' : hashtags,
    'objectrating' : objectrating,
    'objectratingcount' : objectratingcount,
    'userrating' : userrating
  };
}

