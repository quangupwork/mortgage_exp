import 'package:mortgage_exp/arc/data/models/models.dart';

class TopicResponse {
  List<TopicModel>? topicModel;
  Pagination? pagination;
  TopicResponse({this.topicModel, this.pagination});

  TopicResponse.fromJson(Map<String, dynamic> json) {
    if (json['objects'] != null) {
      topicModel = [];
      json['objects'].forEach((v) {
        topicModel?.add(TopicModel.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
}
