
class LibraryCollection {
  int? id;
  String? title;
  String? description;

  String? coverpicture;
  String? coverpictureurl;
  String? icon;
  int accesslevel;

  LibraryCollection({
    this.id,
    this.title,
    this.description,
    this.icon,
    this.coverpicture,
    this.coverpictureurl,
    this.accesslevel=0
  });



  factory LibraryCollection.fromJson(Map<String, dynamic> response) {

    Map<String, dynamic> responseData =  response['data'];
    int accesslevel = responseData['accesslevel'] is int  ? responseData['accesslevel'] : int.parse(responseData['accesslevel']);
    Map<String, dynamic>? cover = responseData['coverpicture'] ?? null;
    if(accesslevel>10) {
      //print("Access to object {$responseData['objectid']}: " + responseData['accesslevel'].toString());
   //   responseData.forEach((key, value) { print('$key = $value');});
    }
    return LibraryCollection(
        id: responseData['objectid'] !=null ? int.parse(responseData['objectid']) : null,
        title: responseData['title'],
        description: responseData['description'],

        coverpicture: cover == null ? 'default' : cover['objectid'],
        coverpictureurl: responseData['coverpictureurl'],

        icon: responseData['icon'],

        accesslevel:  accesslevel
    );
  }

  Map toJson() => {
    'id' : id,
    'title': title,
    'description' : description,

    'coverpicture':coverpicture,
    'coverpictureurl' : coverpictureurl,

  };
}

