import 'dart:developer';

import 'package:credit_card_reader/Screen/widgets/leading_icon.dart';
import 'package:credit_card_reader/configure/colors.dart';
import 'package:credit_card_reader/utils/get_screen_size.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'dart:async';

import 'package:credit_card_scanner/credit_card_scanner.dart';
// import 'package:ml_card_scanner/ml_card_scanner.dart';

class CreditCardScanner extends StatefulWidget {
  const CreditCardScanner({super.key});

  @override
  State<CreditCardScanner> createState() => _CreditCardScannerState();
}

class _CreditCardScannerState extends State<CreditCardScanner> {
  // CardInfo? _cardInfo;
  // final ScannerWidgetController _controller = ScannerWidgetController();
  String? cardata;
  Future<void> test() async {
    var cardDetails = await CardScanner.scanCard(
      scanOptions: CardScanOptions(
        scanCardHolderName: true,
      ),
    );

    setState(() {
      cardata = cardDetails.toString();
    });

    print(cardDetails);
  }

  @override
  void initState() {
    test();
    // _controller
    //   ..setCardListener((value) {
    //     setState(() {
    //       _cardInfo = value;
    //       log(_cardInfo.toString());
    //     });
    //   })
    //   ..setErrorListener((exception) {
    //     if (kDebugMode) {
    //       print('Error: ${exception.message}');
    //     }
    //   });
    super.initState();
  }

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
            SizedBox(
              width: getScreenWidth(context, 200),
              child: Text(
                "Place card on back side of your phone and press scan",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: AppColors.theamSecondaryColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(
              height: getScreenHeight(context, 20),
            ),
            // Expanded(
            //   child: ScannerWidget(
            //     controller: _controller,
            //     overlayOrientation: CardOrientation.landscape,
            //   ),
            // ),
            Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(cardata?.toString() ?? 'No Card Details'),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )),
            Container(width: 200, height: 200, color: Colors.black12),
            SizedBox(
              height: getScreenHeight(context, 50),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreditCardScanner()));
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
                      'Scan Physical card',
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
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreditCardScanner()));
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
                      'Add Virtual Card ',
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
          ],
        ),
      ),
    );
  }
}
