class Note {
  String? userId;
  String? id;
  String? title;
  String? body;
  String? createdAt;
  String? updatedAt;

  Note(
      {this.id,
      this.userId,
      this.title,
      this.body,
      this.createdAt,
      this.updatedAt});

  Note.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['title'] = title;
    data['body'] = body;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
