import 'dart:developer';

import 'package:credit_card_reader/Screen/cardScanner.dart';
import 'package:credit_card_reader/Screen/loginScreen.dart';
import 'package:credit_card_reader/Screen/myCardsScreen.dart';
import 'package:credit_card_reader/Screen/widgets/leading_icon.dart';
import 'package:credit_card_reader/Service/service.dart';
import 'package:credit_card_reader/configure/colors.dart';
import 'package:credit_card_reader/utils/get_screen_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String cardNumber, cardType, expDate, holderName;
  const HomeScreen(
      {super.key,
      required this.cardNumber,
      required this.cardType,
      required this.expDate,
      required this.holderName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisa = true;
  bool _isSelectScanCard = true;

  final TextEditingController _CardNumberController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();
  final TextEditingController _cardTypeController = TextEditingController();
  final TextEditingController _holderNameController = TextEditingController();

  // All data
  List<Map<String, dynamic>> myData = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshData() async {
    final data = await DatabaseHelper.getItems();
    setState(() {
      myData = data;
      _isLoading = false;
    });
  }

  // Insert a new data to the database
  Future<void> addItem({required String saveType}) async {
    await DatabaseHelper.createItem(widget.cardNumber, widget.expDate,
        widget.cardType, widget.holderName, saveType);
    _refreshData();
  }

  // Insert a new data to the database
  Future<void> addVirtualItem({
    required String cardNumber,
    required String expDate,
    required String cardType,
    required String holderName,
    required String saveType,
  }) async {
    await DatabaseHelper.createItem(
        cardNumber, expDate, cardType, holderName, saveType);
    _refreshData();
  }

  @override
  void initState() {
    _refreshData();
    getUserData();
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey!.currentState!.openDrawer();
  }

  var userName, userEmail;
  void getUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    userName = await localStorage.getString('userName');
    userEmail = await localStorage.getString('userEmail');
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          elevation: 0,
          leading: InkWell(onTap: _openDrawer, child: const LeadingIcon())),
      drawer: Drawer(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: getScreenHeight(context, 30),
              ),
              Column(
                children: [
                  Container(
                    height: getScreenHeight(context, 100),
                    width: getScreenWidth(context, 100),
                    decoration: BoxDecoration(
                      color: AppColors.theamPrimaryColor,
                      border: Border.all(color: AppColors.theamSecondaryColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(userEmail.toString() == 'null'
                        ? ''
                        : (userEmail.toString())),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(userName.toString() == 'null'
                        ? ''
                        : (userName.toString())),
                  ),
                ],
              ),
              SizedBox(
                height: getScreenHeight(context, 250),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Logout User!'),
                        backgroundColor: AppColors.theamSecondaryColor));
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
                          'Logout',
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
              ),
            ]),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        width: getScreenWidth(context, 200),
                        child: Text(
                          "All cards will be saved in you local device",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: AppColors.theamSecondaryColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            child: Image.asset(
                              'assets/images/Card_bg.png',
                              // color: AppColors.theamSecondaryColor,
                              scale: 1,
                            ),
                          ),
                          widget.cardType == 'CardIssuer.visa'
                              ? const Positioned(
                                  top: 38,
                                  left: 45,
                                  child: Text("VISA",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                )
                              : Positioned(
                                  top: 30,
                                  left: 45,
                                  child: SizedBox(
                                    child: Image.asset(
                                      'assets/images/master.png',
                                      // color: AppColors.theamSecondaryColor,
                                      scale: 1.5,
                                    ),
                                  ),
                                ),
                          Positioned(
                            top: 30,
                            right: 35,
                            child: SizedBox(
                              child: Image.asset(
                                'assets/images/CardChip.JPG',
                                // color: AppColors.theamSecondaryColor,
                                scale: 5.5,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 105,
                            left: 45,
                            child: SizedBox(
                                child: Text(widget.cardNumber,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white))),
                          ),
                          Positioned(
                            top: 145,
                            left: 45,
                            child: SizedBox(
                                child: Text("expire ${widget.expDate}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: getScreenHeight(context, 8),
                      ),
                    ],
                  )),
              Container(
                height: getScreenHeight(context, 50),
                width: getScreenWidth(context, 340),
                decoration: BoxDecoration(
                    color: AppColors.theamSecondaryColor,
                    border: Border.all(color: AppColors.theamSecondaryColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          // _isSelect = !_isSelect;
                          _isSelectScanCard = true;
                        });

                        log("BOOL : ${_isSelectScanCard}");
                      },
                      child: Container(
                        height: getScreenHeight(context, 55),
                        width: getScreenWidth(context, 160),
                        decoration: BoxDecoration(
                            color: _isSelectScanCard
                                ? AppColors.theamPrimaryColor
                                : AppColors.theamSecondaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            )),
                        child: Center(
                            child: Text(
                          "Scan card",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: AppColors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isSelectScanCard = false;
                        });
                      },
                      child: Container(
                          height: getScreenHeight(context, 60),
                          width: getScreenWidth(context, 175),
                          decoration: BoxDecoration(
                              color: !_isSelectScanCard
                                  ? AppColors.theamPrimaryColor
                                  : AppColors.theamSecondaryColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25),
                              )),
                          child: Center(
                              child: Text(
                            "virtual card",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getScreenHeight(context, 8),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        width: getScreenWidth(context, 500),
                        height: getScreenHeight(context, 431),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: _isSelectScanCard
                              ? AppColors.white
                              : Color.fromARGB(255, 245, 244, 244),
                        ),
                        child: !_isSelectScanCard
                            ? Column(
                                children: [
                                  SizedBox(
                                    width: getScreenWidth(context, 200),
                                    child: Text(
                                      "Virtual card detail",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color:
                                                AppColors.theamSecondaryColor,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 5),
                                      child: SizedBox(
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .width) *
                                              0.85,
                                          child: TextFormField(
                                            controller: _CardNumberController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.white)),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.white),
                                              ),
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: 'card number',
                                              hintStyle: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      color: Colors.black12,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                            onSaved: (String? value) {},
                                          ))),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 5),
                                      child: SizedBox(
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .width) *
                                              0.85,
                                          child: TextFormField(
                                            controller: _expDateController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.white)),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.white),
                                              ),
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: "MM / YY",
                                              hintStyle: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      color: Colors.black12,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                            onSaved: (String? value) {},
                                          ))),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 5),
                                      child: SizedBox(
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .width) *
                                              0.85,
                                          child: TextFormField(
                                            controller: _holderNameController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.white)),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.white),
                                              ),
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintText: "card holder name",
                                              hintStyle: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      color: Colors.black12,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                            onSaved: (String? value) {},
                                          ))),
                                  SizedBox(
                                    height: getScreenHeight(context, 10),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      log('Virtual Card');
                                      await addVirtualItem(
                                        cardNumber: _CardNumberController.text,
                                        expDate: _expDateController.text,
                                        holderName: _holderNameController.text,
                                        cardType: 'CardIssuer.visa',
                                        saveType: "Virtual Card",
                                      ).then((value) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MyCards()));
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Container(
                                        width: (MediaQuery.of(context)
                                                .size
                                                .width) *
                                            0.85,
                                        height: getScreenHeight(context, 65),
                                        decoration: BoxDecoration(
                                          color: AppColors.theamSecondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Save Card',
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
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    height: getScreenHeight(context, 20),
                                  ),
                                  SizedBox(
                                    width: getScreenWidth(context, 200),
                                    child: Text(
                                      "Scan card detail",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color:
                                                AppColors.theamSecondaryColor,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getScreenHeight(context, 5),
                                  ),
                                  widget.expDate == 'mm/yy'
                                      ? Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: getScreenHeight(
                                                    context, 50),
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const CreditCardScanner()));
                                                  },
                                                  child: Center(
                                                    child: RichText(
                                                      textAlign:
                                                          TextAlign.center,
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Oops ! Still not scaned card \n',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              textStyle: const TextStyle(
                                                                  color: Colors
                                                                      .black26,
                                                                  fontSize:
                                                                      10.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ),
                                                          TextSpan(
                                                              text: 'scan here',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                textStyle: const TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                    fontSize:
                                                                        10.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, right: 15, left: 15),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: getScreenWidth(
                                                            context, 200),
                                                        child: Text(
                                                          "card number:",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle: const TextStyle(
                                                                color: AppColors
                                                                    .theamPrimaryColor,
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: getScreenHeight(
                                                        context, 5),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: getScreenWidth(
                                                            context, 200),
                                                        child: Text(
                                                          "${widget.cardNumber}:",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle: const TextStyle(
                                                                color: AppColors
                                                                    .theamSecondaryColor,
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Clipboard.setData(
                                                              ClipboardData(
                                                                  text:
                                                                      "${widget.cardNumber}"));

                                                          final snackBar =
                                                              SnackBar(
                                                            content: Text(
                                                                'Copied to Clipboard'),
                                                            action:
                                                                SnackBarAction(
                                                              label: 'Undo',
                                                              onPressed: () {},
                                                            ),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                          // });
                                                        },
                                                        child: const Icon(
                                                          Icons.copy_all_sharp,
                                                          color: Colors.black26,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, right: 15, left: 15),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: getScreenWidth(
                                                            context, 200),
                                                        child: Text(
                                                          "expir date:",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle: const TextStyle(
                                                                color: AppColors
                                                                    .theamPrimaryColor,
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: getScreenHeight(
                                                        context, 5),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: getScreenWidth(
                                                            context, 200),
                                                        child: Text(
                                                          "${widget.expDate}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle: const TextStyle(
                                                                color: AppColors
                                                                    .theamSecondaryColor,
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          Clipboard.setData(
                                                              ClipboardData(
                                                                  text:
                                                                      "${widget.expDate}"));

                                                          final snackBar =
                                                              SnackBar(
                                                            content: Text(
                                                                'Copied to Clipboard'),
                                                            action:
                                                                SnackBarAction(
                                                              label: 'Undo',
                                                              onPressed: () {},
                                                            ),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                          // });
                                                        },
                                                        child: const Icon(
                                                          Icons.copy_all_sharp,
                                                          color: Colors.black26,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, right: 15, left: 15),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: getScreenWidth(
                                                            context, 200),
                                                        child: Text(
                                                          "Aplication type:",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle: const TextStyle(
                                                                color: AppColors
                                                                    .theamPrimaryColor,
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: getScreenHeight(
                                                        context, 5),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: getScreenWidth(
                                                            context, 200),
                                                        child: Text(
                                                          "${widget.cardType == 'CardIssuer.visa' ? 'Visa' : 'Master'}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle: const TextStyle(
                                                                color: AppColors
                                                                    .theamSecondaryColor,
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  getScreenHeight(context, 30),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                log('Scan Card');
                                                // Save new data
                                                await addItem(
                                                        saveType: "Scan Card")
                                                    .then((value) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyCards()));
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Container(
                                                  width: (MediaQuery.of(context)
                                                          .size
                                                          .width) *
                                                      0.85,
                                                  height: getScreenHeight(
                                                      context, 65),
                                                  decoration: BoxDecoration(
                                                    color: AppColors
                                                        .theamSecondaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Save Card',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              )),
                  ),
                ],
              )
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    // autogroupzi3j4Fs (CSZZFBPJk74YYMxvYLZi3j)
                    // padding: EdgeInsets.fromLTRB(
                    //     50 * fem, 18 * fem, 54 * fem, 18 * fem),
                    width: double.infinity,
                    height: 97 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(74 * fem),
                      gradient: const RadialGradient(
                        center: Alignment(0, -1),
                        radius: 2,
                        colors: <Color>[Color(0xff294478), Color(0xff112246)],
                        stops: <double>[0, 1],
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x4c0f0aec),
                            offset: Offset(1, 1),
                            blurRadius: 6),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyCards()));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              const ImageIcon(
                                AssetImage("assets/images/my_card.png"),
                                color: Colors.white,
                                size: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  'My cards',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        children: const [
                          ImageIcon(
                            AssetImage("assets/images/add.png"),
                            color: AppColors.white,
                            size: 60,
                          ),
                          Positioned(
                            top: 15,
                            left: 15,
                            child: ImageIcon(
                              AssetImage("assets/images/main_vert.png"),
                              color: AppColors.white,
                              size: 30,
                            ),
                          ),
                          Positioned(
                            top: 15,
                            left: 15,
                            child: ImageIcon(
                              AssetImage("assets/images/main_hor.png"),
                              color: AppColors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CreditCardScanner()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              const ImageIcon(
                                AssetImage("assets/images/card_list.png"),
                                color: Colors.white,
                                size: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  'Add new',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FireAuth {
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateProfile(displayName: name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }
}
