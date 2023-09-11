import 'package:credit_card_reader/Screen/widgets/leading_icon.dart';
import 'package:credit_card_reader/configure/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          elevation: 0,
          leading: InkWell(onTap: () {}, child: const LeadingIcon())),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Positioned(
              bottom: 200,
              right: 30,
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  'assets/images/bottom_dec.png',
                  // color: AppColors.theamSecondaryColor,
                  scale: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
