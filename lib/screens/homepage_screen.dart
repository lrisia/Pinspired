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
import '../model/post_model.dart';
import '../model/user_model.dart';
import '../service/database_service.dart';
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
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);
    return Scaffold(
        body: user == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                      child: StreamBuilder<List<Post?>>(
                          stream: databaseService.getStreamListPost(
                              userId: user!.uid, keyword: _searchKeyword),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              log(snapshot.error.toString());
                              return Center(
                                child: Text('An error occure.'),
                              );
                            }
                            if (!snapshot.hasData) {
                              return Center(
                                child: Text('No Post'),
                              );
                            }
                            //return masonryLayout(context);})),

                            return MasonryGridView.builder(
                              scrollDirection: Axis.vertical,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              gridDelegate:
                                  SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: InkWell(
                                          onTap: () async {
                                            String? username =
                                                await getUsername(
                                                    snapshot, index);
                                            showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5))),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                children: <
                                                                    Widget>[
                                                                  Image(
                                                                      image: NetworkImage(snapshot
                                                                              .data?[index]!
                                                                              .photoURL ??
                                                                          "https://firebasestorage.googleapis.com/v0/b/cnc-shop-caa9d.appspot.com/o/covers%2Fdefualt_cover.png?alt=media&token=c16965aa-a181-4c12-b528-b23221c23e17")),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                            10,
                                                                        top:
                                                                            10),
                                                                    child:
                                                                        InkWell(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .close,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                      onTap: () =>
                                                                          Navigator.pop(
                                                                              context),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Upload by ",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          fontStyle: FontStyle
                                                                              .italic,
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    InkWell(
                                                                      child:
                                                                          Text(
                                                                        "$username",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                22,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            decoration: TextDecoration.underline,
                                                                            color: Colors.black),
                                                                      ),
                                                                      onTap:
                                                                          () async {
                                                                        print(
                                                                            "Tap on username");
                                                                      },
                                                                    ),
                                                                    Spacer(),
                                                                    Text(
                                                                      "${snapshot.data?[index]?.tag.toString().split('.')[1]}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontStyle: FontStyle
                                                                              .italic,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                    "${snapshot.data?[index]?.description}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ));
                                          },
                                          child: Image(
                                            image: NetworkImage(snapshot
                                                    .data?[index]?.photoURL ??
                                                ''),
                                          ),
                                        )));
                              },
                            );
                          })),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: AnimSearchBar(
                      width: 350,
                      textController: textController,
                      onSuffixTap: () {
                        setState(() {
                          _searchKeyword = (textController.value.text.isEmpty)
                              ? ''
                              : textController.value.text;
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

  Future<String?> getUsername(dynamic snapshot, dynamic index) async {
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);
    User? user;
    String? username;
    user = await databaseService.getUserFromUid(
        uid: snapshot.data?[index]?.userId);

    if (user!.username.isNotEmpty) {
      username = user.username;
      print(username);
    }
    return username;
  }
}
