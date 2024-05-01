import 'package:flutter/material.dart';

class FindRoomScreen extends StatefulWidget {
  const FindRoomScreen({Key? key}) : super(key: key);

  @override
  _FindRoomScreenState createState() => _FindRoomScreenState();
}

class _FindRoomScreenState extends State<FindRoomScreen> {
  String bookingCode = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 90), // Adjusted top spacing
          Padding(
            padding: const EdgeInsets.only(left: 20.0), // Adjusted left padding
            child: Text(
              'Find My Booking',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'IBM',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Container(
              width: screenWidth * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enter the booking confirmation code',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        bookingCode = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Booking Confirmation Code',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12), // Adjusted padding
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement your logic here to find the booking
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        ), // Adjusted padding
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Color.fromRGBO(169, 77, 123, 1)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text(
                        'Find Booking',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "IBM", // Adjusted font size
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
