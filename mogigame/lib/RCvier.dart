// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'dart:math';
class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController row = TextEditingController();
  TextEditingController column = TextEditingController();
     // ignore: non_constant_identifier_names
   List products = [
    "A",
    'B',
    'B'
  ,];
     bool _isElevated = false;
   int rowC = 5;
  int colC = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions:<Widget> [
      ]),
      body:SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                 //  height: MediaQuery.of(context).size.height/1.6,
                  child: GridView.builder(
                    itemCount: rowC*colC,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowC,childAspectRatio: colC*rowC/30 ,
                      crossAxisSpacing: 10,mainAxisSpacing: 10),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                      child: Text(products.join('')),
                      color: Color.fromARGB(255, 251, 255, 253),
                      
                    ),
                  ),
              ),
               ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
            controller: row,
             decoration: InputDecoration(
                   fillColor: Colors.white,
            filled: true,
             label:Text( 'Row',style: TextStyle(fontWeight: FontWeight.bold),)
           ),
          ),
              ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: TextField(
             decoration: InputDecoration(
                      fillColor: Colors.white,
              filled: true,
               label:Text( 'Column',style: TextStyle(fontWeight: FontWeight.bold),)
             
             ),
              controller: column,
            ),
         ),
         SizedBox(height: 20,),
GestureDetector(
  onTap: (){
      rowC = int.parse(row.text);
    colC = int.parse(column.text);
    setState(() {
      _isElevated = !_isElevated;
    });
  },
  child:AnimatedContainer(
    child: Center(child: Text("Add",style:TextStyle(fontWeight: FontWeight.bold))),
    duration:Duration(microseconds: 200),
  height: 50,
width: 80,    
decoration: BoxDecoration(
   color: Colors.white,
  borderRadius: BorderRadius.circular(50),boxShadow:_isElevated? [
    const BoxShadow(color: Colors.white10,offset: Offset(4, 4),
    blurRadius: 15,
    spreadRadius: 1),const BoxShadow(color:Colors.white,offset: const Offset(-4, -4),
    blurRadius: 15,
    spreadRadius: 1)
  ]:null
),
  
  ),
)

            // SizedBox(height: 20,),
            // FlatButton(onPressed: (){
            //  rowC = int.parse(row.text);
            //   colC = int.parse(column.text);
              
            //   setState(() {
      
            //   });
            // }, child: Container(
            //   color: Colors.purple,
            //     padding: EdgeInsets.all(20),
            //     child: Text("Add")))
            ],
          ),
        ),
      ) ,
    );
  }

}
