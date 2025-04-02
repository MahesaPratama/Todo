class TodoModel {
  String id;
  String isi;
  bool isDone;

  TodoModel({required this.id, required this.isi, this.isDone = false});
}
