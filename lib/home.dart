
import 'package:flutter/material.dart';

import 'package:flutter_application_1/file_upload.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
final List<Map<String, dynamic>> fruitsAndImages = [
    {'name': 'Tomato', 'image': 'assets/images/tomato.png'},
    {'name': 'Potato', 'image': 'assets/images/potato.png'},
    {'name': 'Apple', 'image': 'assets/images/apple.png'},
    {'name': 'Bell Pepper', 'image': 'assets/images/bell-pepper.png'},
    {'name': 'Cherry', 'image': 'assets/images/cherries.png'},
    {'name': 'Corn', 'image': 'assets/images/corn.png'},
    {'name': 'Grape', 'image': 'assets/images/grapes.png'},
    {'name': 'Peach', 'image': 'assets/images/peach.png'},
    {'name': 'Strawberry', 'image': 'assets/images/strawberry.png'}
  ];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('LEAFY', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.green,
      foregroundColor: Colors.yellow,
      shadowColor: Colors.grey,
      elevation: 4.0,
      centerTitle: true,
      ),
      // body : Container(
      //   child: TextButton(
      //     child: Text("Tomato"),
          
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => const Files()),
      //       );
      //     }
      //   )
      // )
      body : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        ),
        itemCount: fruitsAndImages.length,
        itemBuilder: (context, index) {
          // print(fruitsAndImages[index]['image']);
          return GridTile(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(180, 100),
                    ),
                    onPressed: () {
                      // Handle button tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  Files(query: fruitsAndImages[index]['name'],)),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          fruitsAndImages[index]['image'],
                          width: 120, // Adjust width as needed
                          height: 60, // Adjust height as needed
                        ),
                        Text(
                          fruitsAndImages[index]['name'],
                          style: TextStyle(color: Colors.green),
                        ),

                      ],
                    ),
                  ),
                  
                  // SizedBox(height: 10), // Adding space between buttons
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Handle second button tap
                  //     // print('Second button ${index + 1} tapped');
                  //   },
                  //   // child: Text('Second Button'),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}