import 'dart:convert';
import 'package:doctor_appoinment/models/doctor.dart';
import 'package:doctor_appoinment/screens/my_bookings.dart';
import 'package:doctor_appoinment/shared/loader.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Confirmation extends StatefulWidget {
  Doctor doctor;
  Map<String, dynamic> httpBookingData;

  Confirmation(
      {super.key, required this.httpBookingData, required this.doctor});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  List<Doctor> doctors = [];

  Future<List<Doctor>> getDoctors() async {
    final response = await http.get(Uri.parse(
        'https://my-json-server.typicode.com/githubforekam/doctor-appointment/doctors'));
    if (response.statusCode == 200) {
      List<Doctor> doctors = [];
      final json = jsonDecode(response.body);
      for (var doctor in json) {
        doctors.add(Doctor.fromJson(doctor));
      }
      return doctors;
    } else {
      throw Exception('Failed to fetch doctors');
    }
  }

  bool showLoader = false;

  Future<List<dynamic>> getData() async {
    final response = await http.get(Uri.parse(
        'https://my-json-server.typicode.com/githubforekam/doctor-appointment/appointments'));
    if (response.statusCode == 200) {
      final jsonString = jsonDecode(response.body);
      return jsonString;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showLoader) {
      return Loader();
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Symbols.arrow_circle_left_rounded,
            weight: 300,
            size: 45,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Confirmation",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Colors.blueAccent,
                        size: 150,
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Text(
                        "Appoinment confirmed!",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Text(
                        "You have successfully booked appoinment with",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.httpBookingData['doctor_name'],
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Row(
                        children: List.generate(
                            300 ~/ 10,
                            (index) => Expanded(
                                  child: Container(
                                    color: index % 2 == 0
                                        ? Colors.transparent
                                        : Colors.black12,
                                    height: 1,
                                  ),
                                )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Colors.blueAccent,
                          size: 30,
                        ),
                        Text(
                          widget.httpBookingData['location'],
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.blueAccent,
                          size: 30,
                        ),
                        Text(
                          '${DateFormat('dd MMM, yyyy').format(DateTime.parse(widget.httpBookingData['appointment_date']))}',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 57,
                        ),
                        Icon(
                          Icons.timer,
                          color: Colors.blueAccent,
                          size: 30,
                        ),
                        Text(
                          widget.httpBookingData['appointment_time']
                              .split('-')
                              .first
                              .trim(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 140,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          showLoader = true;
                        });
                        List<dynamic> data = await getData();
                        doctors = await getDoctors();

                        if (data.isNotEmpty) {
                          setState(() {
                            showLoader = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyBookings(
                                        httpMyBookings: data,
                                        doctors: doctors,
                                      )));
                        }
                      },
                      child: const Text(
                        'View Appointments',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size?>(
                            const Size(350, 60)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueAccent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                        elevation: MaterialStateProperty.all(2.0),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);

                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Book Another',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size?>(
                            const Size(350, 60)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )),
                        // elevation: MaterialStateProperty.all(2.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
