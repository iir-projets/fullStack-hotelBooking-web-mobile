import 'package:flutter/material.dart';

class Room {
  final String name;
  final String type;

  Room({required this.name, required this.type});
}

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  // Sample room data
  final List<Room> rooms = [
    Room(name: 'Room 1', type: 'Single'),
    Room(name: 'Room 2', type: 'Double'),
    Room(name: 'Room 3', type: 'Single'),
    Room(name: 'Room 4', type: 'Suite'),
  ];

  // Variables for filtering
  String selectedType = 'All'; // Default to show all rooms
  List<Room> filteredRooms = [];

  @override
  void initState() {
    super.initState();
    filteredRooms = List.from(rooms); // Initialize filteredRooms with all rooms
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 90), // Adjusted top spacing
          Padding(
            padding: const EdgeInsets.only(left: 20.0), // Adjusted left padding
            child: Text(
              'Browse Rooms',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'IBM',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20), // Added spacing between title and dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(169, 77, 123, 1), // Définir la couleur de la bordure
                  width: 2.0, // Définir la largeur de la bordure
                ),
                borderRadius: BorderRadius.circular(20.0), // Définir le rayon de la bordure
              ),
              child: DropdownButton<String>(
                value: selectedType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedType = newValue!;
                    filterRooms();
                  });
                },
                items: <String>['All', 'Single', 'Double', 'Suite']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'IBM',
                      ),
                    ),
                  );
                }).toList(),
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'IBM',
                  fontWeight: FontWeight.w800, // Définir le poids de la police
                  color: Colors.black, // Définir la couleur du texte
                ),
                iconEnabledColor: Color.fromRGBO(169, 77, 123, 1), // Définir la couleur de l'icône
                dropdownColor: Colors.white, // Définir la couleur d'arrière-plan du menu déroulant
                elevation: 4, // Définir l'élévation du menu déroulant
                borderRadius: BorderRadius.circular(20), // Définir le rayon de la bordure
              ),
            ),
          ),
          SizedBox(height: 20), // Added spacing between dropdown and body
          Expanded(
            child: Center(
              child: Text("Body"),
            ),
          ),
        ],
      ),
    );
  }

  // Function to filter rooms based on selected type
  void filterRooms() {
    if (selectedType == 'All') {
      filteredRooms = List.from(rooms); // Show all rooms
    } else {
      filteredRooms =
          rooms.where((room) => room.type == selectedType).toList();
    }
  }
}
