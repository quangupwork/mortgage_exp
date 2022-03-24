class NewReq {
  final String getAllNews = r'''
query getAllNews($q: QueryGetListInput) {
  getAllNews(q: $q) {
    data {
      id
      endpoint
      slug
      newsCategoryId
      slugId
      title
      isSaved
      view
      reviewImage
      description
      newsCategory {
        id
        rgbCardColor
        name
        rgbItemColor
        tagName
      }
      createdAt
      updatedAt
    }
    total
    pagination {
      limit
      page
      total
      offset
    }
  }
}

  ''';
  final String saveNews = r'''
    mutation saveNews($newsId: ID!) {
    saveNews(newsId: $newsId) {
      id
      endpoint
      slug
      newsCategoryId
      slugId
      content
      description
      reviewImage
      userPostId
      view
      title
      isSaved
      newsCategory{
        id
        name
        tagName
        rgbCardColor
        rgbItemColor
        createdAt
        updatedAt
      }
      userPost{
        id
        name
        username
        role
        phone
        description
        address
        avatar
        website      
      }
      createdAt
      updatedAt
    }
  }

  ''';
}
