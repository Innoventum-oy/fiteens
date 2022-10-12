
import 'package:luen/src/objects/formelement.dart';

enum LoadingStatus {
  Idle,
  Loading,
  Ready,
  Error
}
class Form{
  int? id;
  String? title;
  String? description;
  bool isExpanded;
  List<FormElement> elements = [];
  LoadingStatus loadingStatus = LoadingStatus.Idle;
  Map<String,dynamic>? data;
  Form({this.id, this.title, this.description,this.isExpanded:false, this.data}){
    this.elements = [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.title ??'',
      'description': this.description ??'',
      'data' : data,
    };
  }

  factory Form.fromJson(Map<String, dynamic> response) {
    Map<String, dynamic> map = response['data'] ?? response;
   // map.forEach((key, value) { print('$key = $value');});
    return Form(
      id: int.parse(map['id']) ,
      title: map['title'] ,
      description: map['description'] ,
      data:map
    );
  }
}