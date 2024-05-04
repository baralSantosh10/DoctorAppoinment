import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../models/doctor.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class MyBookings extends StatefulWidget {
  List<dynamic> httpMyBookings;
  List<Doctor> doctors;
  MyBookings({super.key, required this.httpMyBookings, required this.doctors});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  String findImageUrl(String doc_name) {
    for (Doctor doctorInfo in widget.doctors) {
      if (doctorInfo.doctorName == doc_name) {
        return doctorInfo.image;
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
          "My Bookings",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              //
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Divider(
                    height: 1,
                    color: Colors.black38,
                  ),
                ),
                Container(
                  height: screenSize.height - 110,
                  child: ListView.builder(
                    itemCount: widget.httpMyBookings.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              const BoxShadow(
                                color: Colors.grey,
                                blurRadius: 1.0,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${DateFormat('MMM d, y').format(DateTime.parse(widget.httpMyBookings[index]['appointment_date']!))} - ${widget.httpMyBookings[index]['appointment_time'].split('-').first.trim()}',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    height: 5,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Card(
                                          elevation: 2,
                                          child: Image(
                                            image: NetworkImage(
                                                '${findImageUrl(widget.httpMyBookings[index]['doctor_name'])}'),
                                            height: 100,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            widget.httpMyBookings[index]
                                                ['doctor_name'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.location_on_rounded,
                                                color: Colors.blueAccent,
                                                size: 25,
                                              ),
                                              Text(
                                                widget.httpMyBookings[index]
                                                    ['location'],
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.badge_outlined,
                                                color: Colors.blueAccent,
                                                size: 26,
                                              ),
                                              Text(
                                                "Booking ID : ",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                widget.httpMyBookings[index]
                                                    ['booking_id'],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.blueAccent,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    height: 5,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {},
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueAccent),
                                        ),
                                        style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all<Size?>(
                                                  const Size(160, 50)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.blue[100]),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          )),
                                          elevation:
                                              MaterialStateProperty.all(1.0),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {},
                                        child: const Text(
                                          'Reschedule ',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        style: ButtonStyle(
                                          minimumSize:
                                              MaterialStateProperty.all<Size?>(
                                                  const Size(160, 50)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.blueAccent),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          )),
                                          elevation:
                                              MaterialStateProperty.all(1.0),
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
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
