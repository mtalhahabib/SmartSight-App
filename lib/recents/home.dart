
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/recents/imagePage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


import 'bottom_sheets.dart';
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    loadImagesFromDatabase();
    initDatabase();

  }
//--------------------------------------------------------------------------------------------------------
  //         Structural Functions

  void _openlabel() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: labelPage()
      ),
    );
  }

  void _open3D() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
          child: modelPage()
      ),
    );
  }

  void _openAnimation() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
          child: AnimationPage()
      ),
    );
  }
//---------------------------------------------------------------------------------------

  // DataBase Functions
  late Database _database;
  List<Map<String, dynamic>> imageslist = [];



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
    await _database.rawQuery("SELECT * FROM images ");   // ORDER BY id DESC
    setState(() {
      imageslist = images;
    });
  }

  Future<void> saveImageToDatabase(String imagePath) async {
    int imageCount = await _database
        .rawQuery("SELECT COUNT(*) FROM images")
        .then((value) => Sqflite.firstIntValue(value)!);

    if (imageCount >= 15) {
      await _database.rawDelete("DELETE FROM images WHERE id = 1");
    }

    String name = "NewFile ${DateFormat('yy-MM-dd HH:mm:ss').format(DateTime.now())}";
    String dateTime = "Accessed:  ${DateFormat('yy-MM-dd HH:mm:ss').format(DateTime.now()).toString()}";
    await _database.rawInsert(
        "INSERT INTO images (name, imagePath, dateTime) VALUES (?, ?, ?)",
        [name, imagePath, dateTime]);

    await loadImagesFromDatabase();
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      await saveImageToDatabase(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SvgPicture.asset(
              'assets/Vector.svg',
              height: 24.0,
              width: 24.0,

            ),
            SizedBox(width: 5,),
            Text('SmartSight',style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),),
          ],
        ),

        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.video_call))
        ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0), // Set the height of the green border line
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2.0, color: Colors.green), // Set the width and color of the green border line
                ),
              ),
            ),
          )
      ),
      body: Container(

        color: Colors.black87,
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                'Recents',

                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(


              child:ListView.builder(
                itemCount: imageslist.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> image = imageslist[index];
                  return ListTile(
                    leading: Image.file(File(image["imagePath"]),height: 100,width: 70,fit: BoxFit.fill,),
                    title: Text(image["name"],style: TextStyle(
                      color: Colors.white
                    ),),
                    subtitle: Text(image["dateTime"],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w200
                    ),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImagePage(image["imagePath"],image["name"]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],

        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.camera_alt),
        onPressed: (){
            pickImageFromCamera();
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.green,
              width: 2.0,
            ),
          ),
        ),
        child: BottomAppBar(
          color: Colors.black87,
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              TextButton.icon(
                onPressed: () => _openlabel(),
                icon: Column(

                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height:2 ,),
                    ImageIcon(

                      AssetImage('assets/labels.png'),
                      color: Colors.white,

                    ),
                    SizedBox(height: 3,),
                    Text(
                      'Labels',
                      style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w300,
                      fontSize: 12),
                    ),

                  ],
                ),
                label: SizedBox.shrink(),
              ),
              TextButton.icon(
                onPressed: () => _open3D(),
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height:2 ,),
                    Icon(
                      CupertinoIcons.cube_fill,
                      color: Colors.white,
                    ),
                    SizedBox(height: 3,),
                    Text(
                      '3D Models',
                      style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 12
                      ),
                    ),
                  ],
                ),
                label: SizedBox.shrink(),
              ),
              TextButton.icon(
                onPressed: () => _openAnimation(),

                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height:2 ,),
                    ImageIcon(

                    AssetImage('assets/Vector.png'),
                      color: Colors.white,

                    ),
                    SizedBox(height: 3,),
                    Text(
                      'Animations',
                      style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w300,
                          fontSize: 12),

                    ),
                  ],
                ),
                label: SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
