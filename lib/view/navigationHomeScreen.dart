import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:shopping/services/constants.dart';
import 'package:shopping/view/cart/cartScreen.dart';
import 'package:shopping/view/favorite/favoriteScreen.dart';
import 'package:shopping/view/gender/genderScreen.dart';
import 'package:shopping/view/profile/profileScreen.dart';
import 'package:shopping/view/theme/myThemes.dart';

class NavigationHomeScreen extends StatefulWidget {
  int? index;
   NavigationHomeScreen({this.index});

  @override
  State<NavigationHomeScreen> createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  final List<Widget> _children = [Constants.isfemaleGendre ? GendreScreen(gendreListType: Constants.listFemaleTypes,gendreSlideImages: Constants.femaleSlideImages):GendreScreen(gendreListType: Constants.listMaleTypes,gendreSlideImages: Constants.maleSlideImages),
    FavoriteScreen(),CartScreen(),ProfileScreen()];
  List titleList = ['','My Favorites','My Cart',''];
  int _currentIndex=0 ;

  @override
  Widget build(BuildContext context) {
    Color circleColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Colors.white : Colors.grey.shade400;
    Color barColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Colors.grey.shade800 : Colors.grey.shade200;
    Color titleColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Colors.white : Colors.grey.shade700;

    if(widget.index != null){
      _currentIndex = widget.index! ;
    }
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: titleColor),
        title: Text(titleList[_currentIndex],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: titleColor)),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context)
                .pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) =>
                        NavigationHomeScreen(
                            index: 2)), (
                route) => route.isFirst);
          }, icon: Icon(Icons.shopping_cart_rounded,size: 25,color: titleColor,))
        ],

        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
       body: _children[_currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          index: _currentIndex,
          height: 50,
          backgroundColor: Colors.transparent,
          color: barColor,
          onTap: (index)=> setState(() {
            widget.index = null ;
            _currentIndex = index;
          }),
          items: [
            Icon(Icons.home,color: _currentIndex == 0 ? Colors.pinkAccent : Colors.grey.shade500),
            Icon(Icons.favorite, color: _currentIndex == 1 ? Colors.pinkAccent : Colors.grey.shade500),
            Icon(Icons.shopping_cart, color: _currentIndex == 2 ? Colors.pinkAccent : Colors.grey.shade500),
            Icon(Icons.person,color: _currentIndex == 3 ? Colors.pinkAccent : Colors.grey.shade500)

          ],
        ),
      drawer: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: CircleAvatar(
                backgroundColor:circleColor,
                radius: 50,
                child: Image.asset("images/logo.png",height: 100,width: 100,fit: BoxFit.fill,)
                  ),
            ),
            Constants.user != null ? Padding(
              padding:  const EdgeInsets.only(top: 12.0,bottom: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text(Constants.user!.userName),
                  Text(Constants.user!.email),
                ],
              ),
            ): Container(),
            Divider(
              color: Colors.pinkAccent,
            endIndent: 20,
            indent: 20,
            thickness: 1.0),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title:  Text("Home"),
              selectedTileColor: Colors.grey.shade300,
              onTap: () {
                Navigator.of(context)
                    .pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            NavigationHomeScreen(
                                index: 0)), (
                    route) => route.isFirst);

              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title:  Text("My favorites"),
              onTap: () {
                Navigator.of(context)
                    .pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            NavigationHomeScreen(
                                index: 1)), (
                    route) => route.isFirst);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title:  Text("My cart"),
              onTap: () {
                Navigator.of(context)
                    .pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            NavigationHomeScreen(
                                index: 2)), (
                    route) => route.isFirst);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title:  Text("My Profile"),
              onTap: () {
                Navigator.of(context)
                    .pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            NavigationHomeScreen(
                                index: 3)), (
                    route) => route.isFirst);
              },
            ),
           Constants.user != null ? ListTile(
                leading: const Icon(Icons.exit_to_app),
                title:  Text("Logout"),
                onTap: () {
                 Constants.user = null;
                 setState(() {

                 });
                }): ListTile(
               leading: const Icon(Icons.login),
               title:  Text("Login"),
               onTap: () {
                 Navigator.of(context)
                     .pushAndRemoveUntil(
                     MaterialPageRoute(
                         builder: (context) =>
                             NavigationHomeScreen(
                                 index: 3)), (
                     route) => route.isFirst);
               })
          ],

        ),
      ),
    );
  }

  void onTab(int index) {

    print(index);
    _currentIndex = index;
    setState(() {

    });
  }

}
