import 'package:flutter/material.dart';
 
void main() => runApp(seguridadApp());
 
class seguridadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            
            
             child:  Image(image: AssetImage("images/upeu.png"))
          ),
        ),
      ),
    );
  }
}