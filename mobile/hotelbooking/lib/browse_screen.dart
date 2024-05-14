import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'card.dart';

// Room class definition
class Room {
  final int id; // Add id field
  final String type;
  final double price;
  final String photoBase64;

  Room({
    required this.id,
    required this.type,
    required this.price,
    required this.photoBase64,
  });
}

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  List<Room> rooms = [];
  List<String> roomTypes = [];
  String? selectedRoomType;

  @override
  void initState() {
    super.initState();
    fetchRoomTypes();
    selectedRoomType = null; // Initially set to null to load all room types
    fetchRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Browse Rooms',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'IBM',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(169, 77, 123, 1),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: DropdownButton<String>(
                value: selectedRoomType,
                hint: Text('Select room type'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRoomType = newValue;
                    fetchRooms(); // Refresh rooms based on the selected type
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'IBM',
                  fontWeight: FontWeight.normal,
                ),
                underline: Container(
                  height: 2,
                ),
                icon: Icon(Icons.arrow_drop_down),
                elevation: 4,
                isExpanded: true,
                items: [
                  DropdownMenuItem<String>(
                    value: null,
                    child: Text(
                      'All Room Types',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'IBM',
                      ),
                    ),
                  ),
                  ...roomTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: rooms.isNotEmpty
                  ? ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  return CardWithImage(
                    roomId: rooms[index].id, // Pass roomId
                    roomType: rooms[index].type,
                    roomPrice: rooms[index].price,
                    roomPhotoBase64: rooms[index].photoBase64,
                  );
                },
              )
                  : CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  void fetchRoomTypes() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.56.21:9192/rooms/room/types'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          roomTypes = responseData.cast<String>();
        });
      } else {
        throw Exception('Failed to load room types');
      }
    } catch (error) {
      print(error);
    }
  }

  void fetchRooms() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.56.21:9192/rooms/all-rooms'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          rooms = responseData.map((data) => Room(
            id: data['id'], // Parse and set the id
            type: data['roomType'],
            price: data['roomPrice'].toDouble(),
            photoBase64: data['photo'], // Change 'photoUrl' to 'photoBase64'
          )).where((room) => selectedRoomType == null || room.type == selectedRoomType).toList();
        });
      } else {
        throw Exception('Failed to load rooms');
      }
    } catch (error) {
      print(error);
    }
  }

  // Method to book a room
  void bookRoom(int roomId) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:9192/rooms/room/$roomId'));
      if (response.statusCode == 200) {
        // Process the response, for example, display room details in a dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Room Details'),
              content: Text(response.body), // Display room details here
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      } else {
        throw Exception('Failed to load room details');
      }
    } catch (error) {
      print(error);
    }
  }
}
