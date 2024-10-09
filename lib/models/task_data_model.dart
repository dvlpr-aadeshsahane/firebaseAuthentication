
class TaskDataModel {
  String? uid;
  int? timeCreated;
  bool? completed;
  String? subtitle;
  String? title;

  TaskDataModel({this.uid, this.timeCreated, this.completed, this.subtitle, this.title});

  TaskDataModel.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    timeCreated = json["time_created"];
    completed = json["completed"];
    subtitle = json["subtitle"];
    title = json["title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["uid"] = uid;
    _data["time_created"] = timeCreated;
    _data["completed"] = completed;
    _data["subtitle"] = subtitle;
    _data["title"] = title;
    return _data;
  }
}