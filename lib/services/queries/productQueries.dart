
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping/services/constants.dart';

class ProductQueries{

  isFavorite(String user, String product) {
    return QueryOptions(document: gql(r"""
                query Favorite($user : uuid, $product: uuid){
                SP_favorite(where: {userId: {_eq: $user}, productId: {_eq: $product}}) {
                  userId
                }
              }
      """),
        variables:{
          "user" : user,
          "product" : product
        },
        fetchPolicy: FetchPolicy.networkOnly);}
  // query for get the list of products by catgeory id
  QueryOptions getProductByCategoryId(List category,String type) {
    return QueryOptions(document: gql(r"""
          query getProductsByCategory($categoryId: [uuid!],$isFemale:Boolean,$type: String){
            SP_product(limit:6,where: {categoryId: {_in :$categoryId},isfemaleGendre:{_eq: $isFemale},type:{_like:$type}}){
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

      """),
        variables: {
          "categoryId": category,
          "isFemale" :Constants.isfemaleGendre,
          "type": "%${type}%"
        },
        //fetchPolicy: FetchPolicy.networkOnly
    );}

  // query for get the details of product by id
  QueryOptions getProductDetailsById(String id) {
    return QueryOptions(document: gql(r"""
       query getProductById($id: uuid!){
           SP_product_by_pk(productId: $id){
              productName
              desccription
              price
              promotion
              quantity
              colors
              categoryId
              type
              quantity
              size
             SP_productPhotos{
              color
              photo_id
              photo
            }
  }
}

      """),
        variables: {
          "id": id
        },
        fetchPolicy: FetchPolicy.networkOnly
    );}

  // query for get the list of products by catgeory id and tupe
  QueryOptions getProductByCategoryType(List category,String type) {

    return QueryOptions(document: gql(r"""
          query getProductsByCategory($type:String,$categoryId: [uuid!]){
            SP_product(where: {categoryId: {_in :$categoryId},type: {_eq:$type}}){
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

      """),
        variables: {
          "categoryId": category,
          "type":type
        },
        fetchPolicy: FetchPolicy.networkOnly
    );}

  addToCart(String user, String product, int quantity,String color,String size) {
    return MutationOptions(document: gql(r"""
          mutation 	addToBasket($user : uuid, $product : uuid,$quantity : Int,$color:String,$size:String){
            insert_SP_cart(objects:[{userId: $user,productId : $product,quantity : $quantity,color:$color,size:$size}]){
              returning{
                productId
              }
            }
          }"""),
        variables: {
          "user" : user,
          "product" : product,
          "quantity" :quantity,
          "color":color,
          "size":size
        },
        fetchPolicy: FetchPolicy.networkOnly
    );}

  QueryOptions getCartProducts(String user) {
    return QueryOptions(document: gql(r"""
         query getCartProduct($user: uuid){
            SP_cart(where: {userId: {_eq: $user}}){
            	quantity
            	color
            	size
              SP_product{
                 productId
                        productName
                        price
                        promotion
                        categoryId
                        quantity
                          SP_productPhotos(limit:1){
                          photo_id
                          color
                          photo
                        }
              }
            }
          }

      """),
      variables: {
        "user": user,
      },
      fetchPolicy: FetchPolicy.networkOnly
    );}

  deleteFromCart(String user, String product) {
    return MutationOptions(document: gql(r"""
         mutation deleteFromCart($user : uuid, $product: uuid) {
            delete_SP_cart(where: {productId: {_eq: $product}, userId: {_eq: $user}}){
              affected_rows
            }
          }
        """),
        variables: {
          "user" : user,
          "product" : product
        },
        fetchPolicy: FetchPolicy.networkOnly
    );
  }
  updateQuantity(String user, String product, int quantity) {
    return MutationOptions(document: gql(r"""
        mutation updateQuantity($product: uuid, $user: uuid,$quantity: Int) {
          update_SP_cart(where: {productId: {_eq: $product}, userId: {_eq: $user}}, _set: {quantity: $quantity}){
            affected_rows
          }
        }
        """),
        variables: {
          "user" : user,
          "product" : product,
          "quantity" :quantity
        },
        fetchPolicy: FetchPolicy.networkOnly
    );}

}