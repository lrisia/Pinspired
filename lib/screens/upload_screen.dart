import 'dart:developer';
import 'dart:io';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:cnc_shop/screens/home_screen.dart';
import 'package:cnc_shop/screens/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../model/post_model.dart';
import '../model/user_model.dart';
import '../service/auth_service.dart';
import '../service/database_service.dart';
import '../service/storage_service.dart';
import '../themes/color.dart';
import '../utils/showSnackBar.dart';
import '../widgets/bottom_bar_creative.dart';
import '../widgets/input_decoration.dart';
import '../widgets/main_btn_widget.dart';

List<String> dropdownList = <String>[
  "Illustator",
  "Drawing",
  "Fashion",
  "Photo"
];

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  User? user;

  final formKey = GlobalKey<FormState>();
  String? description;
  File? imageFile;
  final picker = ImagePicker();
  String dropdownvalue = dropdownList.first;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.currentUser().then((currentUser) {
      setState(() {
        user = currentUser;
      });
    });

    return Scaffold(
        backgroundColor: Color(0xFF68CBEB),
        body: Container(
          child: InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, left: 20),
                  alignment: Alignment.bottomLeft,
                  child: Text('UPLOAD',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Form(
                    key: formKey,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30)),
                        ),
                        child: ListView(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: InkWell(
                              onTap: () {
                                showButtomSheet(context);
                              },
                              child: Container(
                                child: imageFile != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.file(
                                          imageFile!,
                                          width: 185,
                                          height: 225,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        width: 185,
                                        height: 225,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.5), //color of shadow
                                              spreadRadius: 3, //spread radius
                                              blurRadius: 7, // blur radius
                                              offset: Offset(0,
                                                  2), // changes position of shadow
                                              //first paramerter of offset is left-right
                                              //second parameter is top to down
                                            ),
                                          ],
                                          gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Color.fromARGB(
                                                  255, 206, 240, 255),
                                              Colors.white,
                                            ],
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/add-image.png')),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                width: 322,
                                height: 250,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), //color of shadow
                                      spreadRadius: 2, //spread radius
                                      blurRadius: 7, // blur radius
                                      offset: Offset(
                                          0, 2), // changes position of shadow
                                      //first paramerter of offset is left-right
                                      //second parameter is top to down
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  color: Color(0xFF70CEEC),
                                ),
                                child: Column(
                                  children: [
                                    CreateDescription(),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                40, 0, 60, 0),
                                            child: Text(
                                              "Tag:",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          DropdownButton<String>(
                                            dropdownColor: Colors.black,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            value: dropdownvalue,
                                            onChanged: (String? value) {
                                              setState(() {
                                                dropdownvalue = value!;
                                              });
                                              print(dropdownvalue);
                                            },
                                            items: dropdownList
                                                .map<DropdownMenuItem<String>>(
                                                    (e) {
                                              return DropdownMenuItem(
                                                  value: e, child: Text(e));
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 20),
                            child: InkWell(
                              onTap: () {
                                confirmHandle(context: context);
                              },
                              child: MainBtnWidget(
                                height: 60,
                                colorBtn: kColorsSky,
                                textBtn: 'Upload your inspiration',
                                isTransparent: false,
                                haveIcon: false,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget CreateDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: TextFormField(
        maxLines: 4,
        style: TextStyle(fontSize: 20),
        keyboardType: TextInputType.text,
        autofocus: false,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter description";
          } else {
            return null;
          }
        },
        onChanged: (value) {
          description = value;
        },
        decoration: InputDecorationWidget(
          context,
          "tell something about your inspiration. . .",
        ),
      ),
    );
  }

  Future<void> showButtomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: [
                ListTile(
                  onTap: () {
                    openGallery(context);
                  },
                  leading: SvgPicture.asset(
                    'assets/icons/gallery.svg',
                    color: kColorsPurple,
                  ),
                  title: Text('Gallery',
                      style: Theme.of(context).textTheme.subtitle1),
                ),
                ListTile(
                  onTap: () {
                    openCamera(context);
                  },
                  leading: SvgPicture.asset(
                    'assets/icons/camera.svg',
                    color: kColorsPurple,
                  ),
                  title: Text('Camera',
                      style: Theme.of(context).textTheme.subtitle1),
                )
              ],
            ),
          );
        });
  }

  openGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        print(imageFile.toString());
      } else {
        print('No Image selected');
      }
    });
    Navigator.of(context).pop();
  }

  openCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        print(imageFile.toString());
      } else {
        print('No Image selected');
      }
    });
    Navigator.of(context).pop();
  }

  Future<void> confirmHandle({required context}) async {
    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);
    final storageService = Provider.of<StorageService>(context, listen: false);
    String? imageUrl;

    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    if (imageFile != null) {
      imageUrl = await storageService.uploadPostImage(imageFile: imageFile!);
    }

    print(imageUrl);
    final newPost = Post(
        postId: Uuid().v1(),
        tag: Post.getPostTag(dropdownvalue),
        userId: user!.uid,
        description: description,
        photoURL: imageUrl!);

    databaseService.addPost(post: newPost);

    showDialog<String>(
      
        context: context,
        builder: (BuildContext context) => AlertDialog(
          
          content: Stack(
   

            alignment: Alignment.center,
            children: <Widget>[
      Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.fromLTRB(20,150, 20, 5),
        child: Text("Post success!",
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center
        ),
      ),
      Positioned(
        top: 0,
        child: Image.asset("assets/checkIcon.jpg", width: 150, height: 150)
      )
    ],),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen())),
              child: const Text('OK'),
            ),
          ],
        ),
      );
  }
}
