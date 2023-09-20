import 'package:credit_card_reader/configure/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgresIndicator extends StatelessWidget {
  const ProgresIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CupertinoActivityIndicator(
              animating: true,
              radius: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Center(
              child: Text('Loading ...',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: AppColors.theamPrimaryColor,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w300))),
            ),
          )
        ],
      ),
    );
    //   },
    // );
  }
}

loader(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ProgresIndicator();
      });
}
