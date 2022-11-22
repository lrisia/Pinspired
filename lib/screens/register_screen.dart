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
  String? username, email, phone, password, confirmPassword, address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF68CBEB),
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 4, 5, 5),
      //   elevation: 0,
      // ),
      body: Container(
        //Image.asset("assets/img.png", width: 170, height: 300),
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/register_photo.png"),
                  alignment: Alignment(0, -0.9)),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 0, bottom: 20),
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
                ]),
              ),
            ),
          ),
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
              return "Please enter username";
            }
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
              return "Please enter Email";
            }
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
              return "Please enter password";
            }
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
              return "Please enter confirm password";
            } else if (password != null && value != password) {
              return "Those passwords didn't match. Try again.";
            }
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
            password: password,
            phone: phone,
            address: address);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } on auth.FirebaseAuthException catch (e) {
        log(e.message!);
        showSnackBar(e.message);
        Navigator.of(context).pop();
      }
    }
  }
}
