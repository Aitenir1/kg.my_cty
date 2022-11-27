// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_city/models/report.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class MyBottomSheet extends StatefulWidget {
  final LatLng location;
  const MyBottomSheet({super.key, required this.location});

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  final ImagePicker _picker = ImagePicker();

  File? problemImage;

  void addImageFromGallery() async {
    // print(ImageSource.gallery.name);
    try {
      var img = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (img != null) {
          problemImage = File(img.path);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void addImageFromCamera() async {
    var img = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (img != null) problemImage = File(img.path);
    });
  }

  String title = '';
  String text = '';

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ReportsProvider>(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
        child: InkWell(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            // if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
            // }
          },
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Написать жалобу",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextFormField(
                  // color:
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    labelText: "Тема",
                    // suffixIcon: icon,
                  ),
                  onChanged: (value) {
                    title = value;
                  },
                ),
                // SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  // color:
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    labelText: "Жалоба",
                    // suffixIcon: icon,
                  ),
                  onChanged: (value) {
                    text = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        // _picker.
                        // addImageFromCamera();
                      },
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image(
                          image: AssetImage('assets/images/camera.png'),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        addImageFromGallery();
                      },
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image(
                          image: AssetImage('assets/images/gallery.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                problemImage != null
                    ? Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image(
                            fit: BoxFit.cover,
                            image: FileImage(problemImage!),
                          ),
                        ),
                      )
                    : Text(''),
                ElevatedButton(
                  onPressed: () {
                    pro.add(
                      Report(
                        id: pro.getReportList.length,
                        title: title,
                        text: text,
                        location: {
                          'lat': widget.location.latitude,
                          'lng': widget.location.longitude
                        },
                        importance: false,
                        catergory: 0,
                        comments: [],
                      ),
                    );
                    print(pro.getReportList);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Background color
                    // onPrimary: Colors.amber, // Text Color (Foreground color)
                  ),
                  child: const Text(
                    'Жаловаца',
                    style: TextStyle(color: Colors.blue),
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
