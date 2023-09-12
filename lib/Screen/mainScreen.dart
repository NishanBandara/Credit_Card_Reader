import 'package:credit_card_reader/Screen/cardScanner.dart';
import 'package:credit_card_reader/Screen/homeScreen.dart';
import 'package:credit_card_reader/Screen/loginScreen.dart';
import 'package:credit_card_reader/configure/colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 1;

  final List<Widget> _pages = [
    HomeScreen(
      cardNumber: "12313213",
      cardType: "CardIssuer.mastercard",
      expDate: "03/06",
      holderName: "MONTHLY",
    ),
    const LoginScreen(),
    const CreditCardScanner(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _pages[_currentPageIndex],
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Stack(
                children: [
                  Container(
                    width: 393,
                    height: 97,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(74),
                      gradient: const LinearGradient(
                        begin: Alignment(0, -1),
                        end: Alignment(0, 1),
                        colors: <Color>[Color(0xff293e69), Color(0xff0b1c3f)],
                        stops: <double>[0, 1],
                      ),
                    ),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.transparent,
                      showUnselectedLabels: true,
                      type: BottomNavigationBarType.fixed,
                      elevation: 0,
                      items: [
                        BottomNavigationBarItem(
                          icon: _currentPageIndex == 0
                              ? const ImageIcon(
                                  AssetImage("assets/images/my_card.png"),
                                  color: Colors.black,
                                  size: 25,
                                )
                              : const ImageIcon(
                                  AssetImage("assets/images/my_card.png"),
                                  color: AppColors.white,
                                  size: 25,
                                ),
                          label: "My cards",
                        ),
                        BottomNavigationBarItem(
                          icon: _currentPageIndex == 1
                              ? const ImageIcon(
                                  AssetImage("assets/images/add.png"),
                                  color: Colors.black,
                                  size: 25,
                                )
                              : Stack(
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
                                        AssetImage(
                                            "assets/images/main_vert.png"),
                                        color: AppColors.white,
                                        size: 30,
                                      ),
                                    ),
                                    Positioned(
                                      top: 15,
                                      left: 15,
                                      child: ImageIcon(
                                        AssetImage(
                                            "assets/images/main_hor.png"),
                                        color: AppColors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                          label: "",
                        ),
                        BottomNavigationBarItem(
                          icon: _currentPageIndex == 2
                              ? const ImageIcon(
                                  AssetImage("assets/images/card_list.png"),
                                  color: Colors.black,
                                  size: 25)
                              : const ImageIcon(
                                  AssetImage("assets/images/card_list.png"),
                                  color: AppColors.white,
                                  size: 25,
                                ),
                          label: "Add new",
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),

      // _pages[_currentPageIndex],
      // bottomNavigationBar: BottomNavigationBar(
      //     currentIndex: _currentPageIndex,
      //     onTap: _onPageChanged,
      //     showSelectedLabels: true,
      //     showUnselectedLabels: true,
      //     fixedColor: Colors.black,
      //     unselectedItemColor: Colors.black,
      //     selectedFontSize: 12.0,
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: _currentPageIndex == 0
      //             ? const ImageIcon(
      //                 AssetImage("assets/icons/navigator/home_icon.png"),
      //                 color: Colors.black,
      //                 size: 25,
      //               )
      //             : const ImageIcon(
      //                 AssetImage("assets/icons/navigator/home_icon.png"),
      //                 color: AppColors.white,
      //                 size: 25,
      //               ),
      //         label: "Home",
      //       ),
      //       BottomNavigationBarItem(
      //         icon: _currentPageIndex == 1
      //             ? const ImageIcon(
      //                 AssetImage("assets/icons/navigator/chat_icon.png"),
      //                 color: Colors.black,
      //                 size: 25,
      //               )
      //             : const ImageIcon(
      //                 AssetImage("assets/icons/navigator/chat_icon.png"),
      //                 color: AppColors.white,
      //                 size: 25,
      //               ),
      //         label: "Chat",
      //       ),
      //       BottomNavigationBarItem(
      //         icon: _currentPageIndex == 2
      //             ? const ImageIcon(
      //                 AssetImage("assets/icons/navigator/recipes_icon.png"),
      //                 color: Colors.black,
      //                 size: 25)
      //             : const ImageIcon(
      //                 AssetImage("assets/icons/navigator/recipes_icon.png"),
      //                 color: AppColors.white,
      //                 size: 25,
      //               ),
      //         label: "Recipes",
      //       ),
      //     ]),
    );
  }
}

// Widget bottomNavigationBar() {
//   return Container(
//     margin: const EdgeInsets.only(left: 16, right: 16),
//     decoration: const BoxDecoration(
//       color: Colors.amber,
//       borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(200), topRight: Radius.circular(200)),
//     ),
//     child: BottomNavigationBar(
//       backgroundColor: Colors.transparent,
//       showUnselectedLabels: true,
//       type: BottomNavigationBarType.fixed,
//       elevation: 0,
//       items: [
//         BottomNavigationBarItem(
//           icon: _currentPageIndex == 0
//               ? const ImageIcon(
//                   AssetImage("assets/icons/navigator/home_icon.png"),
//                   color: Colors.black,
//                   size: 25,
//                 )
//               : const ImageIcon(
//                   AssetImage("assets/icons/navigator/home_icon.png"),
//                   color: AppColors.white,
//                   size: 25,
//                 ),
//           label: "Home",
//         ),
//         BottomNavigationBarItem(
//           icon: _currentPageIndex == 1
//               ? const ImageIcon(
//                   AssetImage("assets/icons/navigator/chat_icon.png"),
//                   color: Colors.black,
//                   size: 25,
//                 )
//               : const ImageIcon(
//                   AssetImage("assets/icons/navigator/chat_icon.png"),
//                   color: AppColors.white,
//                   size: 25,
//                 ),
//           label: "Chat",
//         ),
//         BottomNavigationBarItem(
//           icon: _currentPageIndex == 2
//               ? const ImageIcon(
//                   AssetImage("assets/icons/navigator/recipes_icon.png"),
//                   color: Colors.black,
//                   size: 25)
//               : const ImageIcon(
//                   AssetImage("assets/icons/navigator/recipes_icon.png"),
//                   color: AppColors.white,
//                   size: 25,
//                 ),
//           label: "Recipes",
//         ),
//       ],
//     ),
//   );
// }
