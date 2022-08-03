

import 'package:graphql_flutter/graphql_flutter.dart';

class UserQueries{
  MutationOptions addUser(String name, String email, String psw,String phone) {
    return MutationOptions(document: gql(r"""
          mutation insert_SP_user($name: String, $email: String, $psw: String, $phone: String){
              insert_SP_user(objects: [{userName: $name, email: $email, password: $psw,phone: $phone}]){
                returning{
                   userId
                }
                     }
              }"""),
        variables: {
          "name" : name,
          "email" : email,
          "psw" : psw,
          "phone" : phone,
        },
        fetchPolicy: FetchPolicy.networkOnly
    );}

   getAuthentification(String email, String psw) {
    return QueryOptions(document: gql(r"""
            query searchUser($email: String, $psw: String){
                SP_user(where: {password: {_eq: $psw}, email: {_eq: $email}}) {
                  userId
                  userName
                  email
                  phone
                }
              }
      """),
        variables:{
          "email": email,
          "psw": psw
        },
        fetchPolicy: FetchPolicy.networkOnly);}

}