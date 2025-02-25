import 'package:cancer_shield/helpers/networking.dart';
import 'package:cancer_shield/helpers/shared_preferences_utils.dart';
import 'package:cancer_shield/models/user_model.dart';
import 'package:cancer_shield/screens/auth/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
                  "Welcome Back!",
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 280,
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            signIn(context);
                          } on Exception catch (e) {
                            print(e.toString());
                          }
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
                        "Log in",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      onTap: () =>
                          Navigator.of(context).pushNamed("/sign_up_screen"),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xff0ebe7f),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn(BuildContext context) async {
    final api = HttpService.instance;
    final response = await api.post("Auth/login", body: {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    });
    response.fold((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error)));
    }, (success) async {
      print("herrrrrrrrrrrrrre");
      await SharedPreferencesUtils.set('token',success?["token"]);
  getUser(success?["userId"], context);
    });
  }

  void getUser(int id, BuildContext context) async {
    final api = HttpService.instance;
    final response = await api.get("User/user/$id");
    response.fold((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to get user")));
    }, (success) {
      final user = UserModel.fromMap(success!);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("login successful")));

      Navigator.of(context).pushNamed("/home_screen", arguments: user);
    });
  }
}
