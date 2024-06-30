
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/home.dart';



void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key ,}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
          return MaterialApp(
            title: 'Flutter Demo',
            home: const Home(),
          );
          
        }
}

