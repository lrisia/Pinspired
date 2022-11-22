import 'package:cnc_shop/themes/color.dart';
import 'package:flutter/material.dart';

class MainBtnWidget extends StatelessWidget {
  Color colorBtn;
  Color textColor;
  String textBtn;
  bool isTransparent;
  bool haveIcon;
  double height;
  FontWeight fontWeight;
  MainBtnWidget({Key? key, required this.colorBtn, required this.textBtn, required this.isTransparent, required this.haveIcon,  this.height=43, this.textColor=kColorsWhite, this.fontWeight=FontWeight.w600}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: isTransparent ? 
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: height,
              width: MediaQuery.of(context).size.width - 80,
              decoration: BoxDecoration(
                color: Color(0x00000000),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: colorBtn)
              ),
              child: Center(
                child: Text(
                  textBtn, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: colorBtn),
                ),
              ),
            ),
            haveIcon ? Positioned(
              left: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 13),
                child: Image.asset('assets/icons/google.png', width: 24, height: 24,),
              ),
            ) : Container()
          ],
        )
      : Container(
          height: height,
          width: MediaQuery.of(context).size.width - 80,
          decoration: BoxDecoration(
            color: colorBtn,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: Center(
            child: Text(
              textBtn, style: TextStyle(fontSize: 16.0, fontWeight: fontWeight, color: textColor),
            ),
          ),
        )
    );
  }
}