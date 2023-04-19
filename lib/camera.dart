// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
//
// class ImagePickerScreen extends StatefulWidget {
//   @override
//   _ImagePickerScreenState createState() => _ImagePickerScreenState();
// }
//
// class _ImagePickerScreenState extends State<ImagePickerScreen> {
//   List<File> _imageFiles = [];
//
//   Future<void> _getImage() async {
//     final imageFile = await ImagePicker().pickImage(
//       source: ImageSource.camera,
//     );
//     setState(() {
//       _imageFiles.add(File(imageFile!.path));
//     });
//   }
//
//   Future<void> _saveImages() async {
//     final appDirectory = await getApplicationDocumentsDirectory();
//     List<String> fileNames = [];
//     for (int i = 0; i < _imageFiles.length; i++) {
//       final fileName = 'image_$i.jpg';
//       fileNames.add(fileName);
//       final savedImage = await _imageFiles[i].copy('${appDirectory.path}/$fileName');
//     }
//     print('Images saved to local storage: $fileNames');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Picker'),
//       ),
//       body: Column(
//         children: [
//           // Expanded(
//           //   child: GridView.builder(
//           //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           //       crossAxisCount: 3,
//           //       childAspectRatio: 1,
//           //       crossAxisSpacing: 5,
//           //       mainAxisSpacing: 5,
//           //     ),
//           //     itemCount: _imageFiles.length,
//           //     itemBuilder: (BuildContext context, int index) {
//           //       return Image.file(_imageFiles[index]);
//           //     },
//           //   ),
//           // ),
//           SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FloatingActionButton(
//                 onPressed: _getImage,
//                 tooltip: 'Take a picture',
//                 child: Icon(Icons.camera_alt),
//               ),
//               SizedBox(width: 20),
//               FloatingActionButton(
//                 onPressed: _saveImages,
//                 tooltip: 'Save images',
//                 child: Icon(Icons.save),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
