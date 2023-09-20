import 'dart:developer';

import 'package:credit_card_reader/Screen/loginScreen.dart';
import 'package:credit_card_reader/Screen/widgets/loading_circulart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_reader/configure/colors.dart';
import 'package:credit_card_reader/utils/get_screen_size.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:credit_card_reader/Screen/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signupScreen extends StatefulWidget {
  const signupScreen({super.key});

  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();
  final userConfirmPasswordController = TextEditingController();

// passwod show/hide
  bool _isVisible = true;
  bool _isVisibleConfirm = true;
  // Password field show text
  void showPassword() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void showConfirmPassword() {
    setState(() {
      _isVisibleConfirm = !_isVisibleConfirm;
    });
  }

  final _formKey = GlobalKey<FormState>();

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
                  Text('SignUp',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: AppColors.theamSecondaryColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400))),
                ],
              ),
            ),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 8),
                      child: SizedBox(
                          width: (MediaQuery.of(context).size.width) * 0.85,
                          child: TextFormField(
                            controller: userNameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Name",
                              hintStyle: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Colors.black12,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400)),
                              labelText: "Name",
                              labelStyle: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Colors.black45,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500)),
                            ),
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Name is can't be empty !";
                              }
                              return null;
                            },
                            onSaved: (String? value) {},
                          ))),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 8),
                      child: SizedBox(
                          width: (MediaQuery.of(context).size.width) * 0.85,
                          child: TextFormField(
                            controller: userEmailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                    const BorderSide(color: Colors.white),
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
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "email is can't be empty !";
                              }
                              return null;
                            },
                            onSaved: (String? value) {},
                          ))),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 8),
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
                                  borderSide:
                                      const BorderSide(color: Colors.white),
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
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Confirm Password is can't be empty !";
                              } else {
                                if (text.length < 6) {
                                  return "Password should be at least 6 characters";
                                } else {
                                  if (userPasswordController.text !=
                                      userConfirmPasswordController.text) {
                                    return "Password should be same !";
                                  }
                                }
                              }
                              return null;
                            },
                          ))),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 8),
                      child: SizedBox(
                          width: (MediaQuery.of(context).size.width) * 0.85,
                          child: TextFormField(
                            controller: userConfirmPasswordController,
                            obscureText: _isVisibleConfirm,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "confirm Password",
                                hintStyle: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black12,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400)),
                                labelText: "confirm Password",
                                labelStyle: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w500)),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isVisibleConfirm = !_isVisibleConfirm;
                                      });
                                    },
                                    child: !_isVisibleConfirm
                                        ? const Icon(Icons.visibility,
                                            color: Colors.black45)
                                        : const Icon(Icons.visibility_off,
                                            color: Colors.black45))),
                            onSaved: (String? value) {},
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Confirm Password is can't be empty !";
                              } else {
                                if (text.length < 6) {
                                  return "Password should be at least 6 characters";
                                } else {
                                  if (userPasswordController.text !=
                                      userConfirmPasswordController.text) {
                                    return "Password should be same !";
                                  }
                                }
                              }
                              return null;
                            },
                          ))),
                ],
              ),
            ),

            SizedBox(
              height: getScreenHeight(context, 15),
            ),
            InkWell(
              onTap: () async {
                SharedPreferences localStorage =
                    await SharedPreferences.getInstance();
                if (_formKey.currentState!.validate()) {
                  try {
                    loader(context);
                    User? user = await FireAuth.registerUsingEmailPassword(
                      name: userNameController.text,
                      email: userEmailController.text,
                      password: userPasswordController.text,
                    );

                    log(user!.email.toString());
                    Fluttertoast.showToast(
                        msg:
                            "${user!.email} Account has been created successfully !",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0);

                    // User Name
                    localStorage.setString(
                        'userName', user!.displayName.toString());

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
                  } on Exception catch (e) {
                    log(e.toString());
                  }
                } else {
                  log('ERROR');
                }
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => HomeScreen(
                //           cardNumber: '123456789',
                //           cardType: 'CardIssuer.visa',
                //           expDate: 'mm/yy',
                //           holderName: '',
                //         )));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: (MediaQuery.of(context).size.width) * 0.85,
                  height: getScreenHeight(context, 65),
                  decoration: BoxDecoration(
                    color: AppColors.theamPrimaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'SignUp',
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
            // InkWell(
            //   onTap: () {},
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
            //     child: Container(
            //       width: (MediaQuery.of(context).size.width) * 0.85,
            //       height: getScreenHeight(context, 65),
            //       decoration: BoxDecoration(
            //         color: AppColors.theamPrimaryColor,
            //         borderRadius: BorderRadius.circular(30),
            //       ),
            //       child: Center(
            //         child: Text(
            //           'Sign up',
            //           style: GoogleFonts.poppins(
            //             textStyle: const TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 14.0,
            //                 fontWeight: FontWeight.w400),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: getScreenHeight(context, 15),
            // ),
            // Center(
            //   child: Text(
            //     'OR',
            //     style: GoogleFonts.poppins(
            //       textStyle: const TextStyle(
            //           color: AppColors.theamSecondaryColor,
            //           fontSize: 14.0,
            //           fontWeight: FontWeight.w400),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: getScreenHeight(context, 15),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         SizedBox(
            //           width: getScreenWidth(context, 30),
            //           height: getScreenHeight(context, 30),
            //           child: Image.asset(
            //             "assets/images/apple.png",
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //         SizedBox(
            //           width: getScreenWidth(context, 12),
            //         ),
            //         SizedBox(
            //           width: getScreenWidth(context, 30),
            //           height: getScreenHeight(context, 30),
            //           child: Image.asset(
            //             "assets/images/google.png",
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //         SizedBox(
            //           width: getScreenWidth(context, 12),
            //         ),
            //         SizedBox(
            //           width: getScreenWidth(context, 30),
            //           height: getScreenHeight(context, 30),
            //           child: Image.asset(
            //             "assets/images/fb.png",
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
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
}
