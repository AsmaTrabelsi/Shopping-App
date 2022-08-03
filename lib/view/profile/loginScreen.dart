import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping/model/user.dart';
import 'package:shopping/services/constants.dart';
import 'package:shopping/services/queries/userQueries.dart';
import 'package:shopping/view/navigationHomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String error ='' ;
  String email ='' ;
  String psw ='' ;
  bool trouve= false;
  bool errorVisibility = false;
  UserQueries _userQueries = UserQueries();

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width ;

    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg.jpeg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.darken)
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 30,bottom: 12),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: 60),
                 Center(
                   child: Icon(Icons.account_circle,size: 130,color: Colors.pinkAccent,),
                 ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0,bottom: 2.0),
                      child: Text("Welecome Back",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 28),
                        textAlign: TextAlign.center,),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Text("Login to continue",style: TextStyle(color: Colors.grey.shade300,fontWeight: FontWeight.bold,fontSize: 20),
                        textAlign: TextAlign.center,),
                    ),
                  ),
                  Visibility(
                      visible: errorVisibility,
                      child: Center(child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(error,style: TextStyle(color: Colors.red),),
                      ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 22),
                    child: TextFormField(
                      validator: (value) => value!.isEmpty ? "enter email" : null,
                      onChanged: (value){
                        setState(() => email=value);
                      },
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.white),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(9)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(9)
                        ),
                      ),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 22),
                    child: TextFormField(
                      validator: (value) {
                        if(value!.isEmpty)
                          return "entre password" ;
                        else
                          return null;
                      },
                      onChanged: (value){
                        setState(() => psw=value);
                      },
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(9)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(9)
                        ),
                      ),


                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0,top: 4.0,bottom: 4.0),
                    child: Text("Forgot password?",textAlign: TextAlign.end),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 12.0),
                    child: Container(
                      width: double.infinity,
                      child: Query(
                          options: _userQueries.getAuthentification(email,psw),
                          builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore }) {
                            return TextButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.pinkAccent),
                                    shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                                        side: BorderSide(
                                            color: Colors.grey.shade700
                                        )))
                                ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      print(result.data);
                                      if (result.data!['SP_user'] == null || result.data!['SP_user'].isEmpty) {
                                        setState(() {
                                          error = "please enter a valid email & password";
                                          errorVisibility = true;
                                        });
                                      }else {
                                        var data = result.data!['SP_user'][0];
                                        Constants.user = User(
                                            data['userId'], data['userName'],
                                            data['email'], data['phone'], null);

                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NavigationHomeScreen(
                                                        index: 3)), (
                                            route) => route.isFirst);
                                      }
                                    }
                                    },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 90.0),
                                  child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 18),),
                                ));
                          }
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Dont have account?",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/RegistreScreen');
                          },
                          child: Text(" Create a new account",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
