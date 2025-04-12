class TodoModel {
  String id;
  String isi;
  bool isDone;

  TodoModel({required this.id, required this.isi, this.isDone = false});

  // Convert object Todo ke Map
  Map<String, dynamic> toJson() => {'id': id, 'isi': isi, 'isDone': isDone};

  // Buat object Todo dari Map
  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      TodoModel(id: json['id'], isi: json['isi'], isDone: json['isDone']);
}
