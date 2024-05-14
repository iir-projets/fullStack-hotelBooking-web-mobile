import 'dart:convert';
import 'package:flutter/material.dart';

import 'details_room.dart';

class CardWithImage extends StatelessWidget {
  final int roomId; // Add roomId field
  final String roomType;
  final double roomPrice;
  final String roomPhotoBase64;

  const CardWithImage({
    Key? key,
    required this.roomId,
    required this.roomType,
    required this.roomPrice,
    required this.roomPhotoBase64,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: Image.memory(
                base64Decode(roomPhotoBase64),
                height: 150, // Increase the height of the image
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$roomType', // Display roomType
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    '\$${roomPrice.toStringAsFixed(2)}', // Display roomPrice
                    style: TextStyle(
                      fontSize: 18, // Increased font size
                      color: Colors.black, // Darker text color
                      fontWeight: FontWeight.bold, // Bold font weight
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Some room information goes here for the guest to read through', // Repeated phrase
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to another page and pass room information
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookRoomPage(
                        roomId: roomId,
                        roomType: roomType,
                        roomPrice: roomPrice,
                        roomPhotoBase64: roomPhotoBase64,
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(169, 77, 123, 1),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                ),
                child: Text(
                  'Room Details',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "IBM",
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
