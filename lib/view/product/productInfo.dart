import 'package:flutter/material.dart';
class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('SHORT DRESS WITH ELASTIC WAIST STRAPS'),
          Text('\$100'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
              ),
              CircleAvatar(
                backgroundColor: Colors.black,
              )
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: (){

              }, icon: Icon(Icons.favorite)),
              TextButton(onPressed: (){

              }, child: Text("Add to cart"))
            ],
          )
        ],
      ),
    );
  }
}
