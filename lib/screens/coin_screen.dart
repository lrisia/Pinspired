import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../service/auth_service.dart';
import '../service/database_service.dart';
import '../themes/color.dart';
import '../utils/showSnackBar.dart';
import '../widgets/coin_btn_widget.dart';
import '../widgets/main_btn_widget.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({Key? key}) : super(key: key);

  @override
  State<CoinScreen> createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  int topup = 100;
  List<int> amountList = [100, 300, 500, 700, 1000, 2000];
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
        backgroundColor: kColorsSky,
        body: user == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment(0.2, 0.1),
                    colors: [
                      Color(0xFF68CBEB),
                      Color.fromARGB(255, 255, 255, 255),
                    ],
                  ),
                ),
                //Image.asset("assets/img.png", width: 170, height: 300),padding: const EdgeInsets.only(top: 25),

                child: InkWell(
                  onTap: () {
                    // FocusScope.of(context).unfocus();
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 10),
                          child: Text(
                            'COIN',
                            style: TextStyle(
                              color: kColorsSky,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.55,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      topUp(),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15, left: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text("Amount:",
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Spacer(),
                                            Text("${topup}",
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Image.asset(
                                              "assets/icons/coin.png",
                                              scale: 10,
                                            )
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: Text('Top up'),
                                                      content: Text(
                                                          'Top up ${topup} coin.'),
                                                      actionsAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      actions: <Widget>[
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  'Cancel');
                                                            },
                                                            child:
                                                                Text('Cancel')),
                                                        TextButton(
                                                            onPressed: () {
                                                              user!.coin =
                                                                  user!.coin! +
                                                                      topup;

                                                              final databaseService =
                                                                  Provider.of<
                                                                          DatabaseService>(
                                                                      context,
                                                                      listen:
                                                                          false);

                                                              databaseService
                                                                  .updateUserFromUid(
                                                                      uid: user!
                                                                          .uid,
                                                                      user:
                                                                          user!)
                                                                  .then(
                                                                      (value) {
                                                                // success state
                                                                // showSnackBar(
                                                                //     'success',
                                                                //     backgroundColor:
                                                                //         Colors
                                                                //             .green);
                                                                            topup = 100;
                                                              }).catchError(
                                                                      (e) {
                                                                //handle error
                                                                // showSnackBar(
                                                                //     e
                                                                //         .toString(),
                                                                //     backgroundColor:
                                                                //         Colors
                                                                //             .red);
                                                              });
                                                              Navigator.pop(
                                                                  context,
                                                                  'Ok');
                                                            },
                                                            child: Text('Ok')),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                child: MainBtnWidget(
                                                  colorBtn: Color(0xFF72EC70),
                                                  textBtn: 'TopUp',
                                                  isTransparent: false,
                                                  haveIcon: false,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: InkWell(
                                                onTap: () {
                                                  if (user!.coin! >= topup) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: Text('Withdraw'),
                                                        content: Text(
                                                            'Withdraw ${topup} coin.'),
                                                        actionsAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        actions: <Widget>[
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context,
                                                                    'Cancel');
                                                              },
                                                              child: Text(
                                                                  'Cancel')),
                                                          TextButton(
                                                              onPressed: () {
                                                                user!.coin =
                                                                    user!.coin! -
                                                                        topup;

                                                                final databaseService =
                                                                    Provider.of<
                                                                            DatabaseService>(
                                                                        context,
                                                                        listen:
                                                                            false);

                                                                databaseService
                                                                    .updateUserFromUid(
                                                                        uid: user!
                                                                            .uid,
                                                                        user:
                                                                            user!)
                                                                    .then(
                                                                        (value) {
                                                                  // success state
                                                                  showSnackBar(
                                                                      'success',
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green);
                                                                              topup = 100;
                                                                }).catchError(
                                                                        (e) {
                                                                  //handle error
                                                                  showSnackBar(
                                                                      e,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red);
                                                                });
                                                                Navigator.pop(
                                                                    context,
                                                                    'Ok');
                                                              },
                                                              child:
                                                                  Text('Ok')),
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) => AlertDialog(
                                                          title:
                                                              Text('Withdraw'),
                                                          content: Text(
                                                              "You don't have enough money to withdraw."),
                                                          actionsAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          actions: <Widget>[
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      'Ok');
                                                                },
                                                                child:
                                                                    Text('Ok')),
                                                          ]),
                                                    );
                                                  }
                                                },
                                                child: MainBtnWidget(
                                                  colorBtn: Color(0xFFEC7070),
                                                  textBtn: 'Withdraw',
                                                  isTransparent: false,
                                                  haveIcon: false,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ));
  }

  Widget topUp() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          alignment: Alignment.centerLeft,
          child: Text('Remaining coin: ${user!.coin!.round()}',
              style: Theme.of(context).textTheme.headline5),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 1.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: kColorsCream),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            //todo make box shadow
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              runSpacing: 10.0,
              spacing: 30.0,
              children: [
                ...List.generate(
                  amountList.length,
                  (index) => InkWell(
                      onTap: () {
                        setState(() {
                          topup = amountList[index];
                        });
                      },
                      child: CoinBtnWidget(textBtn: '${amountList[index]}')),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  // Create input Amount Tab
  Widget inputAmount() {
    return Container(
      height: 85,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: kColorsWhite,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Input Amount',
                  style: Theme.of(context).textTheme.headline4),
              Text(
                '\$ $topup',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: kColorsBlack),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
