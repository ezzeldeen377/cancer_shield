import 'package:cancer_shield/helpers/networking.dart';
import 'package:cancer_shield/helpers/shared_preferences_utils.dart';
import 'package:cancer_shield/models/user_model.dart';
import 'package:cancer_shield/screens/auth/sign_up_screen/sign_up_screen.dart';
import 'package:cancer_shield/screens/home_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key, required this.user});
  final UserModel user;
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  void initValues() {
    nameController.text = user.fullName!;
    emailController.text = user.email!;
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
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(user),
                            child: const CircleAvatar(
                              child: Icon(Iconsax.user_copy),
                            ),
                          ),
                        ),
                      ),
                       Positioned(
                        top: 140,
                        left: 135,
                        child: Text(
                          user.fullName??'',
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
                              onPressed: () => Navigator.of(context).pop(user),
                              icon: Icon(
                                Iconsax.arrow_left_2_copy,
                                color: Colors.white,
                              )))
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextFormField(
                            controller: nameController,
                            validator: emptyValidator,
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
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextFormField(
                            controller: emailController,
                            validator: emptyValidator,
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
                          child: TextFormField(
                            controller: oldPasswordController,
                            validator: emptyValidator,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                label: Text(
                                  "Old Password",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                                prefixIcon: Icon(Iconsax.password_check_copy),
                                suffixIcon: Icon(Iconsax.eye_slash_copy)),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextFormField(
                            controller: newPasswordController,
                            validator: emptyValidator,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                label: Text(
                                  "New Password",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                                prefixIcon: Icon(Iconsax.password_check_copy),
                                suffixIcon: Icon(Iconsax.eye_slash_copy)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            update(context);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Color(0xff0ebe7f)),
                              shape: WidgetStatePropertyAll<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          child: Text(
                            "Confirm Changes",
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

  void update(BuildContext context) async {
    final token= SharedPreferencesUtils.get('token') as String;
    final response =
        await HttpService.instance.put('Changing/update-profile', body: {
      "fullName": nameController.text.trim(),
      "oldPassword": oldPasswordController.text.trim(),
      "newPassword": newPasswordController.text.trim()
    },
    headers: {
        'Accept': token,
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    },
    );
    response.fold((error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));

      print(error); 
    }, (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success?["message"])));
      print(" here$success");
    });

  }
}
