import 'package:flutter/material.dart';
import 'package:messaging_app/Login/Screen/loginpage.dart';
import 'package:messaging_app/Login/widget/button.dart';
import 'package:messaging_app/Login/widget/textfield.dart';
import 'package:messaging_app/Services/authentication.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();

  void signup() async {
    String res = await Authentication().signupUser(
        email: emailcontroller.text,
        password: passwordcontroller.text,
        name: namecontroller.text);
    if (res == 'success') {
      setState(() {});
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Loginpage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Page",
      home: Scaffold(
          backgroundColor: Colors.black,
          body: ListView(
            children: [
              SafeArea(
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
                          child: Image.asset('assets/Sign up-amico.png'),
                        ),
                        TextfieldInput(
                            textEditingController: namecontroller,
                            hintText: "Enter Your Name",
                            icon: Icons.person_2_rounded),
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
                        Buttons(onTap: () {}, text: "Sign Up"),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an Account?",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Loginpage()));
                                    },
                                    child: Text(
                                      " Login",
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
              )
            ],
          )),
    );
  }
}
