import 'dart:convert';
import 'package:flutter/material.dart';
import 'reserve_room.dart'; // Assuming you have a file named 'reserve_room.dart' for ReservationPage

class BookRoomPage extends StatelessWidget {
  final int roomId;
  final String roomType;
  final double roomPrice;
  final String roomPhotoBase64;

  const BookRoomPage({
    Key? key,
    required this.roomId,
    required this.roomType,
    required this.roomPrice,
    required this.roomPhotoBase64,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Room Details',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Room Type: $roomType',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Price per night: \$${roomPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Image.memory(
                base64Decode(roomPhotoBase64),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                'Room Services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // List of room services with icons
              ListTile(
                leading: Icon(Icons.wifi),
                title: Text('Wifi'),
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text('Netflix Premium'),
              ),
              ListTile(
                leading: Icon(Icons.free_breakfast),
                title: Text('Breakfast'),
              ),
              ListTile(
                leading: Icon(Icons.kitchen),
                title: Text('Mini bar refreshment'),
              ),
              ListTile(
                leading: Icon(Icons.local_taxi),
                title: Text('Car Service'),
              ),
              ListTile(
                leading: Icon(Icons.local_parking),
                title: Text('Parking Space'),
              ),
              ListTile(
                leading: Icon(Icons.local_laundry_service),
                title: Text('Laundry'),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the ReservationPage and pass the roomId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReservationPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "IBM",
                    ),
                  ),
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
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
