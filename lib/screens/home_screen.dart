import 'dart:developer';

import 'package:cnc_shop/model/product_model.dart';
import 'package:cnc_shop/service/database_service.dart';
import 'package:cnc_shop/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorsWhite,
        title: Text(
          'CNC Shop',
          style: Theme.of(context).textTheme.headline2,
        ),
        // สร้างเส้นคั่นระหว่าง appbar กับ body
        shape: Border(bottom: BorderSide(color: kColorsCream, width: 1.5)),

        // ระดับของเงา
        elevation: 0,

        // ความสูงของ appbar ด้านบน
        toolbarHeight: 60,

        // สร้าง appbar ด้านล่าง
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            height: 60,
          ),
        ),
        // สร้างปุ่มด้านขวา
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add-product');
              },
              // icon: Icon(Icons.add, color: Colors.black,),
              icon: SvgPicture.asset('assets/icons/add.svg')),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: SvgPicture.asset('assets/icons/me.svg')),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 110),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "My Family",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Home",
                      style: TextStyle(
                          color: Color(0xffa29aac),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    alignment: Alignment.topCenter,
                    icon: SvgPicture.asset('assets/icons/me.svg')),
              ],
            ),
          ),
          SizedBox(height: 40),
          //TODO Grid Dashboard
          // GridDashboard()
        ],
      ),
    );
  }

  Future<void> _refresh() {
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);
    databaseService.getFutureListProduct();
    return Future.delayed(Duration(seconds: 0));
  }
}
