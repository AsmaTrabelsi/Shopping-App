

import 'package:graphql_flutter/graphql_flutter.dart';

class FavoriteQueries{

  addFavorite(String user, String product) {
    return MutationOptions(document: gql(r"""
          mutation addFavorite($user : uuid, $product : uuid){
                insert_SP_favorite(objects:[{userId: $user,productId : $product}]){
                  returning{
                    userId
                  }
                }
              }"""),
        variables: {
          "user" : user,
          "product" : product
        },
        fetchPolicy: FetchPolicy.networkOnly
    );}

  getFavorites(String user_id){
    return QueryOptions(document: gql(r"""
      query getFavorites($id: uuid){
          SP_favorite(where: {userId: {_eq: $id}}){
            SP_product{
              productId
              productName
              price
              promotion
               categoryId
                        SP_productPhotos(limit:1){
                        photo_id
                        color
                        photo
                      }
            }
          }
        }"""),
        variables: {
          "id" : user_id,
        },
        fetchPolicy: FetchPolicy.networkOnly
    );
  }

  deleteFavorite(String user, String product) {
    return MutationOptions(document: gql(r"""
         mutation DeleteFavorite($user : uuid, $product: uuid) {
          delete_SP_favorite(where: {productId: {_eq: $product}, userId: {_eq: $user}}){
            affected_rows
          } 
        }
        """),
        variables: {
          "user" : user,
          "product" : product
        },
        fetchPolicy: FetchPolicy.networkOnly
    );}
}