import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';

class MyLoadingScreen extends StatefulWidget {
  @override
  _MyLoadingScreenState createState() => _MyLoadingScreenState();
}

class _MyLoadingScreenState extends State<MyLoadingScreen> {
  double _progressValue = 0.0; // initial progress value
  bool _showWidget = false;

  @override
  void initState() {
    super.initState();
    startLoadingAnimation();
    homeScreen();
  }

  void homeScreen(){
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  // simulate loading progress by increasing progress value over time
  void startLoadingAnimation() {

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _progressValue += 0.1; // increase progress value by 10%
        if (_progressValue < 1.0) {
          startLoadingAnimation(); // continue loading animation
        }
      });

    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _showWidget = true;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    final textWidth = MediaQuery
        .of(context)
        .size
        .width * 0.45; // calculate text width

    return Scaffold(
      backgroundColor: Colors.black87, // set background color to black87
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

      AnimatedOpacity(opacity: _showWidget ? 1.0 : 0.0,
              duration: Duration(seconds: 3),
              child: SvgPicture.asset('assets/Vector.svg'),),

              SizedBox(height: 18,),
              Container(
                width: textWidth,
                height: 6.5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    // set background color of progress bar
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.green, // set color of border
                      width: 1.0, // set width of border
                    ) // make the corners rounded
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: _progressValue * textWidth,
                        decoration: BoxDecoration(
                          color: Colors.green, // set color of progress bar
                          borderRadius: BorderRadius.circular(
                              5.0), // make the corners rounded
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'SmartSight',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 18.0,
                  color: Colors.white, // set color of text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}