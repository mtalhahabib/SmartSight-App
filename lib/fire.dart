// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage( 'Image App'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//
//   final String title;
//   MyHomePage(this.title);
//
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late File _imageFile;
//   final picker = ImagePicker();
//
//   Future<void> _getImage(ImageSource source) async {
//     final pickedFile = await picker.getImage(source: source);
//
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//
//       _cropImage();
//     }
//   }
//
//   Future<void> _cropImage() async {
//     ImageCropper cropper=ImageCropper();
//     final croppedFile = await cropper.cropImage(
//       sourcePath: _imageFile.path,
//       aspectRatioPresets: [
//         CropAspectRatioPreset.square,
//         CropAspectRatioPreset.ratio3x2,
//         CropAspectRatioPreset.original,
//         CropAspectRatioPreset.ratio4x3,
//         CropAspectRatioPreset.ratio16x9
//       ],
//       uiSettings: [
//         AndroidUiSettings: AndroidUiSettings(
//           toolbarTitle: 'Crop Image',
//           toolbarColor: Colors.blue,
//           toolbarWidgetColor: Colors.white,
//           initAspectRatio: CropAspectRatioPreset.original,
//           lockAspectRatio: false),
//         iosUiSettings: IOSUiSettings(
//           title: 'Crop Image',
//         ),],
//
//     );
//
//     if (croppedFile != null) {
//       _uploadImageToFirebaseStorage(croppedFile);
//     }
//   }
//
//   Future<void> _uploadImageToFirebaseStorage(File file) async {
//     final storageRef = FirebaseStorage.instance.ref().child('images/${DateTime.now()}.jpg');
//
//     final uploadTask = storageRef.putFile(file);
//
//     final taskSnapshot = await uploadTask.onComplete;
//
//     final downloadUrl = await taskSnapshot.ref.getDownloadURL();
//
//     _saveImageToFirestore(downloadUrl);
//   }
//
//   Future<void> _saveImageToFirestore(String downloadUrl) async {
//     final docRef = FirebaseFirestore.instance.collection('images').doc();
//
//     await docRef.set({'url': downloadUrl, 'timestamp': DateTime.now()});
//
//     setState(() {
//       _imageFile = null;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('images').orderBy('timestamp', descending: true).snapshots(),
//     builder: (context, snapshot) {
//     if (!snapshot.hasData) {
//     return Center(child: CircularProgressIndicator());
//     }
//
//     final docs = snapshot.data.docs;
//
//     return ListView.builder(
//     itemCount: docs.length,
//     itemBuilder: (context, index) {
//     final doc = docs[index].data();
//     final timestamp = doc['timestamp'] as Timestamp;
//     final dateTime = timestamp.toDate();
//
//     return ListTile(
//     title:
//     Text(dateTime.toString()),
//       leading: Image.network(doc['url'] as String),
//     );
//     },
//     );
//     },
//         ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _getImage(ImageSource.camera),
//         tooltip: 'Take a Photo',
//         child: Icon(Icons.camera_alt),
//       ),
//     );
//   }
// }