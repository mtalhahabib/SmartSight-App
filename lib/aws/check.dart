// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:amplify_storage_s3/amplify_storage_s3.dart';
//
//
//
// class AWS extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<AWS> {
//
//   List<String> _imageUrls = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _configureAmplify();
//   }
//
//   Future<void> _configureAmplify() async {
//     try {
//       await Amplify.addPlugins([AmplifyStorageS3()]);
//       await Amplify.configure(amplifyconfig);
//       print('Amplify configured successfully');
//     } catch (e) {
//       print('Error configuring Amplify: $e');
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'S3 Image Viewer',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('S3 Image Viewer'),
//         ),
//       ),
//     );
//   }
// }
//
// const amplifyconfig = '''
//   amplify:
//     storage:
//       plugins:
//         - awsS3Storage:
//             bucketName: 3-dmodels
//             region: Asia Pacific (Singapore) ap-southeast-1
//             accessKey: ASIAUQUJQMKVVD32VPE3
//             secretKey: J0RmU4UzECqUoHi0T6oel3gCNXPYBzHZaudeMDW1
// ''';
