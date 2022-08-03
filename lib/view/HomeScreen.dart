

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopping/controler/productControler.dart';
import 'package:shopping/model/product.dart';
import 'package:shopping/view/product/productWidget.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> productsSale = [];
  List<Product> productsNew = [];
  List<Product> productswomen = [];
  List<Product> productsMen = [];
  ProductControler _productControler = ProductControler();
  List saleProducts = ["bd2013e1-5ca8-46ec-8a12-076d26ae0525","bbd0e995-fde7-4c26-ba16-f278b9880e18"];
  List newProducts = ["2d6b0411-4c61-42ba-97dd-0dc46f687203","db7d0fee-ff48-4349-9107-f4b5cfeb2de8"];
  List menProducts = ["fda108bc-fe69-4700-9e30-13d9dcdc4630","0356f250-66af-476b-a01d-db03e10d9a02"];
  @override
  void initState() {
        ()async{
      productsSale = await _productControler.getProducts(saleProducts);
      productsNew = await _productControler.getProducts(newProducts);
      productswomen = await _productControler.getProducts(["8cb42c36-cfe3-4fc9-8924-d2ea205b6f8a"]);
      productsMen = await _productControler.getProducts(menProducts);

      print(productswomen.length);
      setState(() {
      });
    }();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Color textColor = MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.grey.shade700;
    double widthScreen = MediaQuery.of(context).size.width ;
    double heightScreen = MediaQuery.of(context).size.height ;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: heightScreen * 0.4,
            width: widthScreen,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("https://images.pexels.com/photos/2312250/pexels-photo-2312250.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                    fit: BoxFit.cover
                )
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("20% OFF",style: TextStyle(color: Colors.white,fontSize: 44)),
                  Text("For summer collection",style: TextStyle(color: Colors.white,fontSize: 18))
                ],
              ),
            ),
          ),
      SizedBox(height:8.0),
      Center(child: Text("Top category",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: textColor),)),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Card(
                        elevation: 3.0,
                        shadowColor: Colors.white24,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              image: DecorationImage(
                                  image: NetworkImage("https://images.pexels.com/photos/1043473/pexels-photo-1043473.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text('Men',style: TextStyle(fontWeight: FontWeight.bold,color: textColor)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Card(
                        elevation: 3.0,
                        shadowColor: Colors.white24,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),

                              image: DecorationImage(
                                  image: NetworkImage("https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text('Women',style: TextStyle(fontWeight: FontWeight.bold,color: textColor)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Card(
                        elevation: 3.0,
                        shadowColor: Colors.white24,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              image: DecorationImage(
                                  image: NetworkImage("https://images.pexels.com/photos/1620769/pexels-photo-1620769.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text('Kids',style: TextStyle(fontWeight: FontWeight.bold,color: textColor)),
                      )
                    ],
                  )
                ],
              ),
            ),

          productsSale.isNotEmpty ? Padding(
            padding: const EdgeInsets.only(top: 4.0,left: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sale",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: textColor)),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: TextButton(
                    onPressed: (){},
                      child: Text("See more",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.bold))),
                )
              ],
            ),
          ) : Container(),
          productsSale.isNotEmpty ? Container(
            height: heightScreen *0.34,
            margin: EdgeInsets.only(left: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productsSale.length,
              itemBuilder: ((context, index){
                return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ProductWidget(product:productsSale[index])
                );
              }),
            ),
          ):Container(),

          productsNew.isNotEmpty ? Padding(
            padding: const EdgeInsets.only(top: 8.0,left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("New collection",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: textColor)),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: TextButton(
                      onPressed: (){},
                      child: Text("See more",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.bold))),
                )
              ],
            ),
          ): Container(),
          productsNew.isNotEmpty ? Container(
            height: heightScreen *0.34,
            margin: EdgeInsets.only(left: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productsNew.length,
              itemBuilder: ((context, index){
                return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ProductWidget(product:productsNew[index])
                );
              }),
            ),
          ):Container(),
          productswomen.isNotEmpty ?Padding(
            padding: const EdgeInsets.only(top: 8.0,left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Women's collection",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: textColor)),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: TextButton(
                      onPressed: (){},
                      child: Text("See more",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.bold))),
                )
              ],
            ),
          ) :Container(),
          productswomen.isNotEmpty ? Container(
            height: heightScreen *0.34,
            margin: EdgeInsets.only(left: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productswomen.length,
              itemBuilder: ((context, index){
                return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ProductWidget(product:productswomen[index])
                );
              }),
            ),
          ):Container(),

          productsMen.isNotEmpty ?Padding(
            padding: const EdgeInsets.only(top: 8.0,left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Men's collection",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: textColor)),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: TextButton(
                      onPressed: (){},
                      child: Text("See more",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.bold))),
                )
              ],
            ),
          ): Container(),
          productsMen.isNotEmpty ? Container(
            height: heightScreen *0.34,
            margin: EdgeInsets.only(left: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productsMen.length,
              itemBuilder: ((context, index){
                return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ProductWidget(product:productsMen[index])
                );
              }),
            ),
          ):Container(),
          SizedBox(height: 50)

        ],
      ),
    );
  }
}
