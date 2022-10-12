
class Message {
  int? id;
  String? subject;
  String? content;
  String? status;
  String? sender;
  DateTime? date;
  DateTime? statusdate;

  int accessLevel;


  Message({
    this.id,
    this.subject,
    this.content,
    this.status,
    this.sender,
    this.statusdate,
    this.date,
    this.accessLevel=0,

  });



  factory Message.fromJson(Map<String, dynamic> response) {

    Map<String, dynamic> responseData =  response['data'];
    int accessLevel = responseData['accesslevel'] is int  ? responseData['accesslevel'] : int.parse(responseData['accesslevel']);
    //print(responseData['requiredbookcount'].runtimeType);
    return Message(
      id: responseData['objectid'] !=null ? int.parse(responseData['objectid']) : null,
      subject: responseData['subject'],
      content: responseData['content'],
      status : responseData['status'],
      sender: responseData['sender'],
      date : responseData['date'] as DateTime,
      statusdate : responseData['statusdate'] as DateTime,
      accessLevel:  accessLevel,

    );
  }

  Map toJson() => {
    'id' : id,
    'subject' : subject,
    'content' : content,
    'status' : status,
  };


}

