import 'package:cancer_shield/helpers/networking.dart';
import 'package:cancer_shield/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key, required this.location});
  final String location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(13),
                      bottomRight: Radius.circular(13),
                    ),
                    color: Color.fromARGB(255, 18, 71, 21),
                  ),
                  child: Image.asset(
                    "assets/images/2.png",
                    opacity: const AlwaysStoppedAnimation(.4),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    top: 25,
                    left: 10,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Iconsax.arrow_left_2_copy,
                              color: Colors.white,
                            )),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Back to Resualt",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ))
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Most Popular Doctors",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "In Your Area ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"),
                ),
                Text(
                  location,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: FutureBuilder<List<DoctorModel>>(
                future: _getDoctors(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final doctor = snapshot.data![index];
                        return _doctorsCard(doctor
                         );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<DoctorModel>> _getDoctors() async {
    final api = HttpService.instance;
    try {
              var response ;

      if (location.isEmpty) {
         response = await api.get('Doctors');
      } else {
         response = await api.get('Doctors/filter?location=$location');
      }

      return response.fold(
        (l) => [],
        (r) {
          print("@@@@@@@@@@@@@@@@@@@@@@@@@$r");
          return DoctorResponse.fromList(r?["data"]).doctors ;
        },
      );
    } on Exception catch (e) {
      print("Error: $e");
      return [];
    }
  }
}

Widget _doctorsCard(
  DoctorModel doctor) {
  return Padding(
    padding: EdgeInsets.all(14),
    child: Container(
      padding: EdgeInsets.all(14),
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(8)),
                child: Image.network(doctor.imagePath),
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    doctor.specialty,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Icon(
                        Iconsax.call,
                        size: 16,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        doctor.phone,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "- Open from 11 AM to 8 PM",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "- ${doctor.experience} Years Experince",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
             
                child: ElevatedButton(
                    onPressed: () {
                      launchUrlInBrowser(doctor.locationUrl);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10), // Set the desired padding here
                        // Set the desired padding here,
                        backgroundColor: Color(0xff0ebe7f),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.location,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Location",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )),
              )
            ],
          )
        ],
      ),
    ),
  );
}
Future<void> launchUrlInBrowser(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
