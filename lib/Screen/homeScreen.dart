import 'package:credit_card_reader/Screen/widgets/card_widget.dart';
import 'package:credit_card_reader/configure/colors.dart';
import 'package:credit_card_reader/utils/get_screen_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
