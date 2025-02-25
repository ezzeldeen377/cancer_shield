import 'package:cancer_shield/helpers/shared_preferences_utils.dart';
import 'package:cancer_shield/models/user_model.dart';
import 'package:cancer_shield/screens/auth/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key, required this.user});
  final UserModel user;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  void initValues(){
    _nameController.text = user.fullName!;
    _emailController.text = user.email!;
  }
  @override
  Widget build(BuildContext context) {
    initValues();
    return Scaffold(
        body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
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
                      Positioned(
                        top: 50,
                        left: 160,
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: const CircleAvatar(
                            child: Icon(Iconsax.user_copy),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 140,
                        left: 135,
                        child: Text(
                          user.fullName ?? 'empty',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                          top: 50,
                          left: 10,
                          child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(
                                Iconsax.arrow_left_2_copy,
                                color: Colors.white,
                              )))
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text(
                          "Full Name",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                          ),
                        ),
                        prefixIcon: Icon(Iconsax.user_copy),
                        suffix: InkWell(
                          onTap: () =>Navigator.of(context)
                              .pushNamed("/change_password_screen",arguments: user),
                          child: Text(
                            "Change",
                            style: TextStyle(
                              color: Color(0xff0ebe7f),
                              fontFamily: "Montserrat",
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text(
                          "Email",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                          ),
                        ),
                        prefixIcon: Icon(Iconsax.personalcard_copy),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text(
                          "Password",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                          ),
                        ),
                        prefixIcon: Icon(Iconsax.password_check_copy),
                        suffix: InkWell(
                          onTap: () => Navigator.of(context)
                              .pushNamed("/change_password_screen",arguments: user),
                          child: Text(
                            "Change",
                            style: TextStyle(
                              color: Color(0xff0ebe7f),
                              fontFamily: "Montserrat",
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 220,
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            openDialog(context);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.black),
                              shape: WidgetStatePropertyAll<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          child: Text(
                            "Log Out",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )),
                    ),
                  )
                ],
              ),
            )));
  }
}

Future openDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          "Are you sure you want to log out ?",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 19,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 120,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0xff0ebe7f)),
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              
              SizedBox(
                height: 50,
                width: 120,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).popUntil((route) =>
                        route is MaterialPageRoute &&
                        route.builder(context) is LoginScreen);
                        await SharedPreferencesUtils.remove('token');
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      side: WidgetStateProperty.all(
                          BorderSide(color: Colors.red)),
                      shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
