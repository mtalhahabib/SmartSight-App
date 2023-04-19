import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';


import 'bottom_sheets.dart';
import 'camera.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  Future<void> _getImage() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

  }



  List<String> _recents = [ ];

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


              child: FutureBuilder(
                // Replace with your own Future function that retrieves data
                future: Future.delayed(Duration(seconds: 2), () => _recents),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(snapshot.data[index],style: TextStyle(
                              color: Colors.white
                          ),),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('No data found.'),
                    );
                  }
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
        _getImage();


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
