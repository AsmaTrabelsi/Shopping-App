import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shopping/controler/productControler.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:shopping/services/constants.dart';
import 'package:shopping/view/product/ProductScreen.dart';
import 'package:shopping/view/theme/myThemes.dart';

import '../../model/product.dart';

class FavoriteWidget extends StatefulWidget {
  Product product;
  VoidCallback?  refetch ;
   FavoriteWidget({required this.product,this.refetch}) ;

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  ProductControler _productControler = ProductControler();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width ;
    Color shadowColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ?  Colors.white :Colors.grey.shade700;
    Color textColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Colors.white : Colors.grey.shade700;

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.20,
        motion: ScrollMotion(),
        children: [
          SlidableAction(onPressed: (BuildContext context)async{
            await _productControler.deleteFavorite(Constants.user!.userId,widget.product.productId);
           widget.refetch!();
            setState(() {
            });
          },
            backgroundColor: Colors.pinkAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,

          ),
        ],
      ),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context)=> ProductScreen(product: widget.product)), (route) => route.isFirst);
        },
        child: Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            shadowColor: shadowColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 120,
                  width: widthScreen *0.37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0)
                    ),
                    image: DecorationImage(
                      image: MemoryImage(
                          widget.product.photos[0].photo,
                      ),
                        fit: BoxFit.fill
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0,left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: widthScreen *0.57,
                        child: Center(
                          child: Text(
                            toBeginningOfSentenceCase(widget.product.productName).toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: widget.product.promotion != null ? Row(
                          children: [
                            Text(
                              "${widget.product.price}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough
                              ),
                            ),
                            Text(
                              "  ${(widget.product.price - (widget.product.price * double.parse(widget.product.promotion.toString()))).toStringAsFixed(2)} €",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.pinkAccent,fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ) : Text(
                          "${widget.product.price} €",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.pinkAccent,fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
