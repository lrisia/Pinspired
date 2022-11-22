import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../themes/color.dart';
import '../widgets/main_btn_widget.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  // File? imageFile;
  // final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF68CBEB),
      body: Container(
        //Image.asset("assets/img.png", width: 170, height: 300),
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            decoration: BoxDecoration(),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView(children: [
                  // imageFile != null
                  //     ? ClipRRect(
                  //         borderRadius: BorderRadius.circular(15),
                  //         child: Image.file(
                  //           imageFile!,
                  //           width: 153,
                  //           height: 153,
                  //           fit: BoxFit.cover,
                  //         ),
                  //       )
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Container(
                      width: 150,
                      height: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color(0xFFCDCDCD)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: InkWell(
                      onTap: () {
                        // registerHandle(context: context);
                      },
                      child: MainBtnWidget(
                        colorBtn: kColorsSky,
                        textBtn: 'Upload',
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
}
