import 'package:cancer_shield/helpers/networking.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: Icon(Iconsax.arrow_left_2_copy)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"),
                ),
                SizedBox(
                  height: 45,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: emptyValidator,
                        controller: usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: Text("Full Name"),
                          prefixIcon: Icon(Iconsax.user_copy),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      TextFormField(
                        validator: emailValidator,
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: Text("Email"),
                          prefixIcon: Icon(Iconsax.personalcard_copy),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      TextFormField(
                        validator: emptyValidator,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: Text("Password"),
                          prefixIcon: Icon(Iconsax.password_check_copy),
                          suffixIcon: Icon(Iconsax.eye_slash_copy),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      TextFormField(
                        validator: emptyValidator,
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: Text("Confirm Password"),
                          prefixIcon: Icon(Iconsax.password_check_copy),
                          suffixIcon: Icon(Iconsax.eye_slash_copy),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 140,
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          signUp(context);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(const Color(0xff0ebe7f)),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp(BuildContext context) async {
    final api = HttpService.instance;
    final response = await api.post("Auth/register", body: {
      "fullName": usernameController.text,
      "email": emailController.text,
      "password": passwordController.text
    });
    response.fold((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
    }, (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Registration Successful")));

      Navigator.of(context).pushNamed("/login_screen");
    });
  }
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  // RegEx to validate email format
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null; // Validation passed
}

String? emptyValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Oops! It looks like you missed this one. Please fill it in.";
  }
  return null;
}
