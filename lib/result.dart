import 'package:flutter/material.dart';
import 'package:flutter_application_1/diseaseFormat.dart';

class ResultScreen extends StatefulWidget {
  final DiseaseResponse resultList;

  const ResultScreen({Key? key, required this.resultList}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('State of Leaf', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
        shadowColor: Colors.grey,
        elevation: 5.0,
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: 3, // Number of sections (Diseases, Type of Leaf, Severity)
        separatorBuilder: (context, index) => SizedBox(height: 20), // Add space between sections
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return _buildSection(
                title: 'Diseases',
                items: widget.resultList.diseases,
              );
            case 1:
              return _buildSection(
                title: 'Type of Leaf',
                items: widget.resultList.leaves,
              );
            case 2:
              return _buildSection(
                title: 'Severity',
                items: [widget.resultList.severity.toString()],
              );
            default:
              return SizedBox(); // Return an empty SizedBox for safety
          }
        },
      ),
    );
  }

  Widget _buildSection({required String title, required List<String> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    items[index],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}


// class _ResultScreenState extends State<ResultScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//       title: Text('State of Leaf', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//       backgroundColor: Colors.green,
//       foregroundColor: Colors.black,
//       shadowColor: Colors.grey,
//       elevation: 5.0,
//       centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           SizedBox(height: 20),
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.resultList.diseases.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                   elevation: 2,
//                   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: Colors.green,
//                         child: Text(
//                           '${index + 1}',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                       title: Text(
//                         widget.resultList.diseases[index],
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       // subtitle: Text(
//                       //   'Description of the disease goes here...',
//                       //   style: TextStyle(fontSize: 14),
//                       // ),
//                       // trailing: Icon(Icons.arrow_forward),
//                       // onTap: () {
//                       //   // Handle tap
//                       // },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),

//     );
//   }
// }
