import 'package:mortgage_exp/arc/data/models/models.dart';

class PostResponse {
  List<PostModel>? postModel;
  Pagination? pagination;
  PostResponse({this.postModel, this.pagination});

  PostResponse.fromJson(Map<String, dynamic> json) {
    if (json['objects'] != null) {
      postModel = [];
      json['objects'].forEach((v) {
        postModel?.add(PostModel.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
}
