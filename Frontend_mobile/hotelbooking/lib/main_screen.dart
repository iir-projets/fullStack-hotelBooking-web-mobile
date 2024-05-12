import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

import 'browse_screen.dart';
import 'card.dart'; // Import your CardWithImage widget

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  List<Room> rooms = []; // List to hold room data

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
    fetchRooms(); // Fetch room data when the screen initializes
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPageView(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Our Rooms',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "IBM",
                ),
              ),
            ),
            _buildCardWithImage(),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Our Services',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "IBM",
                ),
              ),
            ),
            _buildServicesList(),
            SizedBox(height: 20),// Display card with room data
          ],
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return SizedBox(
      height: 450,
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              _buildImageWithText(
                'Welcome to ',
                'LuxeVue Hotel',
                'Escape to Serenity and Luxury Living',
                'images/images.jpeg',
              ),
              _buildImageWithText(
                'Welcome to ',
                'LuxeVue Hotel',
                'Escape to Serenity and Luxury Living',
                'images/img_2.png',
              ),
              _buildImageWithText(
                'Welcome to ',
                'LuxeVue Hotel',
                'Escape to Serenity and Luxury Living',
                'images/img.png',
              ),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: WormEffect(
                dotWidth: 8,
                dotHeight: 8,
                activeDotColor: Color.fromRGBO(169, 77, 123, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildServiceTile("Stay connected with high-speed internet access", Icons.wifi),
        _buildServiceTile("Start your day with a delicious breakfast buffet", Icons.breakfast_dining),
        _buildServiceTile("Keep your clothes clean and fresh with our laundry service", Icons.local_laundry_service),
        _buildServiceTile("Enjoy a refreshing drink or snack from our in-room mini-bar", Icons.local_bar),
        _buildServiceTile("Park your car conveniently in our on-site parking lot", Icons.local_parking),
        _buildServiceTile("Stay cool and comfortable with our air conditioning system", Icons.ac_unit),
      ],
    );
  }

  Widget _buildCardWithImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<List<Room>>(
          future: fetchRooms(), // Fetch room data asynchronously
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Display loading indicator while fetching data
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Display error if fetching data fails
            } else {
              // Display one room card if data is fetched successfully
              final room = snapshot.data!.first; // Get the first room from the list
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardWithImage(
                  roomId: room.id,
                  roomType: room.type,
                  roomPrice: room.price,
                  roomPhotoBase64: room.photoBase64,
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildServiceTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildImageWithText(String prefix, String hotelName, String subtitle, String imagePath) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.4), // Superposition sombre
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prefix,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      hotelName,
                      style: TextStyle(
                        color: Color.fromRGBO(169, 77, 123, 1),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Fetch room data asynchronously
  Future<List<Room>> fetchRooms() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.56.21:9192/rooms/all-rooms'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return responseData.map((data) => Room(
          id: data['id'],
          type: data['roomType'],
          price: data['roomPrice'].toDouble(),
          photoBase64: data['photo'],
        )).toList();
      } else {
        throw Exception('Failed to load rooms');
      }
    } catch (error) {
      throw error;
    }
  }
}
