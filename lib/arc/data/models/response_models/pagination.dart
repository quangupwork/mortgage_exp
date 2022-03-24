class Pagination {
  int? page;
  int? total;
  int? limit;
  int? offset;
  int get totalPage => (total! / limit!).ceil();

  Pagination({this.page, this.total, this.limit, this.offset});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    total = json['total'];
    limit = json['limit'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['total'] = total;
    data['limit'] = limit;
    data['offset'] = offset;
    return data;
  }
}
