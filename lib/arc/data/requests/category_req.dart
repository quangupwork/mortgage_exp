class CategoryReq {
  final String getAllNewsCategory = r'''
query getAllNewsCategory($q:QueryGetListInput){
  getAllNewsCategory(q:$q){
    data{
      id
      name
      tagName
      rgbCardColor
      rgbItemColor
      createdAt
      updatedAt
    }
    total
    pagination{
      limit
      offset
      page
      total
    }
  }
}
  ''';
}
