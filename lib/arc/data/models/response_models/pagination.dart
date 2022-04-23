class Pagination {
  int? total;
  int? limit;
  int? offset;
  int get totalPage => (total! / limit!).ceil();

  Pagination({this.total, this.limit, this.offset});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total_count'];
    limit = json['limit'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['total_count'] = total;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }
}
