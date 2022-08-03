import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:shopping/controler/categoryController.dart';
import 'package:shopping/services/constants.dart';

class HomeScreen extends StatelessWidget {
    CategoryController _categoryController = CategoryController();
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width ;
    double heightScreen = MediaQuery.of(context).size.height ;
    return Scaffold(
      body: Scrollbar(
        isAlwaysShown: true,
        child: ListView(
          children: [
            InkWell(
              onTap: ()async{
                Constants.isfemaleGendre = true;
                  Constants.categories = await _categoryController.getCategory();
                    Navigator.pushNamed(context, '/NavigationHomeScreen');
              },
              child: Container(
                width: widthScreen,
                height: heightScreen *0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/women.jpeg'),
                      fit: BoxFit.cover
                  )
                ),
          child: Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 20.0),
              child: Center(child: Text("Women's collection",style: TextStyle(color: Colors.white,fontSize: 44, height: 1.2 ))),
          )
              ),
            ),
            Container(
              width: widthScreen,
              height: 50,
              color: Colors.black54,
              child: Center(child: Marquee(
                  text: 'Free home delivery over 55 €',
                style:TextStyle(color: Colors.white,fontSize: 20),
                blankSpace: 50,
                  )),
            ),
            InkWell(
              onTap: ()async{
                Constants.isfemaleGendre = false;
                Constants.categories = await _categoryController.getCategory();
                Navigator.pushNamed(context, '/NavigationHomeScreen');
              },
              child: Container(
                  width: widthScreen,
                  height: heightScreen *0.8,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/men.jpeg"),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0,right: 100),
                    child: Center(child: Text("Men's collection",style: TextStyle(color: Colors.white,fontSize: 44, height: 1.2 ))),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
