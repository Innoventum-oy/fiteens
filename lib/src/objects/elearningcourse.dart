
class ElearningCourse {
  int? id;
  String? title;
  String? description;
  String? level;
  String? identifier;
  String? coverpicture;
  String? coverpictureurl;
  String? icon;
  String? textcolour;
  String? backgroundcolour;
  int? unicodeicon;
  int? requiredScore;
  List? requiredKnowledge;
  Map<String,dynamic>? requiredBadge;
  int? collectionid;
  int canvasX;
  int canvasY;
  int accesslevel;
  bool isopened;
  bool iscompleted;
  Map<String,dynamic>? data;

  ElearningCourse({
    this.id,
    this.title,
    this.description,
    this.level,
    this.identifier,
    this.icon,
    this.unicodeicon,
    this.textcolour,
    this.backgroundcolour,
    this.coverpicture,
    this.coverpictureurl,
    this.collectionid,
    this.canvasX=500,
    this.canvasY=500,
    this.accesslevel=0,
    this.isopened = false,
    this.iscompleted = false,
    this.requiredScore = 0,
    this.requiredKnowledge,
    this.requiredBadge,
    this.data
  });



  factory ElearningCourse.fromJson(Map<String, dynamic> response) {

    Map<String, dynamic> responseData =  response['data'];
    List<int> connections = [];
    Map<String, dynamic>? cover = responseData['coverpicture'] ?? null;
    int accesslevel = responseData['accesslevel'] is int ? responseData['accesslevel'] :  int.parse(responseData['accesslevel']);
    if(accesslevel>10) {
      //print("Access to object {$responseData['objectid']}: " + responseData['accesslevel'].toString());
     // responseData.forEach((key, value) { print('$key = $value');});
    }
    if(responseData['requiredknowledge'] != null) {
      for (var knowledgeItem in responseData['requiredknowledge'])
      {
        connections.add(int.parse(knowledgeItem['objectid']));
       // print('adding connection ' + knowledgeItem['objectid'].toString());
      }

      }
   // responseData.forEach((key, value) { print('$key = $value');});
    return ElearningCourse(
        id: responseData['objectid'] !=null ? int.parse(responseData['objectid']) : null,
        title: responseData['title'],
        description: responseData['description'],
        level: responseData['level'],
        identifier: responseData['identifier'],
        coverpicture: cover == null ? 'default' : cover['objectid'],
        coverpictureurl: responseData['coverpictureurl'],
        collectionid : responseData['collections']!=null? ( responseData['collections']['objectid'] != false ? int.parse(responseData['collections']['objectid']) : null ): null,
        icon: responseData['icon'],
        textcolour: responseData['textcolour'] != null ? responseData['textcolour'] :null,
        backgroundcolour: responseData['backgroundcolour'] != null && responseData['backgroundcolour']!='' ? responseData['backgroundcolour'] :null,
        unicodeicon: responseData['unicodeicon']!=null && responseData['unicodeicon']!=''? int.parse(responseData['unicodeicon'],radix:16) : null,
        canvasX : responseData['canvas_x'] !=null? int.parse(responseData['canvas_x']) : 500,
        canvasY : responseData['canvas_y'] !=null? int.parse(responseData['canvas_y']) : 500,
        requiredKnowledge: connections,
        requiredBadge: responseData['requiredbadge'] != null ? responseData['requiredbadge'] : null,
        requiredScore : responseData['requiredscore'] != null ? int.parse(responseData['requiredscore']) :0,
        isopened: responseData['isopened'] != null ? responseData['isopened'] : false,
        iscompleted: responseData['iscompleted'] != null ? responseData['iscompleted'] : false,
        data:responseData,
        accesslevel: accesslevel
    );
  }

  Map toJson() => {
    'id' : id,
    'title': title,
    'description' : description,
    'level' : level,
    'identifier' : identifier,
    'coverpicture':coverpicture,
    'coverpictureurl' : coverpictureurl,
    'icon' : icon,
    'unicodeicon' : unicodeicon,
    'collectionid' : collectionid,
    'textcolour' : textcolour,
    'backgroundcolour' : backgroundcolour,
    'canvas_x': canvasX,
    'canvas_y': canvasY,
    'requiredscore' : requiredScore,
    'requiredknowledge' : requiredKnowledge,
    'requiredbadge' : requiredBadge,
    'isopened' : isopened,
    'iscompleted' : iscompleted,
    'accesslevel' : accesslevel
  };
}

