class Score{
  int? id;
  String? description;
  DateTime? scoredate;
  String? sourcetype;
  int? sourceid;

  Score({
    this.id,
    this.description,
    this.scoredate,
    this.sourcetype,
    this.sourceid
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'description': this.description,
      'scoredate': this.scoredate,
      'sourcetype': this.sourcetype,
      'sourceid': this.sourceid,
    };
  }

  factory Score.fromJson(Map<String, dynamic> map) {
    return Score(
      id: map['id'] as int,
      description: map['description'] as String,
      scoredate: map['scoredate'] as DateTime,
      sourcetype: map['sourcetype'] as String,
      sourceid: map['sourceid'] as int,
    );
  }


}