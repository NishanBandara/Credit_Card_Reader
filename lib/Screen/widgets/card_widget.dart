import 'package:credit_card_reader/configure/colors.dart';
import 'package:credit_card_reader/utils/get_screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(
              width: getScreenWidth(context, 120),
            ),
            Image.asset(
              'assets/images/auto-group-nmht.png',
              color: AppColors.theamSecondaryColor,
              width: getScreenWidth(context, 30),
              height: getScreenHeight(context, 30),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: getScreenHeight(context, 65),
                  width: getScreenWidth(context, 120),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xff6b7fa5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3f000000),
                        offset: Offset(1, 1),
                        blurRadius: 20.5 * 15,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: Align(
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xffd9d9d9),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 23,
                  top: 10,
                  child: Align(
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xffd9d9d9),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 65,
                  top: 30,
                  child: Align(
                    child: SizedBox(
                      width: getScreenWidth(context, 30),
                      height: getScreenHeight(context, 35),
                      child: Container(
                        child: Text(
                          "NFC",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
