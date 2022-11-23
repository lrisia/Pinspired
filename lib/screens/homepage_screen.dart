import 'dart:ui';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/input_decoration.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          extendBodyBehindAppBar: true,
          // appBar: AppBar(
          //   // make appbar same in figma, add blur, linear gradient, normal search field
          //     backgroundColor: Colors.transparent,
          //     elevation: 0,
              // leading: Container(
              //   width: double.infinity,
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Column(children: [
              //     AnimSearchBar(
              //       width: 400,
              //       textController: textController,
              //       onSuffixTap: () {
              //         setState(() {
              //           textController.clear();
              //         });
              //       },
              //       helpText: "Search something...",
              //       animationDurationInMilli: 500,
              //     ),
              //   ]),
              // )
              // ),
          body: masonryLayout(context), // add this with stack for make search icon flow above grid and padding grid to make spacing between edge
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
                "https://source.unsplash.com/random/$index"),
          ),
        );
      },
    );
  }
}
