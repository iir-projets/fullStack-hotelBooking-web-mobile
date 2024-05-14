import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:hotelbooking/find_my_room_screen.dart';

import 'browse_screen.dart';
import 'main_screen.dart';
import 'profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List Screens = [
    MainScreen(),
    ProfileScreen(),
    FindRoomScreen(),
    BrowseScreen(),
  ];
  int _currentIndex = 0; // Initial index for the home icon

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Color iconColor = Colors.white;

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color.fromRGBO(169, 77, 123, 1),
        color: Color.fromRGBO(169, 77, 123, 1), // Custom color for the selected item
        animationDuration: Duration(milliseconds: 300),
        index: _currentIndex, // Set the initial index
        onTap: (index) {
          setState(() {
             _currentIndex= index;
          });
        },
        items: <CurvedNavigationBarItem>[
          CurvedNavigationBarItem(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                iconColor,
                BlendMode.srcIn,
              ),
              child: Icon(Icons.home),
            ),
          ),
          CurvedNavigationBarItem(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                iconColor,
                BlendMode.srcIn,
              ),
              child: Icon(Icons.person_sharp),
            ),
          ),
          CurvedNavigationBarItem(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                iconColor,
                BlendMode.srcIn,
              ),
              child: Icon(Icons.event_note),
            ),
          ),
          CurvedNavigationBarItem(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                iconColor,
                BlendMode.srcIn,
              ),
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Screens[_currentIndex],
    );
  }
}
