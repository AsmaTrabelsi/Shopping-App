import 'package:flutter/material.dart';
import 'package:shopping/controler/productControler.dart';
import 'package:shopping/model/product.dart';
import 'package:shopping/services/constants.dart';
import 'package:shopping/view/product/productWidget.dart';

class CategoryScreen extends StatefulWidget {
  String categoryName;
   CategoryScreen({required this.categoryName});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Product> products =[];
  ProductControler _productControler = ProductControler();
  @override
  void initState() {
    ()async{
      List<Product> p= await _productControler.getProducts(widget.categoryName=='All'? Constants.categories.values.toList() : [Constants.categories[widget.categoryName]]);
      products = p;
      setState(() {

      });
    }();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(widget.categoryName,style: TextStyle(fontSize: 26)),
          actions: [
            IconButton(onPressed: (){},
                icon: Icon(Icons.shopping_cart))
          ],
        ),
      body: products.isNotEmpty ? SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0,bottom: 8.0,top: 8.0),
              child: Wrap(
                spacing: 3.0,
                runSpacing: 10.0,
                children: products.map((product) => ProductWidget(product: product)).toList(),
              ),
            )
          ],
        ),
      ):
      Center(child: CircularProgressIndicator(color: Colors.pinkAccent))
    );
  }
}
