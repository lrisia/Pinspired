import 'dart:developer';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:cnc_shop/model/product_model.dart';
import 'package:cnc_shop/screens/another_profile_screen.dart';
import 'package:cnc_shop/screens/coin_screen.dart';
import 'package:cnc_shop/model/request_model.dart';
import 'package:cnc_shop/screens/homepage_screen.dart';
import 'package:cnc_shop/screens/myself_profile_screen.dart';
import 'package:cnc_shop/screens/product_info_screen.dart';
import 'package:cnc_shop/screens/profile_screen.dart';
import 'package:cnc_shop/screens/register_screen.dart';
import 'package:cnc_shop/screens/request_screen.dart';
import 'package:cnc_shop/screens/top_up_screen.dart';
import 'package:cnc_shop/screens/upload_screen.dart';
import 'package:cnc_shop/service/database_service.dart';
import 'package:cnc_shop/themes/color.dart';
import 'package:cnc_shop/widgets/nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _screen = [
    UploadScreen(),
    CoinScreen(),
    HomePageScreen(),
    RequestScreen(),
    MyselfProfileScreen()
  ];

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
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          extendBodyBehindAppBar: true,
        
          body: Center(
            child: _screen.elementAt(_currentIndex),
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            child: BottomBarInspiredInside(
              height: 30,
              items: items,
              backgroundColor: Color.fromARGB(255, 182, 226, 240),
              color: kColorsBlack,
              colorSelected: Colors.white,
              indexSelected: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              chipStyle: ChipStyle(convexBridge: true, background: kColorsSky),
              itemStyle: ItemStyle.circle,
              animated: true,
            ),
          ),
        ));
  }


  
}
