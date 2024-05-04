import 'package:doctor_appoinment/screens/review_summary.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../models/doctor.dart';

// ignore: must_be_immutable
class Package extends StatefulWidget {
  Map<DateTime, List<String>> availability;
  Map<String, dynamic> data;
  Map<String, String> bookingData;
  Doctor doctor;
  Package(
      {super.key,
      required this.data,
      required this.doctor,
      required this.bookingData,
      required this.availability});

  @override
  State<Package> createState() => _PackageState();
}

class _PackageState extends State<Package> {
  List<String> duration = [];
  List<String> pack = [];
  late String selectedDuration = duration[0];

  late String selectedPackage = pack[0];

  void setselectedPackage(String value) {
    setState(() {
      selectedPackage = value;
    });
  }

  convertData() {
    duration = List<String>.from(widget.data['duration']);
    pack = List<String>.from(widget.data['package']);
  }

  @override
  void initState() {
    convertData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          "Select Package",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Duration",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      items: duration
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_filled_rounded,
                                      size: 25,
                                      color: Colors.blueAccent,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      '${item}ute',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                      value: selectedDuration,
                      onChanged: (value) {
                        setState(() {
                          selectedDuration = value!;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        height: 50,
                        width: 350,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                        ),
                        iconSize: 35,
                        iconEnabledColor: Colors.blueAccent,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility: MaterialStateProperty.all(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Select Package",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 400,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin:
                            const EdgeInsets.all(8.0), // Add margin for spacing
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 1.0,
                            ),
                          ],
                        ),

                        child: RadioListTile(
                          value: pack[0],
                          groupValue: selectedPackage,
                          onChanged: (value) {
                            setselectedPackage(value!);
                          },
                          title: Text(
                            pack[0],
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                          subtitle: const Text('Chat with Doctor'),
                          secondary: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blueAccent.withOpacity(0.2),
                            ),
                            child: const Icon(
                              Icons.message_rounded,
                              color: Colors.blueAccent,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8.0),
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
                        child: RadioListTile(
                          value: pack[1],
                          groupValue: selectedPackage,
                          onChanged: (value) {
                            setselectedPackage(value!);
                          },
                          title: Text(
                            pack[1],
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                          subtitle: const Text('Voice call with doctor'),
                          secondary: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blueAccent.withOpacity(0.2),
                            ),
                            child: const Icon(
                              Icons.call,
                              color: Colors.blueAccent,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.all(8.0), // Add margin for spacing
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

                        child: RadioListTile(
                          value: pack[2],
                          groupValue: selectedPackage,
                          onChanged: (value) {
                            setselectedPackage(value!);
                          },
                          title: Text(
                            pack[2],
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                          subtitle: const Text('Video call with doctor'),
                          secondary: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blueAccent.withOpacity(0.2),
                            ),
                            child: const Icon(
                              Icons.video_call,
                              color: Colors.blueAccent,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8.0),
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
                        child: RadioListTile(
                          value: pack[3],
                          groupValue: selectedPackage,
                          onChanged: (value) {
                            setselectedPackage(value!);
                          },
                          title: Text(
                            pack[3],
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                          subtitle: const Text('In Person visit with doctor'),
                          secondary: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blueAccent.withOpacity(0.2),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.blueAccent,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                      ),
                      // Add more RadioListTile widgets as needed.
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    widget.bookingData['duration'] =
                        selectedDuration.toString();
                    widget.bookingData['package'] = selectedPackage.toString();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReviewBooking(
                                doctor: widget.doctor,
                                bookingData: widget.bookingData,
                                availability: widget.availability,
                              )),
                    );
                  },
                  child: const Text(
                    'Next',
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
}
