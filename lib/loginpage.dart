import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Page",
      home: Scaffold(
        backgroundColor: Colors.black,
        body: _loginPage(),
      ),
    );
  }

  Widget _loginPage() {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //_loginImage(),
            _headingWidget(),
            SizedBox(height: 25),

            _inputForm(),
            SizedBox(height: 20),
            _loginButton(),
            
            SizedBox(height: 15),
            _regiterClick()
          ],
        ),
      ),
    );
  }

  Widget _loginImage() {
    return Center(
      child: SizedBox(
          height: 250,
          width: 250,
          child: Image.asset('assets/Login-amico.png')),
    );
  }

  Widget _headingWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Welcome Back!",
            style: GoogleFonts.lato(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent),
          ),
          Text(
            "Login into your account",
            style: GoogleFonts.lato(
                fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _inputForm() {
    return Container(
      child: Form(
          onChanged: () {},
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_email(), _password()],
          )),
    );
  }

  Widget _email() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        validator: (input) {},
        onSaved: (input) {},
        cursorColor: Colors.white,
        autocorrect: false,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
            labelText: "Email",
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyanAccent))),
      ),
    );
  }

  Widget _password() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        obscureText: true,
        validator: (input) {},
        onSaved: (input) {},
        cursorColor: Colors.white,
        autocorrect: false,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
            labelText: "Password",
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyanAccent))),
      ),
    );
  }

  Widget _loginButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          width: 350,
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _regiterClick() {
    return GestureDetector(
      onTap: () {},
      child: Container(
          alignment: Alignment.center,
          child: Text(
            "Register",
            style: TextStyle(color: Colors.grey),
          )),
    );
  }
}
