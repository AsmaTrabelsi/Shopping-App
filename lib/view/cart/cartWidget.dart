import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shopping/controler/productControler.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:shopping/services/constants.dart';
import 'package:shopping/view/theme/myThemes.dart';
class CartWidget extends StatefulWidget {
  Map map;
  VoidCallback?  refetch ;
   CartWidget({required this.map,this.refetch});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {

  ProductControler _productControler = ProductControler();
  @override
  Widget build(BuildContext context) {
    Color textColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Colors.white : Colors.grey.shade700;
    double widthScreen = MediaQuery.of(context).size.width ;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.20,
            motion: ScrollMotion(),
            children: [
              SlidableAction(onPressed: (BuildContext context)async{
                await _productControler.deleteFromCart(Constants.user!.userId, widget.map['product'].productId);
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
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 3.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Container(
                    width: 90,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image:  MemoryImage(widget.map['product'].photos[0].photo),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: widthScreen *0.55,
                          child: Text(toBeginningOfSentenceCase(widget.map['product'].productName).toString(),style: TextStyle(fontSize: 16,color: textColor,fontWeight: FontWeight.bold))),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text('Color : ${widget.map['color']}, Size : ${widget.map['size']}',style: TextStyle(color: Colors.grey)),
                      ),
                      Row(
                        children: [
                          Row(
                            children: <Widget>[
                              TextButton(

                                  style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(Size(35,30)),
                                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                                      shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)),
                                          side: BorderSide(
                                              color: textColor
                                          )))
                                  ),
                                  onPressed: ()async{
                                    if (widget.map['quantity'] >1 ) {
                                      widget.map['quantity']--;
                                      await _productControler.updateQuantity(Constants.user!.userId, widget.map['product'].productId, widget.map['quantity']);
                                      widget.refetch!();
                                      setState(() {

                                      });
                                    }
                                  },
                                  child: Text("-",
                                      style: TextStyle(color: textColor,fontSize: 18))),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '${widget.map['quantity']}',
                                  style: TextStyle(fontSize: 18.0,color: textColor),
                                ),
                              ),

                            ],
                          ),
                          TextButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(35,30)),
                                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                                  shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)),
                                      side: BorderSide(
                                          color: textColor
                                      )))
                              ),
                              onPressed: ()async{
                                if(widget.map['quantity']< 30 &&  widget.map['quantity'] < int.parse(widget.map['product'].quantity.toString())) {
                                  widget.map['quantity']++;
                                  await _productControler.updateQuantity(Constants.user!.userId, widget.map['product'].productId, widget.map['quantity']);
                                  widget.refetch!();
                                  setState(() {

                                });
                                }
                              },
                              child: Text("+",
                                  style: TextStyle(color:textColor,fontSize: 18))),
                          SizedBox(width: 18),
                          Text('${widget.map['product'].promotion != null ?
                          ((widget.map['product'].price - (widget.map['product'].price * double.parse(widget.map['product'].promotion.toString())))*widget.map['quantity']).toStringAsFixed(2):
                          (widget.map['product'].price *widget.map['quantity']).toStringAsFixed(2) }€',style: TextStyle(fontSize: 18,color: Colors.pinkAccent,fontWeight: FontWeight.bold)),
                        ],

            )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
