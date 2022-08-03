import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/controler/productControler.dart';
import 'package:shopping/model/product.dart';
import 'package:shopping/services/constants.dart';
import 'package:shopping/view/navigationHomeScreen.dart';
import 'package:shopping/view/product/ProductScreen.dart';
import 'package:shopping/view/theme/myThemes.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;


class ProductWidget extends StatefulWidget {
  Product product;
   ProductWidget({required this.product});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  ProductControler _productControler = ProductControler();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width ;
    double heightScreen = MediaQuery.of(context).size.height ;
    Color cardColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Colors.grey.shade800 : Colors.white;
    Color shadowColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ?  Colors.white :Colors.grey.shade700;
    Color textColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Colors.white : Colors.grey.shade700;

    return InkWell(
      onTap: (){
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context)=> ProductScreen(product: widget.product)), (route) => route.isFirst);
      },
      child: Card(
        elevation: 3,
        shadowColor: shadowColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(10))),
        child: Container(
          width: widthScreen *  0.46,
          height: heightScreen >= 800 ? heightScreen *0.35: heightScreen *0.38,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topRight,
                height: 200,
                width: widthScreen *  0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                  ),
                  image: DecorationImage(
                    image: MemoryImage(widget.product.photos[0].photo),
                    fit: BoxFit.fill,
                  ),

                ),
                child: IconButton(icon: Icon(widget.product.isFavorite ? Icons.favorite : Icons.favorite_border,color: Colors.pink),
                    onPressed: ()async{
                      if(Constants.user != null){
                        if(widget.product.isFavorite){
                          await  _productControler.deleteFavorite(Constants.user!.userId, widget.product.productId);
                        }else{
                          await _productControler.addFavorite(Constants.user!.userId, widget.product.productId);
                        }
                        widget.product.isFavorite =!widget.product.isFavorite;
                        setState(() {

                        });
                      }else{
                        Navigator.of(context)
                            .pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    NavigationHomeScreen(
                                        index: 3)), (
                            route) => route.isFirst);
                      }
                    } ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0,left: 8.0,bottom: 3.0 ),
                child: Text(toBeginningOfSentenceCase(widget.product.productName).toString(),style: TextStyle(color: textColor,fontWeight: FontWeight.bold,fontFamily: 'Hind')),
              ),
              Center(
                child: widget.product.promotion != null ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.product.price}",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                    Text(
                      "  ${(widget.product.price - (widget.product.price * double.parse(widget.product.promotion.toString()))).toStringAsFixed(2)} €",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.pinkAccent,fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ) :
                Text(
                  "${widget.product.price} €",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.pinkAccent,fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
