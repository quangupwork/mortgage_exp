class PostModel {
  String? featuredImage;
  String? name;
  String? postSummary;
  List<int>? topicIds;

  PostModel({
    this.featuredImage,
    this.name,
    this.postSummary,
    this.topicIds,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    featuredImage = json['featured_image'];
    name = json['name'];
    postSummary = json['post_summary'];
    topicIds = json['topic_ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['featured_image'] = featuredImage;
    data['name'] = name;
    data['post_summary'] = postSummary;
    data['topic_ids'] = topicIds;

    return data;
  }
}
