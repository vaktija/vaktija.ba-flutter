class EzanModel {
  String muazzin;
  String path;
  int id;

  EzanModel({
    required this.muazzin,
    required this.path,
    required this.id,
  });

  factory EzanModel.fromJson(Map<String, dynamic> json) {
    return EzanModel(
      muazzin: json['muazzin'],
      path: json['path'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'muazzin': muazzin,
      'path': path,
      'id': id,
    };
  }
}
