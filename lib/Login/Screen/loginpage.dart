import 'package:flutter/material.dart';
import 'package:messaging_app/Login/Screen/homepage.dart';
import 'package:quickalert/quickalert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messaging_app/Login/Screen/signup.dart';
import 'package:messaging_app/Login/widget/button.dart';
import 'package:messaging_app/Login/widget/snackbar.dart';
import 'package:messaging_app/Login/widget/textfield.dart';
import 'package:messaging_app/Services/authentication.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool isloading = false;

  void despose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void Login() async {
    String res = await Authentication().loginUser(
      email: emailcontroller.text,
      password: passwordcontroller.text,
    );
    if (res == 'success') {
      setState(() {
        isloading = true;
      });
      QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Loading',
        text: 'Fetching your data',
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } else {
      setState(() {
        isloading = false;
      });
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Empty Field found!',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: "Login Page",
      home: Scaffold(
          backgroundColor: Colors.black,
          body: ListView(children: [
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
                        child: Image.asset('assets/Login-amico.png'),
                      ),
                      TextfieldInput(
                          labelText: "Email",
                          textEditingController: emailcontroller,
                          hintText: "Enter Your Email",
                          icon: Icons.mail),
                      TextfieldInput(
                        labelText: "Password",
                        ispass: true,
                        textEditingController: passwordcontroller,
                        hintText: "Enter Your Password",
                        icon: Icons.lock,
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
                      Buttons(onTap: Login, text: "Login"),
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signup()));
                                  },
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
            ),
          ])),
    );
  }
}
