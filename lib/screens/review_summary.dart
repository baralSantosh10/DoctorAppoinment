import 'package:doctor_appoinment/models/doctor.dart';
import 'package:doctor_appoinment/screens/confirmation.dart';
import 'package:doctor_appoinment/shared/loader.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ReviewBooking extends StatefulWidget {
  Map<DateTime, List<String>> availability;
  Doctor doctor;
  Map<String, String> bookingData;
  ReviewBooking(
      {super.key,
      required this.doctor,
      required this.bookingData,
      required this.availability});

  @override
  State<ReviewBooking> createState() => _ReviewBookingState();
}

class _ReviewBookingState extends State<ReviewBooking> {
  bool showLoader = false;

  Future<Map<String, dynamic>> getData() async {
    final response = await http.get(Uri.parse(
        'https://my-json-server.typicode.com/githubforekam/doctor-appointment/booking_confirmation'));
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
          "Review Summary",
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 115,
                          width: 115,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(widget.doctor.image),
                              ),
                              Positioned(
                                  bottom: -5,
                                  right: -35,
                                  child: RawMaterialButton(
                                    onPressed: () {},
                                    elevation: 2.0,
                                    child: const Icon(
                                      Icons.verified,
                                      color: Colors.blueAccent,
                                      size: 30,
                                    ),
                                    padding: const EdgeInsets.all(15.0),
                                    shape: const CircleBorder(),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(width: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.doctor.doctorName,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.doctor.speciality,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.blueAccent,
                                ),
                                Text(widget.doctor.location),
                                const Icon(
                                  Icons.map_sharp,
                                  color: Colors.blueAccent,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                      height: 40,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date & Hour",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${DateFormat('MMMM d, y').format(DateTime.parse(widget.bookingData['date']!))} | ${widget.bookingData['time']}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                PopupMenuButton<String>(
                                  icon: Icon(Icons.edit),
                                  onSelected: (value) {
                                    setState(() {
                                      List<String> parts = value.split(" | ");

                                      if (parts.length == 2) {
                                        // Parse the date part
                                        widget.bookingData['date'] =
                                            DateFormat('MMMM d, y')
                                                .parse(parts[0])
                                                .toString();

                                        widget.bookingData['time'] = parts[1];
                                      }
                                    });
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return _buildPopupItems();
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Package",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                Text(widget.bookingData['package']!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                PopupMenuButton(
                                    onSelected: (value) {
                                      setState(() {
                                        widget.bookingData['package'] = value;
                                      });
                                    },
                                    icon: Icon(Icons.edit),
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: 'Messaging',
                                          child: Text('Messaging'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'Voice Call',
                                          child: Text('Voice Call'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'Video Call',
                                          child: Text('Video Call'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'In Person',
                                          child: Text('In Person'),
                                        ),
                                      ];
                                    })
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Duration",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                Text(widget.bookingData['duration']! + "utes",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                PopupMenuButton(
                                    onSelected: (value) {
                                      setState(() {
                                        widget.bookingData['duration'] = value;
                                      });
                                    },
                                    icon: Icon(Icons.edit),
                                    itemBuilder: (BuildContext context) {
                                      return <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: '30 min',
                                          child: Text('30 minutes'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: '60 min',
                                          child: Text('60 minutes'),
                                        ),
                                      ];
                                    })
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Booking for",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                Text('self',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.edit),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 220,
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
                    Map<String, dynamic> data = await getData();
                    if (data.isNotEmpty) {
                      setState(() {
                        showLoader = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Confirmation(
                                  httpBookingData: data,
                                  doctor: widget.doctor,
                                )),
                      );
                    }
                  },
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size?>(const Size(350, 60)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
                    elevation: MaterialStateProperty.all(2.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<PopupMenuItem<String>> _buildPopupItems() {
    List<PopupMenuItem<String>> items = [];
    final dateFormat = DateFormat('MMMM d, y');
    widget.availability.forEach((date, times) {
      for (String time in times) {
        String formattedDate = dateFormat.format(date);
        String optionText = '$formattedDate | $time';
        items.add(
          PopupMenuItem<String>(
            value: optionText,
            child: Text(optionText),
          ),
        );
      }
    });
    return items;
  }
}
