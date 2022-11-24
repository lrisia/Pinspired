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
            :
        Stack(
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: StreamBuilder<List<Post?>>(
                stream: databaseService.getStreamListPost(),
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
                                onTap: () async{
                                 String? username = await getUsername(snapshot, index);
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            content: SingleChildScrollView(
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            20, 160, 20, 5),
                                                    child: Column(
                                                      children: [
                                                        
                                                        Text("Upload by ${username}" ,
                                                            style: TextStyle(
                                                                fontSize: 24),
                                                            textAlign: TextAlign
                                                                .left),
                                                        Text("Descripton: ${snapshot.data?[index]?.description}",
                                                            style: TextStyle(
                                                                fontSize: 24),
                                                            textAlign: TextAlign
                                                                .left),
                                                        Text("Tag: ${snapshot.data?[index]?.tag.toString().split('.')[1]}",
                                                            style: TextStyle(
                                                                fontSize: 24),
                                                            textAlign: TextAlign
                                                                .left)
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: 0,
                                                      child: Image(
                                                          image: NetworkImage(
                                                              snapshot
                                                                      .data?[
                                                                          index]
                                                                      ?.photoURL ??
                                                                  ''),
                                                          height: 150))
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ));
                                },
                                child: Image(
                                  image: NetworkImage(
                                      snapshot.data?[index]?.photoURL ?? ''),
                                ),
                              )


                              ));
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

  Future<String?> getUsername(dynamic snapshot, dynamic index) async{
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);
    User? user;
    String? username;
  user = await databaseService.getUserFromUid(uid: snapshot.data?[index]?.userId);
  
  if(user!.username.isNotEmpty){
      username= user.username;
      print(username);
  }
  return username;
  }

}
