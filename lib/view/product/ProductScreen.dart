import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/controler/productControler.dart';
import 'package:shopping/model/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopping/services/constants.dart';
import 'package:shopping/view/navigationHomeScreen.dart';
import 'package:shopping/view/theme/myThemes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;


class ProductScreen extends StatefulWidget {
  Product? product ;
   ProductScreen({this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int quantityNumber = 1;
  int pageCount= 0;
  int pageIndex= 0 ;
  int activeIndex = 0;
  bool isFavorite = false;
  List<bool>? selectedSizeButton =[];
  List<bool> selectedColorButton =[];
  String selectedColor = '';
  ProductControler _productControler = ProductControler();

  @override
  void initState() {
    ()async{
      if(widget.product!.productId != null){
        Product p = await _productControler.getProductDeatilsById(widget.product!.productId);
        widget.product = p;
        print(widget.product!.size);
        selectedColor = widget.product!.colors![0];

        setState(() {
        });
        selectedSizeButton = widget.product!.size!= null ? List<bool>.generate(widget.product!.size!.length, (int index) => false) : null;
        selectedColorButton = List<bool>.generate(widget.product!.colors!.length, (int index) => false);
        selectedColorButton[0]=true;
        selectedSizeButton != null ? selectedSizeButton![0]=true : null;

      }

    }();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Color textColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Colors.white : Colors.black;
    Color barColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Colors.grey.shade900 : Colors.white;
    Color bgColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Colors.grey.shade800 : Colors.grey.shade200;

    double widthScreen = MediaQuery.of(context).size.width ;
    double heightScreen = MediaQuery.of(context).size.height ;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: widget.product?.desccription != null ? CustomScrollView(
        slivers: [
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                  ),
                  color: barColor,
                ),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5,bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0,right: 8.0,top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: widthScreen * 0.58,
                            child: Text(toBeginningOfSentenceCase(widget.product!.productName).toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: textColor),)),
                     Container(
                      //width: widthScreen * 0.35,
                      child: widget.product!.promotion != null ? Row(
                        children: [
                          Text(
                            "${widget.product!.price}",
                            style: TextStyle(
                                color: Colors.grey,fontSize: 20,
                                decoration: TextDecoration.lineThrough
                            ),
                          ),
                          Text(
                            "  ${(widget.product!.price - (widget.product!.price * double.parse(widget.product!.promotion.toString()))).toStringAsFixed(2)} €",
                            style: TextStyle(
                                fontSize: 22,color: Colors.pinkAccent
                            ),
                          ),
                        ],
                      ): Text(
                          "${widget.product!.price} €",
                          style: TextStyle(
                              fontSize: 25,color: Colors.pinkAccent
                          )),
                    )

                      ],
                    ),
                  )),
            ),
            expandedHeight: heightScreen * 0.7,
            collapsedHeight: heightScreen * 0.15,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  CarouselSlider(
                    items: widget.product!.photos.where((element) => element.color == selectedColor).map((e) => Image.memory(e.photo,width: double.maxFinite,fit: BoxFit.fill,height: double.maxFinite,)).toList(),
                    options: CarouselOptions(
                      autoPlay: widget.product!.photos.length >1 ? true : false,
                      height: heightScreen * 0.75,
                      enlargeCenterPage: false,
                      viewportFraction: 0.9,
                      aspectRatio: 2.0,
                      initialPage: 1,
                      onPageChanged: (index,reason)=> setState(()=> activeIndex = index)


                    ),

                  ),
                  Positioned(
                    top: heightScreen *0.6,
                      left: 0,
                      right: 0,
                      child: Center(child: buildIndicator())),
                ],

              )
            )
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               widget.product!.size != null? Padding(
                  padding: const EdgeInsets.only(left: 16.0,top: 12.0,bottom: 8.0),
                  child: Text('Size Available',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: textColor),),
                ): Container(),
                widget.product!.size != null? Center(
                  child: Wrap(
                    spacing: 12,
                      children: getSizeList()
                  ),
                ) : Container(),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0,top: 8.0,bottom: 8.0),
                  child: Text('Colors Available ',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: textColor),),
                ),
                Center(
                  child: Wrap(
                    spacing: 12,
                      children: getColorList()
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 27,
                      backgroundColor: bgColor,
                      child: IconButton(
                        iconSize: 33,
                          color: Colors.pinkAccent,
                          onPressed: ()async{
                        if(Constants.user != null){
                          if(widget.product!.isFavorite){
                            await  _productControler.deleteFavorite(Constants.user!.userId, widget.product!.productId);
                          }else{
                            await _productControler.addFavorite(Constants.user!.userId, widget.product!.productId);
                          }
                          widget.product!.isFavorite =!widget.product!.isFavorite;
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

                      }, icon: Icon(isFavorite ? Icons.favorite:Icons.favorite_border)),
                    ),
                    Container(
                      color: Colors.transparent,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.pinkAccent),
                                shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40)),
                                    ))
                            ),
                              onPressed: int.parse(widget.product!.quantity.toString())> 0 ?(){
                              if(Constants.user != null){
                                _productControler.addToCart(Constants.user!.userId, widget.product!.productId,widget.product!.colors![selectedColorButton.indexOf(true)],widget.product!.size![selectedSizeButton!.indexOf(true)]);
                              }else{
                                Navigator.of(context)
                                    .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NavigationHomeScreen(
                                                index: 3)), (
                                    route) => route.isFirst);
                              }
                              } : null,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 90.0),
                              child: Text(int.parse(widget.product!.quantity.toString())> 0 ?"Add to cart" : "Out of stock",style: TextStyle(color: Colors.white,fontSize: 18),),
                            )))
                  ],
                ),
                SizedBox(height: 20)
              ],
            ),
          )
        ],
      ) :
      Center(child: CircularProgressIndicator(color: Colors.pinkAccent,)),
    );
  }


  Widget buildIndicator()=> AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: widget.product!.photos.where((element) => element.color == selectedColor).length,
    effect: ExpandingDotsEffect(
      dotWidth: 10,
      dotHeight: 10,
      activeDotColor: Colors.black87,
      dotColor: Colors.grey
    ),
  );

  getSizeList(){
    final children = <Widget>[];
    for(var i = 0; i < widget.product!.size!.length; i++) {
      children.add(TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(selectedSizeButton![i] ? Colors.pinkAccent : Colors.transparent),
              shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)),
                  side: BorderSide(
                      color: Colors.grey.shade400
                  )))
          ),
          onPressed: (){
            selectedSizeButton = List<bool>.generate(widget.product!.size!.length, (int index) => false) ;
            selectedSizeButton![i] = true ;
            setState(() {

            });
          },
          child: Text(widget.product!.size![i],
            style: TextStyle(color: selectedSizeButton![i] ?Colors.white : Colors.pinkAccent,fontSize: 18),)))  ;


    }
    return children;

  }

  getColorList(){
    final children = <Widget>[];
    for(var i = 0; i < widget.product!.colors!.length; i++) {
      children.add(TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(0)),
              shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)),
                  side: BorderSide(
                    width: 2,
                      color: selectedColorButton[i] ? Colors.pinkAccent: Colors.grey.shade200
                  )))
          ),
          
          onPressed: (){
            selectedColorButton = List<bool>.generate(widget.product!.colors!.length, (int index) => false) ;
            selectedColorButton[i] = true ;
            selectedColor = widget.product!.colors![i];
            setState(() {
              
            });
          },
          child: Image.memory(widget.product!.photos.where((element) => element.color == widget.product!.colors![i]).first.photo,width:90,height: 120,fit: BoxFit.fill)))  ;


    }
    return children;

  }


}
