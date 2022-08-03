

import 'dart:convert';
import 'dart:typed_data';

import 'package:shopping/model/product.dart';
import 'package:shopping/model/productPhoto.dart';
import 'package:shopping/services/constants.dart';
import 'package:shopping/services/databaseHelper.dart';
import 'package:shopping/services/queries/favoriteQueries.dart';
import 'package:shopping/services/queries/productQueries.dart';

class ProductControler{
  final ProductQueries _productQueries = ProductQueries();
  final FavoriteQueries _favoriteQueries = FavoriteQueries();
  var client = DatabaseHelper.client.value;

  Future<bool> isFavorite(String productId) async {
    var query = await client.query(_productQueries.isFavorite(Constants.user!.userId,productId));
    bool favorite = false;
    if (query.data!['SP_favorite'].isNotEmpty) {
      favorite = true;
    }
    return favorite;
  }
  // methode to generate and convert query of products to  list of product object
  Future<List<Product>> getProducts(List id,[String type=""]) async {
    var query = await client.query(_productQueries.getProductByCategoryId(id,type));
    print(query);
    var data = query.data!['SP_product'];
    var long = query.data!['SP_product'].length;
    List<Product> products = [];
    for (int i = 0; i < long; i++) {
        var photoTable = data[i]['SP_productPhotos'][0];
        Uint8List bytesImage = Base64Decoder().convert(
            photoTable['photo'].toString());
        ProductPhoto photo = ProductPhoto(bytesImage,photoTable['color']);
      bool favorite =false;
      if(Constants.user != null){
        favorite = await isFavorite(data[i]["productId"]);
      }
      Product product = Product(productId: data[i]["productId"], productName: data[i]['productName'], price: double.parse(data[i]["price"].toString()), categoryId: data[i]['categoryId'], photos: [photo],promotion:  data[i]['promotion']?? null,isFavorite: favorite);
      products.add(product);
    }
    return products;
  }

  // methode to generate and convert query of products to  list of product object
  Future<List<Product>> getProductsByType(List id,String type) async {
    var query = await client.query(_productQueries.getProductByCategoryType(id,type));
    print(query);
    var data = query.data!['SP_product'];
    var long = query.data!['SP_product'].length;
    List<Product> products = [];

    for (int i = 0; i < long; i++) {
      var photocount = data[i]['SP_productPhotos'].length;
      List<ProductPhoto> photos =[];
      for (int j = 0; j < photocount; j++) {
        var photoTable = data[i]['SP_productPhotos'][j];
        Uint8List bytesImage = Base64Decoder().convert(
            photoTable['photo'].toString());
        ProductPhoto photo = ProductPhoto(bytesImage,photoTable['color']);
        photos.add(photo);
      }
      List<String> colorList= data[i]["colors"].toString().split(",");
      List<String> sizeList = data[i]['size'].toString().split(",");
      Product product = Product(productId: data[i]["productId"], productName: data[i]['productName'], price: double.parse(data[i]["price"].toString()), categoryId: data[i]['categoryId'], photos: photos,promotion:  data[i]['promotion']?? null);
      products.add(product);
    }
    return products;
  }


  // methode to generate and convert query of product to  product object
  Future<Product> getProductDeatilsById(String id) async {
    var query = await client.query(_productQueries.getProductDetailsById(id));
    print(query);
    var data = query.data!['SP_product_by_pk'];

      var photocount = data['SP_productPhotos'].length;
      List<ProductPhoto> photos =[];
      for (int i = 0; i < photocount; i++) {
        var photoTable = data['SP_productPhotos'][i];
        Uint8List bytesImage = Base64Decoder().convert(
            photoTable['photo'].toString());
        ProductPhoto photo = ProductPhoto(bytesImage,photoTable['color']);
        photos.add(photo);
      }
      List<String> colorList= data["colors"].toString().split(",");
      List<String>? sizeList = data['size'] != null ? data['size'].toString().split(",") : null;
      Product product = Product(productId: id, productName: data['productName'], desccription: data["desccription"], price: double.parse(data["price"].toString()),
        promotion: data['promotion']?? null,colors: colorList,size: sizeList,quantity:  data['quantity'],type: data['type'],categoryId: data['categoryId'],photos:  photos);
    return product;
  }
  List<Product> getFavoriteProducts(var query)  {
    print(query);
    var data = query.data!['SP_favorite'];
    var long = query.data!['SP_favorite'].length;
    List<Product> products = [];
    for (int i = 0; i < long; i++) {
      var photoTable = data[i]['SP_product']['SP_productPhotos'][0];
      Uint8List bytesImage = Base64Decoder().convert(
          photoTable['photo'].toString());
      ProductPhoto photo = ProductPhoto(bytesImage,photoTable['color']);

      Product product = Product(productId: data[i]['SP_product']["productId"], productName: data[i]['SP_product']['productName'], price: double.parse(data[i]['SP_product']["price"].toString()), categoryId: data[i]['SP_product']['categoryId'], photos: [photo],promotion:  data[i]['SP_product']['promotion']?? null,isFavorite: true);
      products.add(product);
    }
    return products;
  }

  Future<void> deleteFavorite(String user, String product) async {
    var data = await client.mutate(
        _favoriteQueries.deleteFavorite(user, product));
  }
  Future<void> addFavorite(String user, String product) async {
    var data = await client.mutate(
        _favoriteQueries.addFavorite(user, product));
    print(data);

  }
  Future<void> addToCart(String user, String product,String color,String size,[int quantity=1]) async {
    var data = await client.mutate(
        _productQueries.addToCart(user, product,quantity,color,size));
  }

  Map getCartProducts(var query)  {
    print(query);
    double total =0;
    var data = query.data!['SP_cart'];
    var long = query.data!['SP_cart'].length;
    List list = [];

    for (int i = 0; i < long; i++) {
      Map<String,dynamic> map = {};
      var photoTable = data[i]['SP_product']['SP_productPhotos'][0];
      Uint8List bytesImage = Base64Decoder().convert(
          photoTable['photo'].toString());
      ProductPhoto photo = ProductPhoto(bytesImage,photoTable['color']);

      Product product = Product(productId: data[i]['SP_product']["productId"], productName: data[i]['SP_product']['productName'],
          price: double.parse(data[i]['SP_product']["price"].toString()),
          categoryId: data[i]['SP_product']['categoryId'], photos: [photo],
          quantity: data[i]['SP_product']['quantity'],
          promotion:  data[i]['SP_product']['promotion']?? null,isFavorite: true);
      total += product.promotion != null ?
      double.parse((product.price - (product.price * double.parse(product.promotion.toString()) * data[i]['quantity'] )).toStringAsFixed(2)):
      double.parse((product.price * data[i]['quantity']).toStringAsFixed(2)) ;

      map = {
        "quantity" : data[i]['quantity'],
        "color":data[i]['color'],
        "size":data[i]['size'],
        "product" :product
      };
      list.add(map);
    }
    Map dataMap = {
      "list" : list, "total" :  double.parse((total).toStringAsFixed(2))
    };
    return dataMap;
  }

  Future<void> deleteFromCart(String user, String product) async {
    var data = await client.mutate(
        _productQueries.deleteFromCart(user, product));
    print("deleteed $data");
  }

  Future<void> updateQuantity(String user, String product,quantity) async {
    var data = await client.mutate(
        _productQueries.updateQuantity(user, product,quantity));
  }

}