class DetailAppReq {
  final String getAllRvStreamProject = r'''
    query getAllRvStreamProject($q: QueryGetListInput, $time: String){
      getAllRvStreamProject(
        q:$q
        searchByStrTime: $time
      ){	
        data{
          id
          title
          projectIcon{
            id
            key
            image
            createdAt
            updatedAt
          }
          projectTags{
            id
            name
            rgbItemColor
            createdAt
            updatedAt
          }
          projectTagIds
          projectIconId
          createdAt
          updatedAt
        }
      }
    }
  ''';
  final String getAllRvMakerProject = r'''
    query getAllRvMakerProject($q: QueryGetListInput, $time: String){
      getAllRvMakerProject(
        q:$q
        searchByStrTime: $time
      ){	
        data{
          id
          title
          projectIcon{
            id
            key
            image
            createdAt
            updatedAt
          }
          projectTags{
            id
            name
            rgbItemColor
            createdAt
            updatedAt
          }
          projectTagIds
          projectIconId
          createdAt
          updatedAt
        }
      }
    }
  ''';
  final String getAllRvGroupProject = r'''
    query getAllRvGroupProject($q: QueryGetListInput, $time: String){
      getAllRvGroupProject(
        q:$q
        searchByStrTime: $time
      ){	
        data{
          id
          title
          projectIcon{
            id
            key
            image
            createdAt
            updatedAt
          }
          projectTags{
            id
            name
            rgbItemColor
            createdAt
            updatedAt
          }
          projectTagIds
          projectIconId
          createdAt
          updatedAt
        }
      }
    }
  ''';
}
