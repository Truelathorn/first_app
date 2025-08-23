import 'package:flutter/material.dart';

class Week3 extends StatelessWidget {
  const Week3({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listProduct = ['Iphonge', 'Samsung', 'Ojo', 'BlueBerry'];
    return Scaffold(
      appBar: AppBar(title: Text('ListView'), backgroundColor: Colors.white),
      backgroundColor: Colors.grey,
      body: ListView.separated(
        itemCount: listProduct.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text('$index'),
            title: Text(listProduct[index]),
            subtitle: Text('loremlorem....'),
            trailing: Image.asset(
              'background.jpg',
              height: 50,
              width: 50,),
          );
        },
        separatorBuilder: (context, index){
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 2,
            width: double.infinity,
            color: Colors.blueAccent,
          );
        }
      )


      /*body: ListView.builder(
        itemCount: listProduct.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text('$index'),
            title: Text(listProduct[index]),
            subtitle: Text('loremlorem....'),
            trailing: Icon(Icons.edit),
          );
        },
      ),*/
    );

    /*ListView.builder(
        itemCount: listProduct.length,
        itemBuilder: (context, index) {
        return
          Container(
            height: 400,
            width: double.infinity,
            color: Colors.red,
            child: Text('Item ${listProduct[index]}'),
          );
        }));*/
    /*child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: 300, 
            width: 120, 
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20)
            ),),
          Positioned(
            top: 15,
            right: 20,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 110,
            right: 20,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 205,
            right: 20,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),*/

    /*Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Container(width: 100, height: 100, color: Colors.red),
              SizedBox(width: 20),
              Container(width: 100, height: 100, color: Colors.green),
              SizedBox(width: 20),
              Container(width: 100, height: 100, color: Colors.blue),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Expanded(flex: 1 ,child: Container(height: 100, color: Colors.yellow)),
              SizedBox(width: 20),
              Expanded(flex: 2 , child: Container(height: 100, color: Colors.purple)),
              SizedBox(width: 20)
            ],
          ),
        ],
      ),

      Center(
        child: Container(
          height: 250,
          width: 250,
          color: Colors.blueAccent,
          child: Center(
            child: Text("Hello, Tulathorn Prasertsomboon 650710690",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24,
              fontWeight: FontWeight.bold,
              )
            ),
          )
        )
        Text("Hello World!",
          style: TextStyle(fontSize: 32,
          color: Colors.amberAccent, 
          fontWeight: FontWeight.bold),*/
  }
}
