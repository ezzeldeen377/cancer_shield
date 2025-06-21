import 'dart:math';

import 'package:cancer_shield/helpers/networking.dart';
import 'package:cancer_shield/models/colon_model.dart';
import 'package:cancer_shield/models/prediction_response.dart';
import 'package:cancer_shield/models/skin_model.dart';
import 'package:cancer_shield/models/user_model.dart';
import 'package:cancer_shield/screens/doctor_screens/doctor_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.user});
  final UserModel user;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedRegion; // Holds the selected region
  XFile? selectedImage;
  final List<String> regions = [
  'Nasr City',
  'Downtown',
  'Zamalek',
  'Maadi',
  'Heliopolis',
  'Shubra',
  'Helwan',
  'Ain Shams',
  'EL-Sahel Agouza',
  'Mohandessin',
  'Dokki',
  'Giza(Pyramids)',
  'Faisal',
  '6th of October',
  'Sheikh Zayed',
  'Badrasheen',
  'Kerdasa',
  'Imbaba',
  ];
  int selectedIndex = -1;
  List<Map<String, String>> buttonData = [
    {"text": "Skin", "image": "assets/images/rash.png"},
    {"text": "Colon", "image": "assets/images/colon.png"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 18, 71, 21),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Image.asset(
                      "assets/images/2.png",
                      opacity: const AlwaysStoppedAnimation(.4),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: InkWell(
                        onTap: () => Navigator.of(context).pushNamed(
                            "/profile_screen",
                            arguments: widget.user),
                        child: const CircleAvatar(
                          child: Icon(Iconsax.user_copy),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      widget.user.fullName ?? "empty name",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ])
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Easily find out results of your",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                " Skin image / Colon Scan",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 35),

              // Dropdown with hint
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 65,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(20),
                    hint: const Text(
                      "Select Your Region",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 13,
                      ),
                    ),
                    isExpanded: true,
                    value: regions.contains(selectedRegion)
                        ? selectedRegion
                        : null, // Ensure value is valid
                    items: regions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRegion = newValue;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 14,
                  ),
                  Text(
                    "Select type of Examination",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: List.generate(buttonData.length, (index) {
                  bool isSelected = selectedIndex == index;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: SizedBox(
                      height: 55,
                      width: 175,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: isSelected ? Colors.green : Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedIndex =
                                isSelected ? -1 : index; // Toggle selection
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 25,
                              width: 25,
                              child: Image.asset(
                                buttonData[index]["image"]!,
                                color: isSelected
                                    ? Colors.green
                                    : Colors.grey[600],
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              buttonData[index]["text"]!,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17,
                                color: isSelected
                                    ? Colors.green
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 14,
                  ),
                  Text(
                    "Upload the image",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          print(image.path);
                          selectedImage = image;
                          setState(() {});
                        }
                      },
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.grey)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 25,
                              width: 25,
                              child: Image.asset("assets/images/upload.png")),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Upload image",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Add your Skin image or colon scan here",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 11,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              ),
              if (selectedImage != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: DottedBorder(
                    padding: EdgeInsets.all(5),
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    strokeCap: StrokeCap.round,
                    color: Colors.black,
                    dashPattern: [12, 6],
                    strokeWidth: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(selectedImage!.path),
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              if (selectedImage == null)
                SizedBox(
                  height: 50,
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        _handleFindResult();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(const Color(0xff0ebe7f)),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      child: Text(
                        "Find Resualt",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleFindResult() async {
    if (!_validateInputs()) return;

    final result = await HttpService.instance
        .requestPredict(selectedIndex, selectedImage!);

    result.fold(
      (error) => _showErrorDialog(error),
      (prediction) => _handlePredictionResult(prediction),
    );
  }

  bool _validateInputs() {
    if (selectedIndex == -1 || selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Make sure you select a type of examination and upload an image."),
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> _handlePredictionResult(PredictionResponse prediction) async {
    final scanData = selectedIndex == 0
        ? {
            "userID": widget.user.userID ?? 0,
            "imagePath": selectedImage?.path ?? '',
            "diseaseType": prediction.classSkin ?? '',
            "diagnosisDate": DateTime.now().toIso8601String()
          }
        : {
            "userID": widget.user.userID ?? 0,
            "imagePath": selectedImage?.path ?? '',
            "cancerDetected": true,
            "cancerLevel": 4,
            "diagnosisDate": DateTime.now().toIso8601String(),
            "user":  {
            "fullName": widget.user.fullName ?? '',
            "email": widget.user.email ?? '',
            "passwordHash": '',
            "createdAt": widget.user.createdAt ?? '',
            "resetToken": widget.user.resetToken ?? '',
            "resetTokenExpiry": widget.user.resetTokenExpiry ?? DateTime.now().toIso8601String(),
  }};
    final response = await HttpService.instance
        .post(selectedIndex == 0 ? 'SkinScans' : 'ColonScans', body: scanData);
    response.fold((error) => print(" error : $error"),
        (success) => print(" success : $success"));
    _showResultDialog(prediction);
  }

  void _showErrorDialog(String error) {
    openDialog(context, "assets/images/error.png", "Error", error);
  }

  void _showResultDialog(PredictionResponse prediction) {
    print(prediction.toString());
    final detectedType = selectedIndex == 0
        ? prediction.classSkin ?? ''
        : prediction.classColon ?? '';
    openDialog(
      context,
      "assets/images/sad-face.png",
      "Signs of cancer detected: '$detectedType'",
      "Your results indicate potential concerns. It's important to follow up with a specialist as soon as possible. I can recommend trusted doctors in your area for further evaluation.",
    );
  }

  Future openDialog(BuildContext context, String image, String title,
          String description) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(image),
              ),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          actions: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
MaterialPageRoute(builder:(context)=>DoctorScreen(location:selectedRegion??"" ,))                  );
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xff0ebe7f)),
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                child: Text(
                  "Find Doctor Near You",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
