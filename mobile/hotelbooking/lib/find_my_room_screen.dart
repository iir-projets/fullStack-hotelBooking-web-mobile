import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FindRoomScreen extends StatefulWidget {
  const FindRoomScreen({Key? key}) : super(key: key);

  @override
  _FindRoomScreenState createState() => _FindRoomScreenState();
}

class _FindRoomScreenState extends State<FindRoomScreen> {
  String bookingConfirmationCode = '';
  String? bookingDetails;
  bool isLoading = false;

  Future<void> findBooking() async {
    setState(() {
      isLoading = true;
    });

    try {
      final encodedConfirmationCode = Uri.encodeComponent(bookingConfirmationCode);
      final response = await http.get(Uri.parse('http://192.168.56.21:9192/bookings/confirmation/$encodedConfirmationCode'));

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        setState(() {
          bookingDetails = response.body;
        });
      } else {
        setState(() {
          bookingDetails = 'Booking not found';
        });
        // Afficher la boîte de dialogue
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Information'),
              content: Text('No booking found with the provided confirmation code.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      setState(() {
        bookingDetails = 'Error occurred: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> cancelBooking(BuildContext context, int bookingId) async {
    try {
      final response = await http.delete(Uri.parse('http://192.168.56.21:9192/bookings/booking/$bookingId/delete'));

      if (response.statusCode == 200) {
        // Handle successful cancellation
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Booking $bookingId cancelled successfully.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Handle cancellation failure
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to cancel booking $bookingId. Status code: ${response.statusCode}'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle cancellation error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error cancelling booking $bookingId: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  Map<String, dynamic>? parseBookingDetails(String? bookingDetails) {
    if (bookingDetails == null || bookingDetails.isEmpty) {
      return null;
    }
    try {
      return json.decode(bookingDetails);
    } catch (e) {
      print('Error parsing booking details: $e');
      return null;
    }
  }

  Widget buildBookingInformation(Map<String, dynamic>? bookingDetails) {
    if (bookingDetails == null) {
      return Text('Détails de la réservation non disponibles');
    }

    final Map<String, dynamic>? room = bookingDetails['room'];
    final int? bookingId = bookingDetails['id'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRow('Code de confirmation', bookingDetails['bookingConfirmationCode']),
        _buildRow('Numéro de chambre', room?['id']),
        _buildRow('Type de chambre', room?['roomType']),
        _buildRow('Date d\'arrivée', bookingDetails['checkInDate']),
        _buildRow('Date de départ', bookingDetails['checkOutDate']),
        _buildRow('Nom complet', bookingDetails['guestFullName']),
        _buildRow('Adresse e-mail', bookingDetails['guestEmail']),
        _buildRow('Adultes', bookingDetails['numOfAdults']),
        _buildRow('Enfants', bookingDetails['numOfChildren']),
        _buildRow('Nombre total de clients', bookingDetails['totalNumOfGuests']),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (bookingId != null) {
              cancelBooking(context, bookingId).then((_) {
                setState(() {
                  // Réinitialiser les données de la réservation
                  bookingConfirmationCode = '';
                  bookingDetails = null;
                  isLoading = false;
                });
              });
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: Text(
            'Cancel Booking',
            style: TextStyle(
              fontSize: 15,
              fontFamily: "IBM",
            ),
          ),
        ),


      ],
    );
  }
  Widget _buildRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 5),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
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
                          bookingConfirmationCode = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Booking Confirmation Code',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: ElevatedButton(
                        onPressed: isLoading ? null : findBooking,
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(169, 77, 123, 1)),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text(
                          'Find Booking',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "IBM",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    buildBookingInformation(parseBookingDetails(bookingDetails)),
                    SizedBox(height: 30), // Add extra spacing at the bottom
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
