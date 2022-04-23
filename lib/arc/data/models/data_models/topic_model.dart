class TopicModel {
  int? categoryId;
  int? created;
  int? deletedAt;
  String? description;
  int? id;
  String? name;
  int? portalId;
  String? slug;
  int? updated;

  TopicModel(
      {this.categoryId,
      this.created,
      this.deletedAt,
      this.description,
      this.id,
      this.name,
      this.portalId,
      this.slug,
      this.updated});

  TopicModel.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    created = json['created'];
    deletedAt = json['deletedAt'];
    description = json['description'];
    id = json['id'];
    name = json['name'];
    portalId = json['portalId'];
    slug = json['slug'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['created'] = created;
    data['deletedAt'] = deletedAt;
    data['description'] = description;
    data['id'] = id;
    data['name'] = name;
    data['portalId'] = portalId;
    data['slug'] = slug;
    data['updated'] = updated;
    return data;
  }
}
