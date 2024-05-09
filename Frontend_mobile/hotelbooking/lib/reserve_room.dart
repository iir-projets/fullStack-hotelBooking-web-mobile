import 'package:flutter/material.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  String fullName = '';
  String email = '';
  late DateTime checkInDate = DateTime.now();
  late DateTime checkOutDate = DateTime.now();
  int numberOfAdults = 1;
  int numberOfChildren = 0;

  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _fullNameFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reservation',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'IBM',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBM',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                focusNode: _fullNameFocusNode,
                onChanged: (value) {
                  setState(() {
                    fullName = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _fullNameFocusNode.hasFocus ? Color.fromRGBO(169, 77, 123, 1) : Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBM',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                focusNode: _emailFocusNode,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _emailFocusNode.hasFocus ? Color.fromRGBO(169, 77, 123, 1) : Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Check-in Date',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBM',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Color.fromRGBO(169, 77, 123, 1),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null && picked != checkInDate) {
                    setState(() {
                      checkInDate = picked;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(169, 77, 123, 1),
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      checkInDate == null
                          ? 'Select Check-in Date'
                          : '${checkInDate.year}-${checkInDate.month}-${checkInDate.day}',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Check-out Date',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBM',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Color.fromRGBO(169, 77, 123, 1),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null && picked != checkOutDate) {
                    setState(() {
                      checkOutDate = picked;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(169, 77, 123, 1),
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      checkOutDate == null
                          ? 'Select Check-out Date'
                          : '${checkOutDate.year}-${checkOutDate.month}-${checkOutDate.day}',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Number of Adults',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBM',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (numberOfAdults > 1) numberOfAdults--;
                      });
                    },
                  ),
                  Text('$numberOfAdults'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        numberOfAdults++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Number of Children',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'IBM',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (numberOfChildren > 0) numberOfChildren--;
                      });
                    },
                  ),
                  Text('$numberOfChildren'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        numberOfChildren++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Implement your logic here to find the booking
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 9, horizontal: 100),
                    ), // Adjusted padding
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Color.fromRGBO(169, 77, 123, 1)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    'Continue',
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
    );
  }
}
