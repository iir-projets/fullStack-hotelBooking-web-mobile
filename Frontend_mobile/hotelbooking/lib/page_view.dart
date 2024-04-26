import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  final PageViewData imageData;
  const MyPageView({Key? key, required this.imageData}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  double screenWidth = 0.0;
  double screenHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.1), // Spacer
          Container(
            width: screenWidth - 120,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                widget.imageData.assetImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.05), // Spacer
          Container(
            width: screenWidth * 0.8,
            alignment: Alignment.center,
            child: Text(
              widget.imageData.titleText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
                color: Color(0xFF262626),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02), // Spacer
          Container(
            width: screenWidth * 0.8,
            alignment: Alignment.center,
            child: Text(
              widget.imageData.subText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Color(0xFFADADAD),
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.1), // Spacer
        ],
      ),
    );
  }
}

class PageViewData {
  final String titleText;
  final String subText;
  final String assetImage;

  PageViewData({required this.titleText, required this.subText, required this.assetImage});
}
