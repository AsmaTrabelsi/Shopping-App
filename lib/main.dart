import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping/services/databaseHelper.dart';
import 'package:shopping/view/HomeScreen.dart';
import 'package:shopping/view/navigationHomeScreen.dart';
import 'package:shopping/view/payment/orderConfirmed.dart';
import 'package:shopping/view/product/ProductScreen.dart';
import 'package:shopping/view/profile/loginScreen.dart';
import 'package:shopping/view/profile/registreScreen.dart';
import 'package:shopping/view/theme/myThemes.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return GraphQLProvider(
      client: DatabaseHelper.client,
      child: ChangeNotifierProvider(
        create: (context)=>ThemeProvider(),
        builder: (context,_){
          final themeProvider =Provider.of<ThemeProvider>(context);
          return MaterialApp(
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            initialRoute: '/GenderScreen',
            routes: {
              '/GenderScreen' : (context)=> HomeScreen(),
              '/NavigationHomeScreen' : (context)=> NavigationHomeScreen(),
              '/ProductScreen' : (context)=> ProductScreen(),
              '/LoginScreen' : (context)=> LoginScreen(),
              '/RegistreScreen' : (context)=> RegistreScreen(),
              '/OrderConfirmed' : (context)=> OrderConfirmed(),

            },

          );
        },
         
      ),
    );
  }
}
