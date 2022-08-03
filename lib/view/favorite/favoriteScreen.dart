import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping/controler/productControler.dart';
import 'package:shopping/model/product.dart';
import 'package:shopping/services/constants.dart';
import 'package:shopping/services/queries/favoriteQueries.dart';
import 'package:shopping/view/favorite/favoriteWidget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Product> products = [];
  ProductControler _productControler = ProductControler();
  final FavoriteQueries _favoriteQueries = FavoriteQueries();

  @override
  Widget build(BuildContext context) {
    return Constants.user != null ? Query(
        options: _favoriteQueries.getFavorites(Constants.user!.userId),
        builder: (
        QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }){
          if(result.isNotLoading){
            products =  _productControler.getFavoriteProducts(result);
            if(products.isNotEmpty){
              return  ListView.builder(
                  itemCount: products.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: FavoriteWidget(product: products[index],refetch: refetch,),
                    );
                  }

                  ));
            }else{
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("images/love_it.svg",
                            height: 150, width: 150),
                        SizedBox(height: 12),
                        Text("Don't miss a thing",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
                          child: Center(
                              child: Text(
                                  "with favorites, you can make a list of all of your favorite products in one place.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17))),
                        ),
                      ]);
                }

          }
          else{
            return Center(child: CircularProgressIndicator(color: Colors.pinkAccent));
          }

    }

    )
        : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset("images/love_it.svg",height: 150,width: 150),
        SizedBox(height: 18),
        Text("Don't miss a thing", textAlign: TextAlign.center,
          style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 10),
          child: Center(child: Text("with favorites, you can make a list of all of your favorite products in one place.", textAlign: TextAlign.center,
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
}