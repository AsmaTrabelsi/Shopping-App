import 'package:flutter/material.dart';


class HomeStore extends StatefulWidget {
  const HomeStore({Key? key}) : super(key: key);

  @override
  _HomeStoreState createState() => _HomeStoreState();
}

class _HomeStoreState extends State<HomeStore> {

  Widget element(double widthScreen){
    return Container(
      margin: EdgeInsets.only(right: 11),
      padding: EdgeInsets.all(10),
      width: widthScreen * 0.3,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.lightBlue,
      ),
      child: Column(
        children: [
          Text('Long sleeve midi dress'),
          SizedBox(height: 11),
          Image.network('https://static.pullandbear.net/2/photos//2021/V/0/1/p/4393/210/923/4393210923_4_1_8.jpg?t=1611823785679&imwidth=563',
            width: widthScreen * 0.2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('100 DT'),
              IconButton(icon: Icon(Icons.favorite_border),
                onPressed: (){
                print('hiiiiiiiiii');

                },color: Color(0xFF104C91),)
            ],
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // testing the state of the stream (if the user is login in or not
    /*if(user == null){
      return Authenticate ; // user not conected
      else
      retrun Home() ; // user conected
    }
    */
    double widthScreen = MediaQuery.of(context).size.width ;
    return Scaffold(
      appBar: AppBar(
        leading: Card(
          color: Colors.white,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(150),
            ),

            child: Icon(Icons.menu,color: Colors.black,)),
        backgroundColor: Color(0xFFEFC9AF),
        centerTitle: true,
        title: Text('Shopping Store',
            style: TextStyle(color: Color(0xFF1F8AC0),fontFamily: 'Pacifico',
                fontSize: 22 )),
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.account_circle_outlined),color: Color(0xFF1F8AC0)),
          IconButton(icon: Icon(Icons.shopping_cart_outlined), color: Color(0xFF1F8AC0),
            onPressed: (){
              print('hiiiiiiiiii');

            },
          ),
        ],
        bottom: PreferredSize(

          preferredSize: Size.fromHeight(55),
          child: Container(
            width: 350,
            height: 50,
            padding: EdgeInsets.all(5),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.send,color: Color(0xFF1F8AC0),),
                prefixIcon: Icon(Icons.search, color: Color(0xFF1F8AC0),),
                hintText: 'what you looking for',
                fillColor: Color(0xFFEFC9AF),
                hintStyle: TextStyle(color: Color(0xFF1F8AC0)),
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF1F8AC0), width: 1),
                    borderRadius: BorderRadius.circular(22)
                ),
              ),


            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 11,bottom: 11),
            child: Align(
              alignment: Alignment.topCenter,
              child: Wrap(
                runSpacing: 11,
                children: [
                  Container(
                   margin: EdgeInsets.only(right: 11),
                    padding: EdgeInsets.all(10),
                    width: widthScreen * 0.45,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lightBlue,
                    ),
                    child: ListView(
                      children: [
                        Text('Long sleeve midi dress'),
                        SizedBox(height: 11),
                        // hero dont work
                        Hero(
                          tag: 'paris',
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/paris.jpeg'),
                              )
                            )
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('100 DT'),
                            Icon(Icons.favorite_border,color: Color(0xFF104C91),)
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: widthScreen *  0.45,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lightBlue,
                    ),
                    child: Column(

                      children: [
                        Text('Long sleeve midi dress'),
                        SizedBox(height: 11),
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('https://static.pullandbear.net/2/photos//2021/V/0/1/p/4393/210/923/4393210923_4_1_8.jpg?t=1611823785679&imwidth=563'),
                            )

                        ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('100 DT'),
                            Icon(Icons.favorite_border,color: Color(0xFF104C91),)
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 11),
                    padding: EdgeInsets.all(10),
                    width: widthScreen * 0.45,
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lightBlue,
                    ),
                    child: Column(
                      children: [
                        Text('Long sleeve midi dress'),
                        SizedBox(height: 11),
                        Image.network('https://static.pullandbear.net/2/photos//2021/V/0/1/p/4393/210/923/4393210923_4_1_8.jpg?t=1611823785679&imwidth=563',
                          width: widthScreen * 0.42,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('100 DT'),
                            Icon(Icons.favorite_border,color: Color(0xFF104C91),)
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 11),
                    padding: EdgeInsets.all(10),
                    width: widthScreen * 0.45,
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.lightBlue,
                    ),
                    child: Column(
                      children: [
                        Text('Long sleeve midi dress'),
                        SizedBox(height: 11),
                        Image.network('https://static.pullandbear.net/2/photos//2021/V/0/1/p/4393/210/923/4393210923_4_1_8.jpg?t=1611823785679&imwidth=563',
                          width: widthScreen * 0.42,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('100 DT'),
                            Icon(Icons.favorite_border,color: Color(0xFF104C91),)
                          ],
                        )
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
