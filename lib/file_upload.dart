import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/result.dart';
import 'package:flutter_application_1/diseaseFormat.dart';

class Files extends StatefulWidget {

  const Files({super.key, required this.query});
final String query;
  @override
  State<Files> createState() => _FilesState();
}
List<XFile>? mediaFileList = [];
final ImagePicker _picker = ImagePicker();

class _FilesState extends State<Files> {
  @override

  Widget build(BuildContext context) {
    Future pickgallery() async{
      final images = await _picker.pickMultiImage();
        setState(() {
          mediaFileList = images;
        });
    }
    Future pickcamera() async{
      final images = await _picker.pickImage(source: ImageSource.camera );
        setState(() {
          if(images!= null){
          mediaFileList?.add(images);
          }
        });
    }
    return Scaffold(
      appBar: AppBar(
      title: Text('Upload/Select Images', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.green,
      foregroundColor: Colors.black,
      shadowColor: Colors.grey,
      elevation: 5.0,
      centerTitle: true,
      ),
      body : Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        pickgallery();
                      },
                      icon: Icon(Icons.photo),
                    ),
                    Text('Gallery'),
                  ],
                ),
                SizedBox(height: 100),
                SizedBox(width: 50), // Add horizontal spacing
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        pickcamera();
                      },
                      icon: Icon(Icons.camera),
                    ),
                    Text('Camera'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
             ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(125, 60),
                ),
                onPressed: () async {
                  if (mediaFileList?.length == 0) {
                    // Show dialog for empty mediaFileList
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          content: Container(
                            width: 100.0, // Adjust width as needed
                            height: 130.0, // Adjust height as needed
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Error",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  "Please select at least 1 image to proceed",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                // SizedBox(height: 10.0),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );


                  } else {
                    // Show loading dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green), // Customize color
                                  strokeWidth: 5, // Customize stroke width
                                ),
                                SizedBox(height: 30), // Add spacing
                                Text(
                                  'Loading...', // Add text or additional widgets as needed
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );

                    // Handle button tap
                    DiseaseResponse response = await resultRequest(widget.query);

                    // Dismiss loading dialog
                    Navigator.of(context).pop();

                    // Clear mediaFileList
                    setState(() {
                      mediaFileList!.clear();
                    });

                    // Navigate to ResultScreen with response
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResultScreen(resultList: response)),
                    );
                  }
                },
                child: Text('Send', style: TextStyle(color: Colors.green)),
              ),

            SizedBox(height: 40),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Adjust the number of images in a row
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: mediaFileList?.length,
                itemBuilder: (context, index) {
                  if(mediaFileList != null && mediaFileList!.isNotEmpty){
                  return 
                   Container(
                    decoration: BoxDecoration(
                      border: Border.all( 
                        color: Colors.black, // Adjust border color as needed
                        width: 2.0, // Adjust border width as needed
                      ),
                    ),
                    child: mediaFileList == null
                        ? null
                        : Image.file(
                            File(mediaFileList![index].path),
                            fit: BoxFit.cover,
                          ),
                  );
                  }
                  else {
                    return null;
                  }
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
  
Future<DiseaseResponse> resultRequest(String type) async {
  var request = http.MultipartRequest('POST', Uri.parse('http://ec2-13-233-255-117.ap-south-1.compute.amazonaws.com:8080/apple'));

  // Add images to the request
  for (int i = 0; i < mediaFileList!.length; i++) {
    String fieldName = 'image_$i'; // Field name for each image
    request.files.add(await http.MultipartFile.fromPath(fieldName, mediaFileList![i].path));
  }

  var response = await request.send();
  print(response.statusCode);
  
  if (response.statusCode == 200) {
    // Decode the response JSON and create a DiseaseResponse object
    return DiseaseResponse.fromJson(jsonDecode(await response.stream.bytesToString()));
  } else {
    throw Exception('Failed to load data');
  }
}