import 'dart:convert';
import 'package:doctor_appoinment/screens/doctorList.dart';
import 'package:doctor_appoinment/screens/my_bookings.dart';
import 'package:doctor_appoinment/shared/loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_appoinment/models/doctor.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showLoader = false;

  List<Doctor> doctors = [];

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (showLoader) {
      return const Loader();
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(
                size.width * 0.1, size.height * 0.30, size.width * 0.1, 0.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Welcome to Doctor Appoinment Booking",
                    style: GoogleFonts.robotoSerif(
                        fontSize: 40.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        showLoader = true;
                      });
                      doctors = await getDoctors();
                      if (doctors.isEmpty) {
                        
                      } else {
                        setState(() {
                          showLoader = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctorList(
                                      docs: doctors,
                                    )));
                      }
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size?>(const Size(200, 50)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                      elevation: MaterialStateProperty.all(1.0),
                    ),
                    child: const Text(
                      'Book appoinment',
                      style: TextStyle(
                          fontSize: 17,color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                      'My bookings',
                      style: TextStyle(
                        color: Colors.white,
                          fontSize: 17, fontWeight: FontWeight.normal),
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size?>(const Size(200, 50)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                      elevation: MaterialStateProperty.all(1.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
