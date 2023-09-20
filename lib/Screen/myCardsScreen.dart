import 'dart:developer';

import 'package:credit_card_reader/Screen/cardScanner.dart';
import 'package:credit_card_reader/Screen/widgets/leading_icon.dart';
import 'package:credit_card_reader/Service/service.dart';
import 'package:credit_card_reader/configure/colors.dart';
import 'package:credit_card_reader/utils/get_screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCards extends StatefulWidget {
  const MyCards({Key? key}) : super(key: key);

  @override
  _MyCardsState createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
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

  @override
  void initState() {
    super.initState();
    _refreshData(); // Loading the data when the app starts
  }

  final TextEditingController _CardNumberController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();
  final TextEditingController _cardTypeController = TextEditingController();
  final TextEditingController _holderNameController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void showMyForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingData = myData.firstWhere((element) => element['id'] == id);
      _CardNumberController.text = existingData['cardnumber'];
      _expDateController.text = existingData['expdate'];
      _cardTypeController.text = existingData['cardType'];
      _holderNameController.text = existingData['holdername'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _CardNumberController,
                    decoration: const InputDecoration(hintText: 'Card Number'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _expDateController,
                    decoration: const InputDecoration(hintText: 'Exp Date'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _cardTypeController,
                    decoration: const InputDecoration(hintText: 'type'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _holderNameController,
                    decoration: const InputDecoration(hintText: 'Holder'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new data
                      if (id == null) {
                        await addItem();
                      }

                      if (id != null) {
                        await updateItem(id);
                      }

                      // Clear the text fields
                      _CardNumberController.text = '';
                      _expDateController.text = '';
                      _cardTypeController.text = '';
                      _holderNameController.text = '';

                      // Close the bottom sheet
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

// Insert a new data to the database
  Future<void> addItem() async {
    await DatabaseHelper.createItem(
        _CardNumberController.text,
        _expDateController.text,
        _cardTypeController.text,
        _holderNameController.text,
        'Virtual Card');
    _refreshData();
  }

  // Update an existing data
  Future<void> updateItem(int id) async {
    await DatabaseHelper.updateItem(
        id,
        _CardNumberController.text,
        _expDateController.text,
        _cardTypeController.text,
        _holderNameController.text,
        'Virtual Card');
    _refreshData();
  }

  // Delete an item
  void deleteItem(int id) async {
    await DatabaseHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully deleted!'), backgroundColor: Colors.green));
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          elevation: 0,
          leading: InkWell(onTap: () {}, child: const LeadingIcon())),
      body: Column(
        children: [
          SizedBox(
            width: getScreenWidth(context, 350),
            child: Text(
              "Saved Cards List",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: AppColors.theamSecondaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : myData.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            // width: getScreenWidth(context, 30),
                            // height: getScreenHeight(context, 30),
                            child: Image.asset(
                              'assets/images/empty.jpg',
                              // color: AppColors.theamSecondaryColor,
                              scale: 3,
                            ),
                          ),
                        ),
                        Text(
                          "Oops!  \nNo data found",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                color: AppColors.theamSecondaryColor,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ))
                  : SizedBox(
                      height: getScreenHeight(context, 750),
                      child: ListView.builder(
                        itemCount: myData.length,
                        itemBuilder: (context, index) => Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          color: AppColors.white,

                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: IconButton(
                                        onPressed: () {
                                          deleteItem(myData[index]['id']);
                                        },
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Colors.black38,
                                        )),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: getScreenWidth(context, 200),
                                  child: Text(
                                    "${myData[index]['saveType'].toString()}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color: AppColors.theamSecondaryColor,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400),
                                    ),
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
                                  myData[index]['cardtype'].toString() ==
                                          'CardIssuer.visa'
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
                                        child: Text(myData[index]['cardnumber'],
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white))),
                                  ),
                                  Positioned(
                                    top: 145,
                                    left: 45,
                                    child: SizedBox(
                                        child: Text(
                                            "expire ${myData[index]['expdate']}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white))),
                                  ),
                                ],
                              ),
                              Column(
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
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width:
                                                  getScreenWidth(context, 200),
                                              child: Text(
                                                "card number:",
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      color: AppColors
                                                          .theamPrimaryColor,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: getScreenHeight(context, 5),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width:
                                                  getScreenWidth(context, 200),
                                              child: Text(
                                                "${myData[index]['cardnumber']}:",
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      color: AppColors
                                                          .theamSecondaryColor,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Clipboard.setData(ClipboardData(
                                                    text:
                                                        "${myData[index]['cardnumber']}"));

                                                final snackBar = SnackBar(
                                                  content: Text(
                                                      'Copied to Clipboard'),
                                                  action: SnackBarAction(
                                                    label: 'Undo',
                                                    onPressed: () {},
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
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
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width:
                                                  getScreenWidth(context, 200),
                                              child: Text(
                                                "expir date:",
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      color: AppColors
                                                          .theamPrimaryColor,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: getScreenHeight(context, 5),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width:
                                                  getScreenWidth(context, 200),
                                              child: Text(
                                                "${myData[index]['expdate']}",
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      color: AppColors
                                                          .theamSecondaryColor,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                Clipboard.setData(ClipboardData(
                                                    text:
                                                        "${myData[index]['expdate']}"));

                                                final snackBar = SnackBar(
                                                  content: Text(
                                                      'Copied to Clipboard'),
                                                  action: SnackBarAction(
                                                    label: 'Undo',
                                                    onPressed: () {},
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
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
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width:
                                                  getScreenWidth(context, 200),
                                              child: Text(
                                                "Aplication type:",
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      color: AppColors
                                                          .theamPrimaryColor,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: getScreenHeight(context, 5),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width:
                                                  getScreenWidth(context, 200),
                                              child: Text(
                                                "${myData[index]['cardtype'] == 'CardIssuer.visa' ? 'Visa' : 'Master'}",
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      color: AppColors
                                                          .theamSecondaryColor,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: getScreenHeight(context, 30),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // ListTile(
                          //     title: Text(myData[index]['cardnumber']),
                          //     subtitle: Column(
                          //       children: [
                          //         Text(myData[index]['expdate']),
                          //         Text(myData[index]['cardtype']),
                          //         Text(myData[index]['holdername']),
                          //       ],
                          //     ),
                          //     trailing: SizedBox(
                          //       width: 100,
                          //       child: Row(
                          //         children: [
                          //           IconButton(
                          //             icon: const Icon(Icons.edit),
                          //             onPressed: () =>
                          //                 showMyForm(myData[index]['id']),
                          //           ),
                          //           IconButton(
                          //             icon: const Icon(Icons.delete),
                          //             onPressed: () =>
                          //                 deleteItem(myData[index]['id']),
                          //           ),
                          //         ],
                          //       ),
                          //     )),
                        ),
                      ),
                    ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: const Icon(Icons.add),
      //     onPressed: () => Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) => const CreditCardScanner()))),
    );
  }
}
