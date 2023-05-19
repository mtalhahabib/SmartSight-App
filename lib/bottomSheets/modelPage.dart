import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:babylonjs_viewer/babylonjs_viewer.dart';

import '../homePage/cropPage.dart';

class modelPage extends StatefulWidget {
  @override
  State<modelPage> createState() => _modelPageState();
}

class _modelPageState extends State<modelPage> {
  bool check_model=false;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    setState(() {
      if( objUrls.isEmpty){
        check_model=true;
      }

    });

print(check_model);
  }

 final List<String> objUrls = [
   'assets/glb/AirCoolant.glb',
   'assets/glb/AirFilter.glb',
   'assets/glb/Battery.glb',
   'assets/glb/Radiator.glb',
  ];
  final List<String> objThumbnails=[
    'AirCoolant',
    'AirFilter',

    'Battery',
    'Radiator',
  ];
  final List<String> images=[
    'assets/image_thumbnail/AirCoolant.png',
     'assets/image_thumbnail/AirFilter.JPG',
         'assets/image_thumbnail/Battery.png',
    'assets/image_thumbnail/Radiator.png',

  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
            '3D Models'
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body:

      Container(
        color: Colors.black,
        child: Center(
          child:GridView.builder(
            itemCount: objUrls.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Scaffold(
                        backgroundColor: Colors.black87,
                        appBar: AppBar(
                          title: Text(objThumbnails[index]),
                          backgroundColor: Colors.black87,
                        ),
                        body: BabylonJSViewer(

                          src: objUrls[index],
                        ),
                      ),
                    ),
                  );
                },
                child:
                Card(
elevation: 5,
                  color: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  child: Center(
                    child: Image.asset(images[index])
                  )
                ),


              );
            },
          ),
          // Column(
          //
          //   children: [
          //     SizedBox(height: 20,),
          //     ImageIcon(AssetImage('assets/file.png'),size:150,color: Colors.grey,),
          //     SizedBox(height: 10,),
          //     Text('No 3D Models found',style: TextStyle(
          //         color: Colors.grey
          //     ),)
          //   ],
          // ),
        ),
      ),
    );
  }
}











