import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messaging_app/Login/widget/button.dart';
import 'package:messaging_app/Login/widget/textfield.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: "Login Page",
      home: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: Image.asset('assets/Login-amico.png'),
                    ),
                    TextfieldInput(
                        textEditingController: emailcontroller,
                        hintText: "Enter Your Email",
                        icon: Icons.mail),
                    TextfieldInput(
                      textEditingController: passwordcontroller,
                      hintText: "Enter Your Password",
                      icon: Icons.lock,
                      ispass: true,
                    ),
                    const Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.cyanAccent),
                        ),
                      ),
                    ),
                    Buttons(onTap: () {}, text: "Login"),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Dont have an Account?",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: Text(
                                  " SignUp",
                                  style: TextStyle(
                                    color: Colors.cyanAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
