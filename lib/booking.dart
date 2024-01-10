import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'travel.dart';
import 'login.dart';


class BookingPage extends StatefulWidget {
  final TravelDestination destination;

  BookingPage({required this.destination});
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedDepartureTime = TimeOfDay.now();
  TimeOfDay selectedArrivalTime = TimeOfDay.now();
  String selectedDestination = "";
  String username = "";
  int numberOfPersons = 1;
  int numberOfDays = 1;
  Future<void> _bookTicket() async {
    final String url = "https://aminahaydar.000webhostapp.com/booking.php";
    final response = await http.post(
      Uri.parse(url),
      body: {
        'user_name': username,
        'destination': selectedDestination,
        'number_of_persons': numberOfPersons.toString(),
        'departure_time': selectedDepartureTime.format(context),
        'arrival_time': selectedArrivalTime.format(context),
        'selected_date': selectedDate.toLocal().toString().split(' ')[0],
        'number_of_days': numberOfDays.toString(),
      },
    );

    final data = json.decode(response.body);

    if (data['status']) {
       Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(), // Replace with the actual login page
        ),
      );
      // Booking successful, display confirmation or navigate to a success page
      _showConfirmationDialog();
    } else {
      // Booking failed, show an error message or perform necessary actions
      print(data['message']);
    }
  }


  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isDeparture) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isDeparture ? selectedDepartureTime : selectedArrivalTime,
    );

    if (picked != null) {
      setState(() {
        if (isDeparture) {
          selectedDepartureTime = picked;
        } else {
          selectedArrivalTime = picked;
        }
      });
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Booking Successful"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Name: $username"),
              Text("Number of Persons: $numberOfPersons"),
              Text("Departure Time: ${selectedDepartureTime.format(context)}"),
              Text("Arrival Time: ${selectedArrivalTime.format(context)}"),
              Text("Destination: $selectedDestination"),
              Text("Date: ${selectedDate.toLocal()}"),
              Text("Number of Days: $numberOfDays"),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _resetBooking(); // Reset the booking details
              },
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).hintColor,
              ),
            ),
          ],
        );
      },
    );
  }

  void _resetBooking() {
    setState(() {
      username = "";
      numberOfPersons = 1;
      selectedDate = DateTime.now();
      selectedDepartureTime = TimeOfDay.now();
      selectedArrivalTime = TimeOfDay.now();
      selectedDestination = "";
      numberOfDays = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Your Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Your Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number of Persons',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    numberOfPersons = int.tryParse(value) ?? 1;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter Destination',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    selectedDestination = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Select Date: ${selectedDate.toLocal()}'.split(' ')[0],
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select Date'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => _selectTime(context, true),
                    child: Text('Select Departure Time'),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).hintColor,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectTime(context, false),
                    child: Text('Select Arrival Time'),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number of Days',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    numberOfDays = int.tryParse(value) ?? 1;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Perform booking logic here
                  if (username.isNotEmpty &&
                      selectedDestination.isNotEmpty &&
                      numberOfPersons > 0) {
                    _showConfirmationDialog();
                  } else {
                    // Show an error message or handle accordingly
                    print("Please enter valid information");
                  }
                },
                child: Text('Book Now'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).hintColor,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetBooking,
                child: Text('Reset'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
