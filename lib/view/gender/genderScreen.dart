import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/controler/productControler.dart';
import 'package:shopping/model/product.dart';
import 'package:shopping/services/constants.dart';
import 'package:shopping/view/categoryScreen.dart';
import 'package:shopping/view/product/productWidget.dart';
import 'package:shopping/view/theme/myThemes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class GendreScreen extends StatefulWidget {
  List gendreListType ;
  List gendreSlideImages;
  GendreScreen({required this.gendreListType,required this.gendreSlideImages});

  @override
  State<GendreScreen> createState() => _GendreScreenState();
}

class _GendreScreenState extends State<GendreScreen> {

  List<Product> productsSale = [];
  List<Product> productsNew = [];
  List<Product> productFavoriteSale = [];
  ProductControler _productControler = ProductControler();
  int pageCount= 0;
  int pageIndex= 0 ;
  int activeIndex = 0;
  @override
  void initState() {
        ()async{
      productsSale = await _productControler.getProducts(Constants.categories.values.toList(),"sale");
      productsNew = await _productControler.getProducts(Constants.categories.values.toList(),'new');
      productFavoriteSale = await _productControler.getProducts(Constants.categories.values.toList());
      setState(() {
      });
    }();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Color textColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Colors.white : Colors.grey.shade700;
    double heightScreen = MediaQuery.of(context).size.height ;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Stack(
              children: [
                CarouselSlider(
                  items: widget.gendreSlideImages.map((image) => Image.asset(image,width: double.maxFinite,fit: BoxFit.cover,height: double.maxFinite,)).toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      height: heightScreen * 0.4,
                      enlargeCenterPage: false,
                      viewportFraction: 1,
                      aspectRatio: 2.0,
                      initialPage: 1,
                      onPageChanged: (index,reason)=> setState(()=> activeIndex = index)
                  ),

                ),
                Positioned(
                    top: heightScreen *0.38,
                    left: 0,
                    right: 0,
                    child: Center(child: buildIndicator())),
              ],

            ),
          ),
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.gendreListType.map((type) => TextButton(
                onPressed:(){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=> CategoryScreen(categoryName:type)));
                },
                child: Text(type,style: TextStyle(color: textColor)),

              )).toList()

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
            height: heightScreen >= 800 ? heightScreen *0.36: heightScreen *0.39  ,
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
            height: heightScreen >= 800 ? heightScreen *0.36: heightScreen *0.38  ,
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
          productFavoriteSale.isNotEmpty ?Padding(
            padding: const EdgeInsets.only(top: 8.0,left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Favorites Sales",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: textColor)),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: TextButton(
                      onPressed: (){},
                      child: Text("See more",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.bold))),
                )
              ],
            ),
          ) :Container(),
          productFavoriteSale.isNotEmpty ? Container(
            height: heightScreen >= 800 ? heightScreen *0.36: heightScreen *0.38  ,
            margin: EdgeInsets.only(left: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productFavoriteSale.length,
              itemBuilder: ((context, index){
                return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ProductWidget(product:productFavoriteSale[index])
                );
              }),
            ),
          ):Container(),

          SizedBox(height: 50)

        ],
      ),
    );
  }
  Widget buildIndicator()=> AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: widget.gendreSlideImages.length,
    effect: ExpandingDotsEffect(
        dotWidth: 10,
        dotHeight: 10,
        activeDotColor: Colors.black87,
        dotColor: Colors.grey
    ),
  );

}
