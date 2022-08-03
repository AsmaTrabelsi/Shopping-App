import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping/controler/productControler.dart';
import 'package:shopping/model/product.dart';
import 'package:shopping/services/constants.dart';
import 'package:shopping/services/queries/productQueries.dart';
import 'package:shopping/view/cart/cartWidget.dart';
import 'package:shopping/view/payment/paymentScreen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ProductQueries _productQueries = ProductQueries();
  ProductControler _productControler =ProductControler();
  List listProducts  = [];
  double delivery = 5.0;
  double total = 0;
  @override
  Widget build(BuildContext context) {
    return Constants.user!= null ? Query(
        options: _productQueries.getCartProducts(Constants.user!.userId),
    builder: (
    QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }){
          if(result.isNotLoading){
            Map data =  _productControler.getCartProducts(result);
            print(data);
            total = data['total'];
            if(total > 55){
              delivery = 0.0;
            }
            listProducts = data['list'] ;
            if(listProducts.isNotEmpty){
              return ListView(
                children: [
                  Column(
                    children: listProducts.map((map) => CartWidget(map: map,refetch: refetch)).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0,left: 16.0,right: 16.0,top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total cart',style: TextStyle(fontSize: 18,color: Colors.grey)),
                            SizedBox(height: 3),
                            Text("Delivery",style: TextStyle(fontSize: 18,color: Colors.grey)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('$total €',style: TextStyle(fontSize: 18),),
                            Text("$delivery €",style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color:Colors.grey.shade400 ,
                    thickness: 2.0,
                    endIndent: 18.0,
                    indent: 18.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',style: TextStyle(fontSize: 18,color: Colors.grey),),
                        Text("${total+delivery} €",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18.0,left: 16,right: 16,top: 16.0),
                    child: Container(
                        color: Colors.transparent,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.pinkAccent),
                                shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)),
                                ))
                            ),
                            onPressed: (){
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context)=> PaymentScreen()), (route) => route.isFirst);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 30),
                              child: Text("Buy now",style: TextStyle(color: Colors.white,fontSize: 18),),
                            ))),
                  )
                ],
              );
            }else{
              return emptyCart();
            }
          }else{
            return Center(child: CircularProgressIndicator(color: Colors.pinkAccent));
          }

    }

    ): emptyCart() ;

  }
  emptyCart()=>Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgPicture.asset("images/cart.svg",height: 150,width: 150),
      SizedBox(height: 18),
      Text("Your cart is empty", textAlign: TextAlign.center,
          style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 10),
        child: Center(child: Text("Looks like you have not added anything to your cart. go ahead & explore top categories.", textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16))),
      ),
      TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.pinkAccent),
              shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                  ))
          ),
          onPressed: () async {
            Navigator.pushNamed(context, '/LoginScreen');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90.0,vertical: 2.0),
            child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 18),),
          ))
    ],
  );
}
