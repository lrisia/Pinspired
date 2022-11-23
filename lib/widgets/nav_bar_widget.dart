import 'package:cnc_shop/screens/profile_screen.dart';
import 'package:cnc_shop/screens/top_up_screen.dart';
import 'package:cnc_shop/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';

class NavBarWidget extends StatefulWidget {
  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  final List<TabItem> items = [
    TabItem(
      icon: Icons.add,
    ),
    TabItem(
      icon: Icons.attach_money,
    ),
    TabItem(
      icon: Icons.home,
    ),
    TabItem(
      icon: Icons.message,
    ),
    TabItem(
      icon: Icons.account_box,
    ),
  ];

  int visit = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topCenter,
      //     end: Alignment(0.2, 0.1),
      //     colors: [
      //       Color.fromARGB(255, 5, 193, 255),
      //       Color.fromARGB(255, 255, 0, 0),
      //     ],
      //   ),
      // ),
      child: BottomBarInspiredInside(
        height: 30,
        items: items,
        backgroundColor: Color(0xFFE1F8FF),
        color: kColorsBlack,
        colorSelected: Colors.white,
        indexSelected: visit,
        onTap: (int index) {
          setState(() {
            visit = index;
            navBarTapHandler();
          });
        },
        chipStyle: ChipStyle(convexBridge: true, background: Colors.blue),
        itemStyle: ItemStyle.circle,
        animated: true,
      ),
    );
  }

  void navBarTapHandler() {
    if (visit == 1)
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => new TopUpScreen()));
  }
}
