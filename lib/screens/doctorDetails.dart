import 'dart:convert';
import 'package:doctor_appoinment/models/doctor.dart';
import 'package:doctor_appoinment/screens/package.dart';
import 'package:doctor_appoinment/shared/loader.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class DoctorDetails extends StatefulWidget {
  Doctor doc;
  DoctorDetails({super.key, required this.doc});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  Map<String, String> bookingData = {};

  bool showLoader = false;

  Future<Map<String, dynamic>> getData() async {
    final response = await http.get(Uri.parse(
        'https://my-json-server.typicode.com/githubforekam/doctor-appointment/appointment_options'));
    if (response.statusCode == 200) {
      final jsonString = jsonDecode(response.body);
      return jsonString;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Map<DateTime, List<String>> convertData(Map<String, List<String>> inputData) {
    Map<DateTime, List<String>> outputData = {};

    inputData.forEach((dateStr, timeSlots) {
      var date = DateFormat("yyyy-MM-dd").parse(dateStr);

      if (timeSlots.isNotEmpty) {
        List<String> timeIntervals = [];
        for (var slot in timeSlots) {
          var times = slot.split(" - ");
          var startTime = DateFormat("h:mm a").parse(times[0]);
          var endTime = DateFormat("h:mm a").parse(times[1]);

          while (startTime.isBefore(endTime)) {
            timeIntervals.add(DateFormat("h:mm a").format(startTime));
            startTime = startTime.add(const Duration(minutes: 30));
          }
        }
        outputData[date] = timeIntervals;
      } else {
        outputData[date] = [];
      }
    });

    return outputData;
  }

  late Map<DateTime, List<String>> convertedAvailability;

  late DateTime selectedDate = convertedAvailability.keys.first;
  String selectedTime = "";

  @override
  void initState() {
    convertedAvailability = convertData(widget.doc.availability);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (showLoader) {
      return const Loader();
    } else {
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
            "Book Appoinment",
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
                                      NetworkImage(widget.doc.image),
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
                                widget.doc.doctorName,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.doc.speciality,
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
                                  Text(widget.doc.location),
                                  const Icon(
                                    Icons.map_sharp,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.black,
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent.withOpacity(0.2),
                                ),
                                child: const Icon(
                                  IconData(
                                    0xe486,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  color: Colors.blueAccent,
                                ),
                              ),
                              Text(
                                widget.doc.patientsServed.toString() + "+",
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Text(
                                "Patients",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent.withOpacity(0.2),
                                ),
                                child: const Icon(Icons.shopping_bag,
                                    color: Colors.blueAccent),
                              ),
                              Text(
                                widget.doc.yearsOfExperience.toString() + "+",
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Text(
                                "Years Exp.",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent.withOpacity(0.2),
                                ),
                                child: const Icon(Icons.stars,
                                    color: Colors.blueAccent),
                              ),
                              Text(
                                "${widget.doc.rating}+",
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Text(
                                "Rating",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent.withOpacity(0.2),
                                ),
                                // child: Icon(IconData(0xe486, fontFamily: 'MaterialIcons',),color: Colors.blueAccent,),
                                child: const Icon(Icons.message_outlined,
                                    color: Colors.blueAccent),
                              ),
                              Text(
                                widget.doc.numberOfReviews.toString(),
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Text(
                                "Review",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "BOOK APPOINMENT",
                        style: TextStyle(color: Colors.black38),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Day",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 70,
                        // width: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: convertedAvailability.length,
                          itemBuilder: (context, index) {
                            DateTime date =
                                convertedAvailability.keys.elementAt(index);
                            return DateItem(
                              date: date,
                              isSelected: date == selectedDate,
                              onTap: () {
                                setState(() {
                                  selectedDate = date;
                                  selectedTime = '';
                                });
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Time",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              convertedAvailability[selectedDate]?.length == 0
                                  ? 1
                                  : convertedAvailability[selectedDate]?.length,
                          itemBuilder: (context, index) {
                            if (convertedAvailability[selectedDate]?.length ==
                                0) {
                              return Padding(
                                padding: EdgeInsets.only(left: 22),
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(10.0, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "No time slots available, please check on other dates",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            }
                            String time =
                                convertedAvailability[selectedDate]![index];
                            return TimeItem(
                              time: time,
                              isSelected: time == selectedTime,
                              onTap: () {
                                setState(() {
                                  selectedTime = time;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (selectedTime.isEmpty) {
                        Fluttertoast.showToast(msg: "Select a Date and Time");
                      } else {
                        setState(() {
                          showLoader = true;
                        });
                        Map<String, dynamic> data = await getData();
                        bookingData['date'] = selectedDate.toString();
                        bookingData['time'] = selectedTime.toString();
                        if (data.isNotEmpty) {
                          setState(() {
                            showLoader = false;
                          });
                          Navigator.push(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                                builder: (context) => Package(
                                      data: data,
                                      doctor: widget.doc,
                                      bookingData: bookingData,
                                      availability: convertedAvailability,
                                    )),
                          );
                        }
                      }
                    },
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
                    child: const Text(
                      'Make Appointment',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
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

class DateItem extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  DateItem({required this.date, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final month = DateFormat.MMMM().format(date);
    final shortMonth = month.substring(0, 3);
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: isSelected ? Colors.blueAccent : Colors.transparent,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                    color: isSelected ? Colors.blueAccent : Colors.black12),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    DateFormat('E').format(date),
                    style: TextStyle(
                        color: isSelected ? Colors.white70 : Colors.black87,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    '${date.day} ${shortMonth}',
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ), //
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}

class TimeItem extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  TimeItem({required this.time, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (time.isEmpty) {
      return Container(
        child: const Text("No available Slots"),
      );
    } else {
      return Container(
        child: Row(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blueAccent : Colors.transparent,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                      color: isSelected ? Colors.blueAccent : Colors.black12),
                ),
                padding: const EdgeInsets.all(17),
                // color: isSelected ? Colors.blueAccent : Colors.transparent,
                child: Column(
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
      );
    }
  }
}
