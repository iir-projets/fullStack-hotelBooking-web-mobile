import 'package:flutter/material.dart';
import 'package:hotelbooking/login_screen.dart';
import 'Intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _buttonWidth = 200;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    Color customColor = Color.fromRGBO(169, 77, 123, 1);

    return Scaffold(
      body: Theme(
        data: ThemeData.dark(),
        child: Stack(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/img_2.png'),
                  fit: BoxFit.cover,
                  opacity: 0.7,
                ),
              ),
            ),
            // Center the text
            Positioned(
              top: 0, // Position at the top of the screen
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.30), // Adjust top padding as needed
                child: Column(
                  children: [
                    Text(
                      'LuxeHotel',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 38, // Increase font size for a more prominent effect
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: customColor,
                        shadows: [
                          Shadow(
                            blurRadius: 15, // Adjust the blur radius for a more pronounced shadow
                            color: Colors.white.withOpacity(0.8), // Adjust the opacity and color as needed
                            offset: Offset(2, 0), // Adjust the offset to control the shadow direction
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30), // Add spacing between phrases
                    Text(
                      'Best Hotel deal for your holiday',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5), // Add spacing between phrases
                    Text(
                      'Welcome to our LuxeHotel',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500), // Duration of the animation
                      width: _buttonWidth,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const IntroScreen()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9),
                          child: Text(
                            'Get started',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Roboto',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(customColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        'Already have an account? Log in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
