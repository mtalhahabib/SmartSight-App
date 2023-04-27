import 'package:flutter/foundation.dart';
class FypProvider with ChangeNotifier{
  double progressValue = 0.0;
  bool showWidget = false;







  void startLoadingAnimation() {

    Future.delayed(Duration(milliseconds: 300), () {

        progressValue += 0.1; // increase progress value by 10%
        if (progressValue < 1.0) {
          startLoadingAnimation(); // continue loading animation
        }
      notifyListeners();

    });
    Future.delayed(Duration(seconds: 2), () {

        showWidget = true;
        notifyListeners();

    });

  }

}