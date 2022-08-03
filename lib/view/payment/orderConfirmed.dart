import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderConfirmed extends StatelessWidget {
  const OrderConfirmed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("images/order_confirmed.svg",height: 190,width: 190),
            SizedBox(height: 18),
            Text("Order Confirmed", textAlign: TextAlign.center,
                style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0)),
            SizedBox(height: 8.0),
            Text('Thank you your order has been placed', style:TextStyle(fontWeight: FontWeight.w500,fontSize: 16.0)),
            SizedBox(height: 16.0),
            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pinkAccent),
                    shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                    ))
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, '/NavigationHomeScreen');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0,vertical: 4.0),
                  child: Text("Back Home",style: TextStyle(color: Colors.white,fontSize: 18),),
                ))
          ],
        ),
      ),
    );
  }
}
