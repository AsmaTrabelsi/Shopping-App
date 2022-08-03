import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shopping/services/constants.dart';
import 'package:shopping/view/theme/myThemes.dart';

import '../theme/changeThemeButtonWidget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Color circleColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Colors.white : Colors.grey.shade400;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 60),
         Constants.user != null ? Column(
           children: [
             CircleAvatar(
                 backgroundColor:circleColor,
                 radius: 50,
                 child: Image.asset("images/girl.png",height: 100,width: 100,fit: BoxFit.fill,)
             ),
             SizedBox(height: 10),
             Text('Asma trabelsi'),
             SizedBox(height: 4),
             Text('asmatra149@gmail.com'),
             SizedBox(height: 10),
             Divider(thickness: 2,color: Colors.pinkAccent,indent: 30,endIndent: 30),
             SizedBox(height: 10),
           ],
         ):
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20,top: 40),
              child: SvgPicture.asset(
                "images/login_svg.svg",height: 130,width: 130,

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 6.0),
              child: Text('Sign up, sync your orders, save your desires and your details to win time when paying',
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),textAlign: TextAlign.center),
            ),
          ],
        ),
          Constants.user != null ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 3.0,
              shadowColor: Colors.white24,
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('My profile'),
                trailing: Icon(Icons.keyboard_arrow_right_sharp),
              ),
            ),
          ) : Container(),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 3.0,
              shadowColor: Colors.white24,
              child: ListTile(
                leading: Icon(Icons.nightlight_round),
                title: Text('Dark mode'),
                trailing: ChangeThemeButtonWidget(),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 3.0,
              shadowColor: Colors.white24,
              child: ListTile(
                leading: Icon(Icons.info),
                title: Text('About app'),
                trailing: Icon(Icons.keyboard_arrow_right_sharp),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 3.0,
              shadowColor: Colors.white24,
              child: ListTile(
                leading: Icon(Icons.description),
                title: Text('Terms of use'),
                trailing: Icon(Icons.keyboard_arrow_right_sharp),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 3.0,
              shadowColor: Colors.white24,
              child: ListTile(
                onTap: (){
                  if(Constants.user == null){
                      Navigator.pushNamed(context, '/LoginScreen');
                      }
                    else{
                      Constants.user = null;
                      setState(() {

                      });
                  }
                },
                leading: Icon(Constants.user != null ?Icons.logout: Icons.login,color: Colors.pinkAccent),
                title: Text(Constants.user!= null?'Logout' : "Login",style: TextStyle(color: Colors.pinkAccent),),
                trailing: Icon(Icons.keyboard_arrow_right_sharp,color: Colors.pinkAccent),
              ),
            ),
          ),



        ],
      ),
    );
  }
}
