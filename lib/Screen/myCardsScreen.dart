import 'package:credit_card_reader/Screen/widgets/leading_icon.dart';
import 'package:credit_card_reader/Service/service.dart';
import 'package:credit_card_reader/configure/colors.dart';
import 'package:credit_card_reader/utils/get_screen_size.dart';
import 'package:flutter/material.dart';
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
        _holderNameController.text);
    _refreshData();
  }

  // Update an existing data
  Future<void> updateItem(int id) async {
    await DatabaseHelper.updateItem(
        id,
        _CardNumberController.text,
        _expDateController.text,
        _cardTypeController.text,
        _holderNameController.text);
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
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : myData.isEmpty
                  ? const Center(child: Text("No Data Available!!!"))
                  : SizedBox(
                      height: getScreenHeight(context, 750),
                      child: ListView.builder(
                        itemCount: myData.length,
                        itemBuilder: (context, index) => Card(
                          color: index % 2 == 0
                              ? AppColors.white
                              : Color.fromARGB(255, 237, 234, 234),
                          margin: const EdgeInsets.all(15),
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showMyForm(null),
      ),
    );
  }
}
