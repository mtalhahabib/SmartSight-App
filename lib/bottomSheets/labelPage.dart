
import 'package:flutter/material.dart';
class labelPage extends StatelessWidget {
  final List<String> images=[
    'assets/image_thumbnail/AirCoolant.png',
    'assets/image_thumbnail/AirFilter.JPG',
    'assets/image_thumbnail/Battery.png',
    'assets/image_thumbnail/Radiator.png',

  ];
  final List<String> objThumbnails=[
    'AirCoolant',
    'AirFilter',

    'Battery',
    'Radiator',
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
         'Labelled Images'
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
            itemCount: images.length,
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
                        body: Center(child: Image.asset(images[index]))
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

      // Container(
      //   color: Colors.black,
      //   child: Center(
      //     child: Column(
      //
      //       children: [
      //         SizedBox(height: 20,),
      //         ImageIcon(AssetImage('assets/file.png'),size:150,color: Colors.grey,),
      //         SizedBox(height: 10,),
      //         Text('No labelled images found',style: TextStyle(
      //             color: Colors.grey
      //         ),)
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}


