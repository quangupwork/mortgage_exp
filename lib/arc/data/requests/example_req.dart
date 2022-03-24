class ExampleReq {
  final String getAllTopHashTag = r'''
  query getAllTopHashTag($q: QueryGetListInput) {
  getAllTopHashTag(
    q: $q
  ) {
    data {
      id
      key
      updatedAt
      createdAt
    }
    total
    pagination{
      page
      total
    }
  }
}

''';
}
