import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'animationPlay.dart';


class AnimationPage extends StatefulWidget {
  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  bool check_animy=true;

  List<String> videoUrls = [
    'https://firebasestorage.googleapis.com/v0/b/fyproject-6e649.appspot.com/o/Animations%2FAirCoolant.mp4?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/fyproject-6e649.appspot.com/o/Animations%2FAirFilter.mp4?alt=media'  ,
    'https://firebasestorage.googleapis.com/v0/b/fyproject-6e649.appspot.com/o/Animations%2FBattery.mp4?alt=media',
    'https://firebasestorage.googleapis.com/v0/b/fyproject-6e649.appspot.com/o/Animations%2FRadiator.mp4?alt=media'

  ];
  List<Future<Uint8List?>> videoThumbnails = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      if( videoUrls.length==0){
        check_animy=false;
      }
    });
    // Load the thumbnails for all videos
    for (String videoUrl in videoUrls) {
      videoThumbnails.add(VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 150,
        maxHeight: 150,
        quality: 25,
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
            'Animations'
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child:GridView.builder(
            itemCount: videoUrls.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VideoPlayerPage(videoUrl: videoUrls[index]),
                    ),
                  );
                },
                child:
                    Card(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.green, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: FutureBuilder(
                        future: videoThumbnails[index],
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Image.memory(snapshot.data);
                          } else {
                            return Center(child: CircularProgressIndicator(color: Colors.white,));
                          }
                        },
                      ),
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
          //     Text('No Animations found',style: TextStyle(
          //         color: Colors.grey
          //     ),),
          //     IconButton(onPressed:  () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (_) =>Placeholder() //PlayFileScreen(file: file),
          //         ),
          //       );
          //     }, icon: Icon(Icons.play_circle,color: Colors.white,))
          //   ],
          // ),
        ),
      ),
    );
  }
}
