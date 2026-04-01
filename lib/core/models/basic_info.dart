class BasicInfo {
  final String id;
  final String code;
  final String name;

  BasicInfo({required this.id, required this.code, required this.name});

  factory BasicInfo.fromJson(Map<String, dynamic> json) {
    return BasicInfo(id: json['id'], code: json['code'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'code': code, 'name': name};
  }
}
