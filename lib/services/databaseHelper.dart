

import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DatabaseHelper {
  static final String endpoint = 'https://healthy-lamprey-23.hasura.app/v1/graphql';
  static final HttpLink httpLink = HttpLink(endpoint);
  static  final ValueNotifier<GraphQLClient> client =
  ValueNotifier(
      GraphQLClient(
          link: httpLink, cache: GraphQLCache(store: null),
      )
  );
}