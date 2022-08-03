

import 'package:shopping/model/productPhoto.dart';

class Product{
  String productId ;
  String productName;
  String? desccription;
  double price ;
  double? promotion;
  List<String>? colors;
  List<String>? size;
  int? quantity;
  String? type;
  List<ProductPhoto> photos;
  String categoryId;
  bool isFavorite;

  Product({required this.productId,
    required this.productName,
    this.desccription,
    required this.price,
    this.promotion,
    this.colors,
    this.size,
    this.quantity,
    this.type,
    required this.categoryId,
    required this.photos,this.isFavorite=false});
}