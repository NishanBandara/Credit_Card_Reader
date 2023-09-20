import 'package:credit_card_reader/Screen/loginScreen.dart';
import 'package:credit_card_reader/utils/get_screen_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: Container(
        // iphone14promax4bNq (9:122)
        width: double.infinity,
        height: 932 * fem,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
            colors: <Color>[Color(0xff293e69), Color(0xff0b1c3f)],
            stops: <double>[0, 1],
          ),
        ),
        child: SizedBox(
          width: getScreenWidth(context, 30),
          height: getScreenHeight(context, 30),
          child: Image.asset(
            'assets/images/login_card.png',
            // color: AppColors.theamSecondaryColor,
            scale: 4,
          ),
        ),

        // Stack(
        //   children: [
        //     Positioned(
        //       left: 173 * fem,
        //       top: 433 * fem,
        //       child: Align(
        //         child: SizedBox(
        //           width: 113 * fem,
        //           height: 63 * fem,
        //           child: Container(
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(14 * fem),
        //               color: const Color(0xff6b7fa5),
        //               boxShadow: [
        //                 BoxShadow(
        //                   color: Color(0x3f000000),
        //                   offset: Offset(0 * fem, 4 * fem),
        //                   blurRadius: 20.5 * fem,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       // vector27fn1 (9:127)
        //       left: 150.6735229492 * fem,
        //       top: 410.4686279297 * fem,
        //       child: Align(
        //         child: SizedBox(
        //           width: 22.33 * fem,
        //           height: 23.03 * fem,
        //           child: Image.asset(
        //             'assets/images/auto-group-nmht.png',
        //             color: Color(0xffffffff),
        //             width: 22 * fem,
        //             height: 23.57 * fem,
        //           ),
        //         ),
        //       ),
        //     ),
        //     // Positioned(
        //     //   // ellipse7tuf (9:130)
        //     //   left: 166 * fem,
        //     //   top: 425 * fem,
        //     //   child: Align(
        //     //     child: SizedBox(
        //     //       width: 8 * fem,
        //     //       height: 8 * fem,
        //     //       child: Container(
        //     //         decoration: BoxDecoration(
        //     //           borderRadius: BorderRadius.circular(4 * fem),
        //     //           color: Color(0xffffffff),
        //     //         ),
        //     //       ),
        //     //     ),
        //     //   ),
        //     // ),
        //     Positioned(
        //       // ellipse8RPo (9:134)
        //       left: 188 * fem,
        //       top: 446 * fem,
        //       child: Align(
        //         child: SizedBox(
        //           width: 9 * fem,
        //           height: 9 * fem,
        //           child: Container(
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(4.5 * fem),
        //               color: Color(0xffd9d9d9),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       // ellipse9kBB (9:135)
        //       left: 202 * fem,
        //       top: 446 * fem,
        //       child: Align(
        //         child: SizedBox(
        //           width: 9 * fem,
        //           height: 9 * fem,
        //           child: Container(
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(4.5 * fem),
        //               color: Color(0xffd9d9d9),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       // nfc5DT (9:225)
        //       left: 236 * fem,
        //       top: 465 * fem,
        //       child: Align(
        //         child: SizedBox(
        //           width: 42 * fem,
        //           height: 25 * fem,
        //           child: Text('NFC',
        //               style: GoogleFonts.poppins(
        //                   textStyle: const TextStyle(
        //                       color: Colors.white,
        //                       fontSize: 15.0,
        //                       fontWeight: FontWeight.w400))),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
