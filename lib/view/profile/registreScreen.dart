import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopping/controler/userController.dart';
import 'package:shopping/model/user.dart';
import 'package:shopping/services/constants.dart';
import 'package:shopping/services/queries/userQueries.dart';

class RegistreScreen extends StatefulWidget {
  const RegistreScreen({Key? key}) : super(key: key);

  @override
  State<RegistreScreen> createState() => _RegistreScreenState();
}

class _RegistreScreenState extends State<RegistreScreen> {
  UserController _userController = UserController();
  final _formKey = GlobalKey<FormState>();
  String error ='' ;
  String email = '';
  String psw = '';
  String name = '';
  String repsw = '';
  String phone = '';
  bool trouve= false;
  bool errorVisibility = false;
  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(top: 20,bottom: 12),
            child: Form(
              key: _formKey,
              child: Center(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 80.0,bottom: 20.0),
                      child: Text("Registre",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),
                        textAlign: TextAlign.center,),
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
                        validator: (value) => value!.isEmpty || value.length < 4 ? "enter a valide name" : null,
                        onChanged: (value){
                          setState(() => name=value);
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, color: Colors.white),
                          labelText: "User name",
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
                        validator: (value) => value!.isEmpty || value.length <10 || !value.contains("@") || !value.contains(".")? "enter a valide  email" : null,
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
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                      child: TextFormField(
                        validator: (value) =>
                        value!.isEmpty || value.length != 8
                            ? "enter your phone number"
                            : null,
                        onChanged: (value) {
                          setState(() => phone = value);
                        },
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone, color: Colors.white),
                          labelText: "Phone",
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
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1),
                              borderRadius: BorderRadius.circular(9)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 22),
                      child: TextFormField(
                        validator: (value) {
                          if(value!.isEmpty) {
                            return "entre password";
                          }
                          else if(value.length<6){
                            return "password must have at least 6 characters";
                          }
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
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                      child: TextFormField(
                        validator: (value) {
                          if (value != psw) {
                            return "Passwords dont matchs";
                          }
                          else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() => repsw = value);
                        },
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Colors.white),
                          labelText: "Confirm password",
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
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 1),
                              borderRadius: BorderRadius.circular(9)
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 12.0),
                      child: Container(
                        width: double.infinity,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.pinkAccent),
                                shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                                    side: BorderSide(
                                        color: Colors.grey.shade700
                                    )))
                            ),
                            onPressed: ()async{
                              if (_formKey.currentState!.validate()) {
                                bool isAdded = await _userController.addUser(name, email,psw, phone);
                                if(isAdded){
                                  Navigator.of(context).pushReplacementNamed('/LoginScreen');
                                }else{
                                  error ='email or phone is alerady used';
                                  setState(() {

                                  });
                                }

                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 90.0),
                              child: Text("Registre",style: TextStyle(color: Colors.white,fontSize: 18),),
                            )),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Alerady have account?",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, '/LoginScreen');
                            },
                            child: Text(" Login",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
