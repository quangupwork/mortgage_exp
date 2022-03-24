class ProfileReq {
  final String getMe = r'''
  query getMe() {
    getMe{
      id
      name
      username
      role
      phone
      description
      address
      website
      avatar
      newsSavedIds
    } 
  }
  ''';
}
