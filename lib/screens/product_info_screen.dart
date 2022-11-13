import 'dart:convert';
import 'dart:developer';

import 'package:cnc_shop/model/user_model.dart';
import 'package:cnc_shop/service/auth_service.dart';
import 'package:cnc_shop/service/database_service.dart';
import 'package:cnc_shop/themes/color.dart';
import 'package:cnc_shop/utils/showSnackBar.dart';
import 'package:cnc_shop/widgets/main_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class ProductInfoScreen extends StatefulWidget {
  ProductInfoScreen({Key? key}) : super(key: key);

  @override
  State<ProductInfoScreen> createState() => _ProductInfoScreenState();
}

class _ProductInfoScreenState extends State<ProductInfoScreen> {
  int _buyamount = 1;
  User? user;

  @override
  Widget build(BuildContext context) {
    final Map data =
        json.decode(ModalRoute.of(context)!.settings.arguments.toString());
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.currentUser().then((currentUser) {
      setState(() {
        user = currentUser;
      });
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            color: kColorsPurple,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kColorsWhite,
        title: Text(
          'Add Product',
          style: Theme.of(context).textTheme.headline3,
        ),
        // สร้างเส้นคั่นระหว่าง appbar กับ body
        shape: Border(bottom: BorderSide(color: kColorsCream, width: 1.5)),

        // ระดับของเงา
        elevation: 0,

        // ความสูงของ appbar ด้านบน
        toolbarHeight: 60,

        // สร้างปุ่มด้านขวา
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/edit.svg',
                color: kColorsPurple,
              )),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/msg.svg',
                color: kColorsPurple,
              )),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: SvgPicture.asset(
                'assets/icons/me.svg',
                color: kColorsPurple,
              )),
        ],
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: kColorsCream,
                  image: data['photoURL'] != ""
                      ? DecorationImage(
                          image: NetworkImage(data['photoURL']),
                          fit: BoxFit.cover)
                      : null),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: ' + data['type']!.split(".")[1],
                    style: Theme.of(context).textTheme.headline4),
                Text(data['name']!,
                    style: Theme.of(context).textTheme.headline2),
                Text('฿ ' + data['price']!,
                    style: Theme.of(context).textTheme.subtitle1),
                Text('Quantity: ' + data['quantity']!,
                    style: Theme.of(context).textTheme.subtitle1),
                Text('\nDescription',
                    style: Theme.of(context).textTheme.subtitle1),
                Text(data['description']!,
                    style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Buy this product?'),
                        content: Text(
                            'Buy ${data['name']} for ${data['price']}\nDisplay ไม่เปลี่ยนแต่ value เปลี่ยนแล้ว ให้ลองกดออกแล้วเข้ามาดูใหม่\nปุ่มเลื่อนใช้ได้แต่ยาก'),
                        actionsAlignment: MainAxisAlignment.spaceAround,
                        actions: <Widget>[
                          NumberPicker(
                            value: _buyamount,
                            minValue: 1,
                            maxValue: int.parse(data['quantity']),
                            step: 1,
                            itemHeight: 100,
                            axis: Axis.horizontal,
                            onChanged: (value) =>
                                setState(() => _buyamount = value),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.black26),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () => setState(() {
                                  log('before tap: $_buyamount');
                                  final newValue;
                                  if (_buyamount - 1 < 1) {
                                    newValue = 1;
                                  } else {
                                    newValue = _buyamount - 1;
                                  }
                                  _buyamount = newValue.clamp(0, 100);
                                  log('after tap: $_buyamount');
                                }),
                              ),
                              Text('Buy amount: $_buyamount'),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () => setState(() {
                                  log('before tap: $_buyamount');
                                  final quantity = int.parse(data['quantity']);
                                  final newValue;
                                  if (_buyamount + 1 > quantity) {
                                    newValue = quantity;
                                  } else {
                                    newValue = _buyamount + 1;
                                  }
                                  _buyamount = newValue.clamp(0, 100);
                                  log('after tap: $_buyamount');
                                }),
                              ),
                            ],
                          ),
                          Text(
                              'Summary: ${_buyamount * double.parse(data['price'])} ฿'),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'Cancel');
                                    },
                                    child: Text('Cancel')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'Ok');
                                      if (user!.coin! <
                                          _buyamount *
                                              double.parse(data['price'])) {
                                        showSnackBar('Not enough coin',
                                            backgroundColor: Colors.red);
                                      } else {
                                        user!.coin = (user!.coin! -
                                            _buyamount *
                                                double.parse(data['price']));
                                        final databaseService =
                                            Provider.of<DatabaseService>(
                                                context,
                                                listen: false);

                                        databaseService.updateUserFromUid(uid: user!.uid, user: user!)
                                            .then((value) {
                                              // TODO: make product decrease quantity
                                              data['quantity'] = int.parse(data['quantity']) - _buyamount;
                                              data['price'] = double.parse(data['price']);
                                              data['type'] = data['type']!.split(".")[1];
                                              databaseService.updateProductFromUid(product: data).then((value) {
                                                // success state
                                                showSnackBar('Buy success',
                                                    backgroundColor: Colors.green);
                                                Navigator.pushNamed(context, '/home');
                                                log('update product success');
                                              }).catchError((e) {
                                                showSnackBar(e.toString(),
                                                  backgroundColor: Colors.red);
                                                // error state in decrease quantity step
                                                log(e.toString());
                                                log('update product fail');
                                              });
                                        }).catchError((e) {
                                          // handle error
                                          showSnackBar(e.toString(),
                                              backgroundColor: Colors.red);
                                        });
                                      }
                                    },
                                    child: Text('Ok')),
                              ])
                        ],
                      ),
                    );
                    buyProductHandle(context: context, product: data);
                  },
                  child: MainBtnWidget(
                      colorBtn: kColorsRed,
                      textBtn: 'Buy now',
                      isTransparent: false,
                      haveIcon: false)))
        ],
      ),
    );
  }

  Future<void> buyProductHandle(
      {required BuildContext context, required Map product}) async {
    log(product.toString());
    // Navigator.pushNamed(context, '/buy_product', arguments: product);
  }
}
