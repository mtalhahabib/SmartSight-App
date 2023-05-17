
import 'package:flutter/material.dart';
class labelPage extends StatelessWidget {
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
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(

            children: [
              SizedBox(height: 20,),
              ImageIcon(AssetImage('assets/file.png'),size:150,color: Colors.grey,),
              SizedBox(height: 10,),
              Text('No labelled images found',style: TextStyle(
                  color: Colors.grey
              ),)
            ],
          ),
        ),
      ),
    );
  }
}


