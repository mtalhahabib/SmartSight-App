import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../recents/cropPage.dart';

class FypProvider with ChangeNotifier{

  Database? _database;
  List<Map<String, dynamic>> imageslist = [];

  CroppedFile? imageFile;


  Future<void> initDatabase() async {
     Directory documentsDirectory = await getApplicationDocumentsDirectory();
     String path = "${documentsDirectory.path}/images.db";

     _database = await openDatabase(path, version: 1,
         onCreate: (Database db, int version) async {
           await db.execute(
               "CREATE TABLE images (id INTEGER PRIMARY KEY, name TEXT, imagePath TEXT, dateTime TEXT)");
     });
     await loadImagesFromDatabase();

   }

  Future<void> loadImagesFromDatabase() async {
    List<Map<String, dynamic>> images =
    await _database!.rawQuery("SELECT * FROM images ");   // ORDER BY id DESC

      imageslist = images;
    notifyListeners();
  }

  Future<void> saveImageToDatabase(String imagePath) async {
    int imageCount = await _database!
        .rawQuery("SELECT COUNT(*) FROM images")
        .then((value) => Sqflite.firstIntValue(value)!);

    if (imageCount >= 5) {
      await _database!.rawDelete("DELETE FROM images WHERE id = 1");
    }

    String name = "NewFile ${DateFormat('yy-MM-dd HH:mm:ss').format(DateTime.now())}";
    String dateTime = "Accessed:  ${DateFormat('yy-MM-dd HH:mm:ss').format(DateTime.now()).toString()}";
    await _database!.rawInsert(
        "INSERT INTO images (name, imagePath, dateTime) VALUES (?, ?, ?)",
        [name, imagePath, dateTime]);

    await loadImagesFromDatabase();
  }

  Future<void> pickImageFromCamera(BuildContext context) async {
    try {
      ImageCache cache =ImageCache();
         cache.clear();

      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 100);


      if (pickedFile != null) {
        imageFile = CroppedFile(pickedFile.path);
        notifyListeners();
       await _cropImage(context);
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }


  Future<void> _cropImage(BuildContext context) async {
    final cropper =ImageCropper();
    final croppedFile = await cropper.cropImage(
        sourcePath: imageFile!.path,

        cropStyle: CropStyle.rectangle,
        compressQuality: 60,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Edit Image',
              statusBarColor: Colors.black87,
              toolbarColor: Colors.black87,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Edit Image',
          ),
        ]
    );
    if (croppedFile != null) {

        imageFile = croppedFile;
      notifyListeners();
      Navigator.push(
            context,
          MaterialPageRoute(
            builder: (context) => CroppedImg(imageFile),
          ),
        );
      saveImageToDatabase(imageFile!.path);
    }
  }


}