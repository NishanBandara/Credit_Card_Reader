import 'package:credit_card_reader/Screen/cardScanner.dart';
import 'package:credit_card_reader/Screen/homeScreen.dart';
import 'package:credit_card_reader/Screen/signupScreen.dart';
import 'package:credit_card_reader/Screen/widgets/card_widget.dart';
import 'package:credit_card_reader/Screen/widgets/loading_circulart.dart';
import 'package:credit_card_reader/configure/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:credit_card_reader/utils/get_screen_size.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();

// passwod show/hide
  bool _isVisible = false;
  // Password field show text
  void showPassword() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: getScreenHeight(context, 100),
              width: getScreenWidth(context, 200),
            ),
            Image.asset(
              'assets/images/splash_card.png',
              // color: AppColors.theamSecondaryColor,
              width: getScreenWidth(context, 100),
              height: getScreenHeight(context, 100),
            ),
            // const CardWidget(),
            SizedBox(
              height: getScreenHeight(context, 50),
            ),
            Padding(
              padding: EdgeInsets.only(left: getScreenWidth(context, 35)),
              child: Row(
                children: [
                  Text('Login',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: AppColors.theamSecondaryColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400))),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                child: SizedBox(
                    width: (MediaQuery.of(context).size.width) * 0.85,
                    child: TextFormField(
                      controller: userEmailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "email",
                        hintStyle: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Colors.black12,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400)),
                        labelText: "email",
                        labelStyle: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: Colors.black45,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500)),
                      ),
                      onSaved: (String? value) {},
                    ))),
            Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                child: SizedBox(
                    width: (MediaQuery.of(context).size.width) * 0.85,
                    child: TextFormField(
                      controller: userPasswordController,
                      obscureText: _isVisible,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "password",
                          hintStyle: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Colors.black12,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400)),
                          labelText: "password",
                          labelStyle: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500)),
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                              },
                              child: !_isVisible
                                  ? const Icon(Icons.visibility,
                                      color: Colors.black45)
                                  : const Icon(Icons.visibility_off,
                                      color: Colors.black45))),
                      onSaved: (String? value) {},
                    ))),
            SizedBox(
              height: getScreenHeight(context, 15),
            ),
            InkWell(
              onTap: () async {
                await signIn();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: (MediaQuery.of(context).size.width) * 0.85,
                  height: getScreenHeight(context, 65),
                  decoration: BoxDecoration(
                    color: AppColors.theamSecondaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => signupScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
                child: Container(
                  width: (MediaQuery.of(context).size.width) * 0.85,
                  height: getScreenHeight(context, 65),
                  decoration: BoxDecoration(
                    color: AppColors.theamPrimaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Sign up',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getScreenHeight(context, 15),
            ),
            Center(
              child: Text(
                'OR',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: AppColors.theamSecondaryColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(
              height: getScreenHeight(context, 15),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: getScreenWidth(context, 30),
                      height: getScreenHeight(context, 30),
                      child: Image.asset(
                        "assets/images/apple.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: getScreenWidth(context, 12),
                    ),
                    SizedBox(
                      width: getScreenWidth(context, 30),
                      height: getScreenHeight(context, 30),
                      child: Image.asset(
                        "assets/images/google.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: getScreenWidth(context, 12),
                    ),
                    SizedBox(
                      width: getScreenWidth(context, 30),
                      height: getScreenHeight(context, 30),
                      child: Image.asset(
                        "assets/images/fb.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getScreenHeight(context, 75),
            ),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'By Pressing Sign in you agree to our \n',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.black26,
                            fontSize: 10.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    TextSpan(
                        text: 'Term & Privacy',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    try {
      loader(context);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmailController.text.trim(),
          password: userPasswordController.text.trim());

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
                child: CircularProgressIndicator(),
              ));

      User? user = await FirebaseAuth.instance.currentUser;
      log(user!.email.toString());
      // User Name
      localStorage.setString('userName', user!.displayName.toString());

      // User email
      localStorage.setString('userEmail', user!.email.toString());

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const HomeScreen(
                    cardNumber: '123456789',
                    cardType: 'CardIssuer.visa',
                    expDate: 'mm/yy',
                    holderName: '',
                  )),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      log(e.toString());

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
            child: Scaffold(
                body: Center(
          child: Container(
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                      // height: 250,
                      // width: 300,
                      child: Icon(
                    Icons.error_outline_outlined,
                    color: Colors.black12,
                    size: 80,
                  )

                      //  Image.asset('images/CarLog_Logo.png'),
                      ),
                ),
                Text('Oops...Sorry Please try Again!',
                    style: TextStyle(color: Colors.black54, fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: getScreenWidth(context, 250),
                    child: Text(e.message.toString(),
                        style: TextStyle(color: Colors.black26, fontSize: 12)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ButtonStyle(),
                    child: Text(
                      'Try Again',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    })
              ],
            ),
          ),
        ))),
      );
    }
  }
}
