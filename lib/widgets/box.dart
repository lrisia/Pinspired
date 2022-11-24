// ignore_for_file: prefer_const_constructors

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
  final String state;
  final String description;

  Box(
    this.user_hirer,
    this.user_workForHire,
    this.cost,
    this.state,
    this.description,
  );

  @override
  Widget build(BuildContext context)  {

        final databaseService =
        Provider.of<DatabaseService>(context, listen: false);


    return Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                    child: Text(
                      "user_hirer",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 20, 0),
                      child: Text(
                        '${NumberFormat("#,###.##").format(cost)}',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 0, 0),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 133, 132, 132),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 0, 0),
                    child: Text(
                      "State:",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }



  }

