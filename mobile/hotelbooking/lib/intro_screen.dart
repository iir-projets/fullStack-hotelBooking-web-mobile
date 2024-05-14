import 'dart:async';
import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'login_screen.dart';
import 'page_view.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewModelData = [];
  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData.add(PageViewData(
        titleText: 'Plan your Vacation',
        subText: "Let's plan your vacation and choose the perfect room for you",
        assetImage: 'images/introduction1.png'));
    pageViewModelData.add(PageViewData(
        titleText: 'Find best deals',
        subText: 'Explore a myriad of enticing deals tailored for every season at our hotel',
        assetImage: 'images/introduction2.png'));
    pageViewModelData.add(PageViewData(
        titleText: 'Plan your Trips',
        subText: 'Book one of our exquisite rooms at our unique hotel, renowned for offering the finest accommodations',
        assetImage: 'images/intro.png'));

    sliderTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (currentShowIndex == 0) {
        pageController.animateTo(MediaQuery.of(context).size.width,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 1) {
        pageController.animateTo(MediaQuery.of(context).size.width * 2,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 2) {
        pageController.animateTo(0,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              pageSnapping: true,
              onPageChanged: (index) {
                currentShowIndex = index;
              },
              scrollDirection: Axis.horizontal,
              children: [
                MyPageView(imageData: pageViewModelData[0]),
                MyPageView(imageData: pageViewModelData[1]),
                MyPageView(imageData: pageViewModelData[2]),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.05),
            child: SmoothPageIndicator(
              controller: pageController,
              count: pageViewModelData.length,
              effect: WormEffect(
                activeDotColor: Color(0xFF262626),
                dotColor: Color.fromRGBO(169, 77, 123, 1),
                dotHeight: 10.0,
                dotWidth: 10.0,
                spacing: 5.0,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Color.fromRGBO(169, 77, 123, 1)),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
