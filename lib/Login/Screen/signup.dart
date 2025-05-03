import 'package:flutter/material.dart';
import 'package:messaging_app/Login/Screen/homepage.dart';
import 'package:messaging_app/Login/Screen/loginpage.dart';
import 'package:messaging_app/Login/widget/button.dart';
import 'package:messaging_app/Login/widget/snackbar.dart';
import 'package:messaging_app/Login/widget/textfield.dart';
import 'package:messaging_app/Services/authentication.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void signup() async {
    setState(() {
      isLoading = true;
    });

    String res = await Authentication().signupUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);

    if (res == 'success') {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Loading',
        text: 'Fetching your data',
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Empty Field found!',
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Signup Page",
      home: Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: <Widget>[
            SafeArea(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    SizedBox(
                      height: 250,
                      width: 250,
                      child: Image.asset('assets/Sign up-amico.png'),
                    ),
                    TextfieldInput(
                      labelText: "Name",
                      textEditingController: nameController,
                      hintText: "Enter Your Name",
                      icon: Icons.person_2_rounded,
                    ),
                    TextfieldInput(
                      labelText: "Email",
                      textEditingController: emailController,
                      hintText: "Enter Your Email",
                      icon: Icons.mail,
                    ),
                    TextfieldInput(
                      labelText: "Password",
                      ispass: true,
                      textEditingController: passwordController,
                      hintText: "Enter Your Password",
                      icon: Icons.lock,
                    ),
                    Buttons(onTap: signup, text: "Sign Up"),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an Account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Loginpage()));
                            },
                            child: Text(
                              " Login",
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isLoading)
                      CircularPercentIndicator(
                        radius: 100.0,
                        lineWidth: 10.0,
                        percent: 0.8,
                        header: new Text("Icon header"),
                        center: new Icon(
                          Icons.person_pin,
                          size: 50.0,
                          color: Colors.blue,
                        ),
                        backgroundColor: Colors.cyanAccent,
                        progressColor: Colors.white,
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
