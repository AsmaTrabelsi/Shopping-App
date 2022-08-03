import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width ;
    return Scaffold(
      backgroundColor: Colors.cyan.shade50,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.account_circle_rounded,size: 30,color: Colors.black,))
        ],
        leading: Icon(Icons.menu,color: Colors.black,size: 30),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("Shopping"),
      ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Category",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              ),
              Center(
                child: Wrap(
                  spacing: 20,
                  children: [
                    Text("Man"),
                    Text("Woman"),
                    Text('Devices'),
                    Text('Gaming'),
                    Text('Fast Food')
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                            child: IconButton(
                            iconSize: 35,onPressed: null, icon: Icon(Icons.snowshoeing_sharp)),
                        backgroundColor: Colors.white,radius: 30),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text('Man'),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                            child: IconButton(
                                iconSize: 35,onPressed: null, icon: Icon(Icons.fastfood)),
                            backgroundColor: Colors.white,radius: 30),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text('Fast Food'),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                            child: IconButton(
                                iconSize: 35,onPressed: null, icon: Icon(Icons.laptop)),
                            backgroundColor: Colors.white,radius: 30),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text('Devices'),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                            child: IconButton(
                                iconSize: 40,onPressed: null, icon: Icon(Icons.snowshoeing_sharp)),
                            backgroundColor: Colors.white,radius: 30),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text('Man'),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                            child: IconButton(
                                iconSize: 40,onPressed: null, icon: Icon(Icons.snowshoeing_sharp)),
                            backgroundColor: Colors.white,radius: 30),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text('Man'),
                        )
                      ],
                    ),

                  ],
                ),
              ),
              Center(
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
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
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
}
