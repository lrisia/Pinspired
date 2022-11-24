import 'dart:developer';
import 'dart:ui';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:cnc_shop/model/user_model.dart';
import 'package:cnc_shop/service/auth_service.dart';
import 'package:cnc_shop/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/input_decoration.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TextEditingController textController = TextEditingController();
  String _searchKeyword = '';
  final String _apiUrl = "https://source.unsplash.com/random/";
  User? user;

  @override
  Widget build(BuildContext context) {
  final authService = Provider.of<AuthService>(context, listen: false);

    authService.currentUser().then((currentUser) {
      if (!mounted) return;
      setState(() {
        user = currentUser;
      });
    });

    return Scaffold(
        body: user == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            :
        Stack(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
          child: masonryLayout(context),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: AnimSearchBar(
            width: 350,
            textController: textController,
            onSuffixTap: () {
              setState(() {
                _searchKeyword = (textController.value.text.isEmpty) ? '' : textController.value.text;
                textController.clear();
              });
            },
            color: kColorsSky,
            helpText: "search something...",
            closeSearchOnSuffixTap: true,
            animationDurationInMilli: 500,
          ),
        )
      ],
    ));
  }

  Widget masonryLayout(BuildContext context) {
    // int _itemCount = 40;
    // List<Image> _images =  [];

    return MasonryGridView.builder(
      scrollDirection: Axis.vertical,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      gridDelegate:
          SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 50,
      itemBuilder: (context, index) {
        // _images.add(Image.network("https://source.unsplash.com/random/$index"));
        print("run in masony layout");
        return InkWell(
          onTap: (() {
            // print(_images[index]);
          }),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            // child: _images[index],
            child: _searchKeyword == ''
                ? Image.network("https://source.unsplash.com/random/$index")
                : Image.network(
                    "https://source.unsplash.com/random/?$_searchKeyword&$index"),
          ),
        );
      },
    );
  }
}
