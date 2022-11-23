import 'dart:developer';

import 'package:cnc_shop/service/auth_service.dart';
import 'package:cnc_shop/themes/color.dart';
import 'package:cnc_shop/utils/showSnackBar.dart';
import 'package:cnc_shop/widgets/input_decoration.dart';
import 'package:cnc_shop/widgets/main_btn_widget.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  bool formVaidate = false;
  var size = [0, 0, 0, 0];
  var _scollSize = 0.0;
  String? username, email, phone, password, confirmPassword, address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
   
      //Color(0xFF68CBEB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
          color: kColorsBlack,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
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
        
        child: Stack(
          //Image.asset("assets/img.png", width: 170, height: 300),
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/register_photo.png"),
                    alignment: Alignment(0, -0.81)),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: DraggableScrollableSheet(
                  initialChildSize: 0.6,
                  minChildSize: 0.6,
                  maxChildSize: formVaidate == false ? 0.6 : 0.6 + _scollSize,
                  builder: (_, scrollController) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: scrollController,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, top: 20, bottom: 20),
                              child: Text('Sign up new account',
                                  style: Theme.of(context).textTheme.headline5),
                            ),
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  CreateEmail(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CreateUsername(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CreatePassword(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CreateConfirmPassword(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 20),
                              child: InkWell(
                                onTap: () {
                                  registerHandle(context: context);
                                },
                                child: MainBtnWidget(
                                  colorBtn: kColorsSky,
                                  textBtn: 'Sign Up',
                                  isTransparent: false,
                                  haveIcon: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      );
    
  }

  Widget CreateUsername() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 40),
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: kColorsPurple),
          decoration: InputDecorationWidget(context, 'Username'),
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                formVaidate = true;
              });
              size[0] = 1;
              return "Please enter username";
            }
            size[0] = 0;
            return null;
          },
          onChanged: (value) {
            username = value;
          },
        ));
  }

  Widget CreateEmail() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 40),
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: kColorsPurple),
          decoration: InputDecorationWidget(context, 'Email'),
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                formVaidate = true;
              });
              size[1] = 1;
              return "Please enter Email";
            }
            size[1] = 0;
            return null;
          },
          onChanged: (value) {
            email = value;
          },
        ));
  }

  Widget CreatePassword() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 40),
        child: TextFormField(
          obscureText: true,
          keyboardType: TextInputType.text,
          autofocus: false,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: kColorsPurple),
          decoration: InputDecorationWidget(context, 'Password'),
          validator: (value) {
            if (value!.isEmpty) {
              setState(() {
                formVaidate = true;
              });
              size[2] = 1;
              return "Please enter password";
            }
            size[2] = 0;
            return null;
          },
          onChanged: (value) {
            password = value;
          },
        ));
  }

  Widget CreateConfirmPassword() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 40),
        child: TextFormField(
          obscureText: true,
          keyboardType: TextInputType.text,
          autofocus: false,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: kColorsPurple),
          decoration: InputDecorationWidget(context, 'Confirm Password'),
          validator: (value) {
            if (value!.isEmpty) {
              formVaidate = true;
              size[3] = 1;
              return "Please enter confirm password";
            } else if (password != null && value != password) {
              size[3] = 1;
              return "Those passwords didn't match. Try again.";
            }
            size[3] = 0;
            return null;
          },
          onChanged: (value) {
            confirmPassword = value;
          },
        ));
  }

  Future<void> registerHandle({required BuildContext context}) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      
      showDialog(
          context: context,
          builder: ((context) => Center(
                child: CircularProgressIndicator(strokeWidth: 4),
              )));

      try {
        await authService.createUser(
            email: email,
            username: username,
            password: password,);
        log("Sign up success");
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } on auth.FirebaseAuthException catch (e) {
        log(e.message!);
        showSnackBar(e.message);
        Navigator.of(context).pop();
      }
    } else {
      // TODO: check error amount for increase size of form
      var sum = 0;
      size.forEach((e) => sum += e);
      _scollSize = sum * 0.026;
    }
  }
}
