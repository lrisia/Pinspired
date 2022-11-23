import 'package:cnc_shop/screens/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

class Creative extends StatefulWidget {
  final List<TabItem> items = [
    TabItem(
      icon: Icons.home,
    ),
    TabItem(
      icon: Icons.attach_money,
    ),
    TabItem(
      icon: Icons.add,
    ),
    TabItem(
      icon: Icons.message,
    ),
    TabItem(
      icon: Icons.account_box,
    ),
  ];
  final HighlightStyle? highlightStyle;
  final bool? isFloating;

  Creative({
    Key? key,
    this.highlightStyle,
    this.isFloating,
  }) : super(key: key);

  @override
  _CreativeState createState() => _CreativeState();
}

class _CreativeState extends State<Creative> {
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return BottomBarCreative(
      items: widget.items,
      backgroundColor: Colors.lightBlue.withOpacity(0.21),
      color: Colors.black,
      colorSelected: const Color(0XFF0686F8),
      indexSelected: visit,
      highlightStyle: widget.highlightStyle,
      isFloating: widget.isFloating ?? false,
      onTap: (int index) => setState(() {
        print(index);

        visit = index;
        if (index == 2) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => UploadScreen()),
              (r) => false);
        }
      }),
    );
  }
}
