
import 'dart:convert';
import 'dart:typed_data';

import 'package:shopping/model/product.dart';
import 'package:shopping/model/productPhoto.dart';
import 'package:shopping/services/constants.dart';
import 'package:shopping/services/databaseHelper.dart';
import 'package:shopping/services/queries/favoriteQueries.dart';

class FavoriteController{
  var client = DatabaseHelper.client.value;
  final FavoriteQueries _favoriteQueries = FavoriteQueries();

}