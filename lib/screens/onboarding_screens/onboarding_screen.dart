import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 130,),
              SizedBox(
                height: 250,
                width: 250,
                child: Image.asset("assets/images/1.png"),
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to ",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text("Cancer Shield",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat"
                  ),
                  ),
                  
                ],
              ),
              SizedBox(height: 4,),
              Text("Your trusted companion",
              style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontFamily: "Montserrat"
                  ),),
              Text("for early detection",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontFamily: "Montserrat"
                  ),
              ),
              SizedBox(height: 60,),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(onPressed: ()=>Navigator.of(context).pushNamed("/login_screen"),
                
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(const Color(0xff0ebe7f)),
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                ),
                 child: Text("Log in",
                 style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                 ),
                 )),
              ),
              SizedBox(height: 8,),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(onPressed: ()=>Navigator.of(context).pushNamed("/sign_up_screen"),
                
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                  shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Color(0xff0ebe7f))
                    )),
                ),
                 child: Text("Sign Up",
                 style: TextStyle(
                  color: Color(0xff0ebe7f),
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                 ),
                 )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}