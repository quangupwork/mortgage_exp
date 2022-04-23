class DocumentModel {
  String? title;
  String? link;

  DocumentModel({
    this.title,
    this.link,
  });

  DocumentModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['link'] = link;
    return data;
  }
}
