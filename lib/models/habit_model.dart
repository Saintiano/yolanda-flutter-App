class HabitModel {
  HabitModel({
    required this.name,
    required this.frequency,
    required this.status,
    required this.dateCreated,
    required this.dateUpdated,
  });
  late final String name;
  late final String frequency;
  late final String status;
  late final String dateCreated;
  late final String dateUpdated;

  HabitModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    frequency = json['frequency'];
    status = json['status'];
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['frequency'] = frequency;
    _data['status'] = status;
    _data['dateCreated'] = dateCreated;
    _data['dateUpdated'] = dateUpdated;
    return _data;
  }
}