import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  final String _imagePath;
  final String name;

  const ImagePage(this._imagePath,this.name);


  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        title: Text(widget.name,style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 15,
        fontStyle: FontStyle.italic,
    ),),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(File(widget._imagePath)),
        ],
      ),
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
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:Colors.green,
      ),
      height:40,

      width:70,

      child: IconButton(
        onPressed:(){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                    content: SizedBox(
                      height: 40,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Processing Image'),
                          SizedBox(width: 10,),
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(

                              strokeWidth: 2,
                              color: Colors.white,

                            ),
                          ),

                        ],
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    elevation: 0,
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    margin: EdgeInsets.only(bottom:560 , left: 100, right: 100),
                    padding: EdgeInsets.zero,
                  )
          ).closed.then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: SizedBox(
                height: 40,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Image Processed'),
                    Icon(Icons.done,color: Colors.white,)

                  ],
                ),
              ),
                behavior: SnackBarBehavior.floating,
                elevation: 0,
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),

                ),
                margin: EdgeInsets.only(bottom:560 , left: 100, right: 100),
                padding: EdgeInsets.zero,
              ),
            );
          });
      //
      }, icon: Icon(Icons.done),color: Colors.white,)),
)

            ],
          ),
        ),
      ),

    );
  }
}

