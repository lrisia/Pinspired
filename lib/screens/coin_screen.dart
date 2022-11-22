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
  int topup = 0;
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kColorsBlack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        //Image.asset("assets/img.png", width: 170, height: 300),padding: const EdgeInsets.only(top: 25),

        child: InkWell(
          onTap: () {
            // FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: Container(),
                    ),
                  ),
                ),
              ),
              topUp(),
              Padding(
                padding: const EdgeInsets.only(top: 350, bottom: 10),
                child: InkWell(
                  onTap: () {},
                  child: MainBtnWidget(
                    colorBtn: Color(0xFF72EC70),
                    textBtn: 'TopUp',
                    isTransparent: false,
                    haveIcon: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget topUp() {
    return Stack(
      children: [
        Container(
          height: 450,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          top: 150,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Container(
                  height: 240,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: kColorsWhite,
                      boxShadow: [
                        BoxShadow(
                          color: kColorsBlack.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ]),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Remaining coin 1100',
                        style: Theme.of(context).textTheme.headline4),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        height: 1.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(color: kColorsCream),
                      ),
                    ),
                    Container(
                      height: 130,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
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
                                    child: CoinBtnWidget(
                                        textBtn: '${amountList[index]}')),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
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
