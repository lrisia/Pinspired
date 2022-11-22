import 'dart:ui';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets/bottom_bar_creative.dart';
import '../widgets/input_decoration.dart';

class gridView extends StatelessWidget {
  const gridView({super.key});

  @override
  Widget build(BuildContext context) {
    const List<TabItem> items = [
      TabItem(
        icon: Icons.home,
      ),
      TabItem(
        icon: Icons.attach_money,
      ),
      TabItem(
        icon: Icons.add,
      ),
      TabItem(
        icon: Icons.message,
      ),
      TabItem(
        icon: Icons.account_box,
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Search'),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    cursorColor: Colors.white,
                  ),
                ),
                Icon(Icons.search)
              ],
            ),
          ),
        ),
        body: masonryLayout(context),
        bottomNavigationBar: Creative(
          items: items,
          isFloating: true,
          highlightStyle: HighlightStyle(
            sizeLarge: true,
            background: Color.fromARGB(255, 6, 134, 238),
            elevation: 3,
          ),
        ),
      ),
    );
  }

  Widget masonryLayout(BuildContext context) {
    return MasonryGridView.builder(
      scrollDirection: Axis.vertical,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      gridDelegate:
          SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: 30,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (() {
            print(1);
          }),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
                "https://source.unsplash.com/random/?Cryptocurrency&$index"),
          ),
        );
      },
    );
  }
}
