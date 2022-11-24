import 'dart:developer';
import 'dart:ui';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:cnc_shop/model/request_model.dart';
import 'package:cnc_shop/themes/color.dart';
import 'package:cnc_shop/widgets/box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../model/post_model.dart';
import '../model/user_model.dart';
import '../service/auth_service.dart';
import '../service/database_service.dart';
import '../widgets/nav_bar_widget.dart';
import '../widgets/input_decoration.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {

  User? user;

  @override
  Widget build(BuildContext context) {
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);

            final authService = Provider.of<AuthService>(context, listen: false);

    authService.currentUser().then((currentUser) {
      setState(() {
        user = currentUser;
      });
    });

    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment(0.1, 0.1),
                    colors: [
                      Color(0xFF68CBEB),
                      Color.fromARGB(255, 255, 255, 255),
                    ],
                  ),
                ),
            child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.only(top: 40, left: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text('TIP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                      child: Form(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.85,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30)),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  child: StreamBuilder<List<Request?>>(
                                      stream: databaseService
                                          .getStreamListRequest(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          log(snapshot.error.toString());
                                          return Center(
                                            child: Text('An error occure.'),
                                          );
                                        }
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: Text('No Request'),
                                          );
                                        }

                                        return ListView.builder(
                                            itemCount: snapshot.data?.length,
                                            itemBuilder: (context, index) {
                                              if(snapshot.data?[index]?.user_hirer != user?.uid &&
                                              snapshot.data?[index]?.user_workForHire != user?.uid){
                                                return SizedBox.shrink();
                                          
                                              }
                                              return Column(
                                                children: [
                                                  Box(
                                                    "${snapshot.data?[index]?.user_hirer}",
                                                    "${snapshot.data?[index]?.user_workForHire}",
                                                    snapshot.data?[index]?.cost,
                                                    "${snapshot.data?[index]?.description}",
                                                    ),
                                                  SizedBox(
                                                    height: 10,
                                                  )
                                                ],
                                              );
                                            });
                                      }),
                                ),
                              ))))
                ]))));
  }
}
