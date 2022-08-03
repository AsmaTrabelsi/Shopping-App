import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/services/constants.dart';

import '../theme/myThemes.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _currentStep= 0;
  List paymentMethod =['MasterCard','PayPal','Visa'];

  final _personalStepFormKey = GlobalKey<FormState>();
  final _addressStepFormKey = GlobalKey<FormState>();
  final _paymentStepFormKey = GlobalKey<FormState>();
  int value = 0;
  String email = Constants.user!.email;
  String name = Constants.user!.userName;
  String phone = Constants.user!.phone;
  String address='';
  String city='';
  int? zipCode ;
  Color borderColor = Colors.grey.shade200;
  Color iconColor = Colors.white;
  String cardNumber='';
  String cardCode='';
  @override
  Widget build(BuildContext context) {
     borderColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ?Colors.grey.shade200: Colors.grey.shade400 ;
     iconColor = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Colors.white: Colors.grey.shade700 ;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Payment data",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.pinkAccent,
          ),
        ),
        child: Stepper(
          onStepTapped: (index){
            setState(() {
              _currentStep = index;
            });
          },
          currentStep: _currentStep,
          onStepContinue: (){
            if(_currentStep == 0 && _personalStepFormKey.currentState!.validate()){
             setState(() {
               _currentStep ++;
             });
            }else if(_currentStep== 1 &&_addressStepFormKey.currentState!.validate()){
              setState(() {
                _currentStep ++;
              });
            }else if(_currentStep==2 &&_paymentStepFormKey.currentState!.validate()){
              Navigator.pushNamed(context,'/OrderConfirmed');
            }
          },
          onStepCancel: (){
            if(_currentStep!=0){
              setState(() {
                _currentStep--;
              });
            }
          },
          steps: [
            personalStep(),
            addressStep(),
            paymentStep()
          ],
        ),
      ),
    );
  }
  Step personalStep(){
    return Step(
        isActive: _currentStep>=0,
        title: Text('Personal'),
        content: Form(
          key: _personalStepFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  validator: (value) => value!.isEmpty || value.length < 4 ? "enter a valide name" : null,
                  onChanged: (value){
                    setState(() => name=value);
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person,color: iconColor),
                    labelText: "User name",
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(9)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(9)
                    ),
                  ),

                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  validator: (value) => value!.isEmpty || value.length <10 || !value.contains("@") || !value.contains(".")? "enter a valide  email" : null,
                  onChanged: (value){
                    setState(() => email=value);
                  },
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email,color:iconColor),
                    labelText: "Email",
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(9)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(9)
                    ),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
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
                    prefixIcon: Icon(Icons.phone,color: iconColor),
                    labelText: "Phone",
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(9)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(9)
                    ),
                  ),

                ),
              ),
            ],
          ),
        )
    );
  }

  Step addressStep(){
    return Step(
        isActive: _currentStep>=1,
        title: Text('Address'),
        content: Form(
          key: _addressStepFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  validator: (value) => value!.isEmpty || value.length < 4 ? "enter a valide address" : null,
                  onChanged: (value){
                    setState(() => address=value);
                  },
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on_rounded,color: iconColor),
                    labelText: "Address",
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(9)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(9)
                    ),
                  ),

                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextFormField(
                  validator: (value) => value!.isEmpty || value.length <10 || !value.contains("@") || !value.contains(".")? "enter a valide  email" : null,
                  onChanged: (value){
                    setState(() => email=value);
                  },
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email,color: iconColor),
                    labelText: "Email",
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(9)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(9)
                    ),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 140,
                      child: TextFormField(
                        validator: (value) =>
                        value!.isEmpty || value.length != 8
                            ? "enter your city"
                            : null,
                        onChanged: (value) {
                          setState(() => city = value);
                        },
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city,color: iconColor),
                          labelText: "City",
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor, width: 1),
                              borderRadius: BorderRadius.circular(9)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor, width: 1),
                              borderRadius: BorderRadius.circular(9)
                          ),
                        ),

                      ),
                    ),

                    Container(
                      width: 140,
                      child: TextFormField(
                        validator: (value) =>
                        value!.isEmpty || value.length != 8
                            ? "enter your phone number"
                            : null,
                        onChanged: (value) {
                          setState(() => zipCode = int.parse(value));
                        },
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.numbers,color: iconColor),
                          labelText: "Zip code",
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor, width: 1),
                              borderRadius: BorderRadius.circular(9)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: borderColor, width: 1),
                              borderRadius: BorderRadius.circular(9)
                          ),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  Step paymentStep(){
    return Step(
        isActive: _currentStep>=2,
        title: Text('Payment'),
        content: Form(
          key: _paymentStepFormKey,
          child: Column(
            children: [
              Container(
                height: 170,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      contentPadding: EdgeInsets.all(-4),
                      value: index,
                      groupValue: value,
                      activeColor: Colors.pinkAccent,
                      controlAffinity: ListTileControlAffinity.trailing,
                      onChanged: (ind) {
                        value = index ;
                        setState(() {

                        });
                      },
                      title: Text(paymentMethod[index],style: TextStyle(
                           fontWeight: FontWeight
                          .w500, fontFamily: "OpenSans", fontSize: 16),),
                    );
                  },
                  itemCount:paymentMethod.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextFormField(
                  validator: (value) =>
                  value!.isEmpty || value.length != 16
                      ? "enter your card number"
                      : null,
                  onChanged: (value) {
                    setState(() => cardNumber = value);
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.credit_card,color: iconColor),
                    labelText: "Card Number",
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(9)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(9)
                    ),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: TextFormField(
                  validator: (value) =>
                  value!.isEmpty || value.length != 6
                      ? "enter your card code"
                      : null,
                  onChanged: (value) {
                    setState(() => cardNumber = value);
                  },
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password,color: iconColor),
                    labelText: "Code",
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(9)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(9)
                    ),
                  ),

                ),
              ),
            ],
          ),
        ));
  }
}
