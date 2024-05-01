import 'package:flutter/material.dart';
import 'package:hotelbooking/browse_screen.dart';

class CardWithImage extends StatefulWidget {
  const CardWithImage({Key? key}) : super(key: key);

  @override
  _CardWithImageState createState() => _CardWithImageState();
}

class _CardWithImageState extends State<CardWithImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjusted horizontal padding
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
              child: Image.network(
                'https://via.placeholder.com/150',
                height: 90, // Adjusted image height
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.0), // Adjusted padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 16, // Adjusted font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3), // Adjusted height
                  Text(
                    'Subtitle',
                    style: TextStyle(
                      fontSize: 15, // Adjusted font size
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5), // Adjusted height
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12), // Adjusted padding
              child: ElevatedButton(
                onPressed: () {
                  // Add your button action here
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 8, horizontal: 16)), // Adjusted padding
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(169, 77, 123, 1)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text(
                  'Book Now',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "IBM"// Adjusted font size
                  ),
                ),
              ),
            ),
            SizedBox(height: 5), // Adjusted height
          ],
        ),
      ),
    );
  }
}
