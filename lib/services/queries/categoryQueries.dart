

import 'package:graphql_flutter/graphql_flutter.dart';

class CategoryQueries{

  // query for get the list of product catgeory
  QueryOptions getCategories() {
    return QueryOptions(document: gql(r"""
         query{
          SP_productCategory{
            categoryId
            categoryName
          }
}
      """),
        fetchPolicy: FetchPolicy.networkOnly
    );}
}