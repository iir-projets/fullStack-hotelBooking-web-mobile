import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  final HotelListData imageData;
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
      child: Column()
    );
  }
}

class HotelListData {
  final String titleText;
  final String subText;
  final String assetImage;

  HotelListData({required this.titleText, required this.subText, required this.assetImage});
}
