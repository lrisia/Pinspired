// ignore_for_file: prefer_const_constructors

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../service/database_service.dart';


class Box extends StatelessWidget {
  final String user_hirer;
  final String user_workForHire;
  final int? cost;
  final String description;

  Box(
    this.user_hirer,
    this.user_workForHire,
    this.cost,
    this.description,
  );
  User? user;

  @override
  Widget build(BuildContext context) {
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);
    User? user;
    String? username;
    () async => user = await databaseService.getUserFromUid(uid: user_hirer);
    //  print(user!.username);

    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent), boxShadow: [
  BoxShadow(color: Colors.white, spreadRadius: 3)
],borderRadius: BorderRadius.circular(22),),
      child: BlurryContainer(
        blur: 55,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "User1",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    '+${NumberFormat("#,###.##").format(cost)}',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                  Icon(
                    Icons.attach_money,
                    color: Color.fromARGB(255, 255, 187, 0),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 12, 0, 10),
                  child: Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 57, 57, 57),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
