import 'dart:convert';
import 'dart:developer';

import 'package:cnc_shop/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductInfoScreen extends StatefulWidget {
  ProductInfoScreen({Key? key}) : super(key: key);

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final Map data =
        json.decode(ModalRoute.of(context)!.settings.arguments.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            color: kColorsPurple,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kColorsWhite,
        title: Text(
          'Add Product',
          style: Theme.of(context).textTheme.headline3,
        ),
        // สร้างเส้นคั่นระหว่าง appbar กับ body
        shape: Border(bottom: BorderSide(color: kColorsCream, width: 1.5)),

        // ระดับของเงา
        elevation: 0,

        // ความสูงของ appbar ด้านบน
        toolbarHeight: 60,

        // สร้างปุ่มด้านขวา
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/edit.svg',
                color: kColorsPurple,
              )),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/msg.svg',
                color: kColorsPurple,
              )),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: SvgPicture.asset(
                'assets/icons/me.svg',
                color: kColorsPurple,
              )),
        ],
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: kColorsCream,
                  image: data['photoURL'] != ""
                      ? DecorationImage(
                          image: NetworkImage(data['photoURL']),
                          fit: BoxFit.cover)
                      : null),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: ' + data['type']!.split(".")[1],
                    style: Theme.of(context).textTheme.headline4),
                Text(data['name']!,
                    style: Theme.of(context).textTheme.headline2),
                Text('฿ ' + data['price']!,
                    style: Theme.of(context).textTheme.subtitle1),
                Text('Quantity: ' + data['quantity']!,
                    style: Theme.of(context).textTheme.subtitle1),
                Text('\nDescription',
                    style: Theme.of(context).textTheme.subtitle1),
                Text(data['description']!,
                    style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
          )
        ],
      ),
    );
  }
}
