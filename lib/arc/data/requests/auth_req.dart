class AuthReq {
  final String checkValidUser = r'''
  mutation checkValidUser($phone: String) {
    checkValidUser(
      phone: $phone
    ) 
  }
  ''';
  final String registerWithPhone = r'''
  mutation registerWithPhone($name: String!, $phone: String!, $password: String! ,$idToken: String!,$username: String!,$avatar: String,$description: String) {
    registerWithPhone(
      name: $name 
      phone: $phone
      password: $password
      idToken: $idToken
      username: $username
      avatar: $avatar
      description: $description
    ) {
      user{
        id
      }
      token
      username
    }
  }
  ''';
  final String loginUser = r'''
   mutation loginUser($username: String!, $password: String!) {
    loginUser(
      username: $username
      password: $password
    ){
      user{
        id
        name
        username
        role
        phone
        description
        avatar
        address
        website
        newsSavedIds
      }
      token
    }
  }
  ''';
  final String destroyToken = r'''
  mutation destroyToken{
    destroyToken
  }
  ''';

  final String resetPassword = r'''
   mutation resetPassword($idToken: String, $newPassword: String!) {
    resetPassword(
      idToken: $idToken
      newPassword: $newPassword
    ){
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

  final String changePassword = r'''
   mutation changePassword($oldPassword: String!, $newPassword: String!) {
    changePassword(
      oldPassword: $oldPassword
      newPassword: $newPassword
    ){
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
