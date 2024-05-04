import 'package:doctor_appoinment/models/doctor.dart';
import 'package:doctor_appoinment/screens/doctorDetails.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

// ignore: must_be_immutable
class DoctorList extends StatefulWidget {
  List<Doctor> docs = [];
  DoctorList({super.key, required this.docs});

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
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
          "Select a Doctor",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: widget.docs.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                         BoxShadow(
                          color: Colors.grey,
                          blurRadius:
                              1.0, // Adjust the blur radius to control elevation
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: FadeInImage.assetNetwork(
                            placeholder:
                                'lib/assets/load.gif', // Placeholder image (local asset)
                            image: widget
                                .docs[index].image, // Actual network image URL
                            fit: BoxFit.cover, // Adjust the fit as needed
                          ),

                          title: Text(
                            widget.docs[index].doctorName,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(widget.docs[index].speciality),
                          // trailing: Text('${widget.docs[index].rating.toString()} ${Icons.star}'),
                          trailing: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.docs[index].rating.toString(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const WidgetSpan(
                                  child: Icon(
                                    Icons.star,
                                    size: 17,
                                    color: Colors.amber,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoctorDetails(
                                          doc: widget.docs[index],
                                        )));
                          },
                          child: const Text(
                            'Book ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                          ),
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size?>(
                                const Size(160, 50)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueAccent),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            )),
                            elevation: MaterialStateProperty.all(1.0),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
