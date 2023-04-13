import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:bolt/constant/constants.dart';
import 'package:bolt/model/at_user_model.dart';
import 'package:bolt/util/toast_util.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sp_util/sp_util.dart';

class PublishPage extends StatefulWidget {
  const PublishPage({Key? key}) : super(key: key);

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {

  TextEditingController editingController = TextEditingController();
  String submitText = '';

  FocusNode focusNode = FocusNode();
  final GlobalKey globalKey = GlobalKey();
  final double? _softHeight = SpUtil.getDouble(Constants.spKeyBoardHeight, defValue: 200);
  late StreamSubscription<bool> keyboardSubscription;

  List<XFile?> mFileList = [];
  XFile? selectedImageFile;
  List<MultipartFile>  submitFileList = [];

  bool emojiShow = false;
  bool bottomShow = false;

  @override
  void initState() {
    super.initState();
    var keyboardController = KeyboardVisibilityController();
    keyboardSubscription = keyboardController.onChange.listen((bool visible) {
      if (visible) {
        emojiShow = false;
        if (!bottomShow) {
          setState(() {
            bottomShow = true;
          });
        }
      } else {
        if (!emojiShow) {
          setState(() {
            bottomShow = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("键盘高度是:$_softHeight");
    print('fileList的内容: $mFileList');
    if (selectedImageFile != null) {
      mFileList.add(selectedImageFile);
    }
    selectedImageFile = null;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: WillPopScope(
                onWillPop: () {
                  return Future(() => true);
                },
                child: Scaffold(
                  backgroundColor: Colors.green,
                  body: Column(
                    //mainAxisSize: MainAxisSize.max,
                    children: [
                      _publishTitle(),
                      _publishContent(),
                      _publishBottom()
                    ],
                  ),
                )
            )
        )
    );
  }

  Widget _publishTitle() {
    return Container(
      color: const Color(0xFFFAFAFA),
      height: 55.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Icon(Icons.close_outlined, size: 30, color: Colors.grey)
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              child:  const Text('创作',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              child:  Container(
                margin: const EdgeInsets.only(right: 15),
                padding: const EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue,
                ),
                child: Text(
                  '发布',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              onTap: () {
                if (editingController.text.isEmpty) {
                  ToastUtils.show('发布内容不能为空');
                  return;
                }
                submitFileList.clear();
                for (int i = 0; i < mFileList.length; i++) {
                  submitFileList.add(MultipartFile.fromFileSync(
                    mFileList.elementAt(i)?.path ?? ''));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _publishContent() {
    int gridCount;
    if (mFileList.isEmpty) {
      gridCount = 0;
    } else if (mFileList.length > 0 && mFileList.length < 9) {
      gridCount = mFileList.length + 1;
    } else {
      gridCount = mFileList.length;
    }
    return Expanded(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
            constraints: const BoxConstraints(minHeight: 50),
            child: ExtendedTextField(
              controller: editingController,
              maxLines: 5,
              focusNode: focusNode,
              style: const TextStyle(fontSize: 15, color: Colors.black),
              decoration: const InputDecoration.collapsed(
                hintText: '分享你的心情',
                hintStyle: TextStyle(
                  color: Color(0xff919191), fontSize: 15)
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            primary: false,
            crossAxisCount: 3,
            children: List.generate(gridCount, (index) {
              Widget content;
              if (index == mFileList.length) {
                var addCell = const Center(
                  child: Icon(Icons.add, size: 20),
                );
                content = GestureDetector(
                  onTap: () {
                    num count = mFileList.length;
                    if (count >= 9) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('最多只能显示9张图片'))
                      );
                      return;
                    }
                    final ImagePicker picker = ImagePicker();
                    final Future<XFile?> image = picker.pickImage(source: ImageSource.gallery);
                    image.then((value) {
                      setState(() {
                        selectedImageFile = value;
                      });
                    });
                  },
                  child: addCell,
                );
              } else {
                content = Stack(
                  children: [
                    Center(
                      child: Image.file(File(mFileList[index]?.path ?? ''),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: const Icon(Icons.close_sharp, size: 20),
                        onTap: () {
                          mFileList.removeAt(index);
                          selectedImageFile = null;
                          setState(() {});
                        },
                      ),
                    )
                  ],
                );
              }
              return Container(
                child: content,
                color:  const Color(0xFFffffff),
                height: 80,
                width: 80,
                margin: const EdgeInsets.all(10),
              );
            })
          )
        ],
      ),
    );
  }

  Widget _publishBottom() {
    return Column(
      children: [
        Container(
          color: Color(0xffF9F9F9),
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Icon(Icons.camera_alt, size: 20),
                  onTap: () {
                    final ImagePicker picker = ImagePicker();
                    final Future<XFile?> image = picker.pickImage(source: ImageSource.gallery);
                    image.then((value) {
                      setState(() {
                        selectedImageFile = value;
                      });
                    });
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Icon(Icons.alternate_email_outlined, size: 20),
                  onTap: () {
                    context.push('/publishAtUser');
                    // context.push('/publishAtUser').then((value) {
                    //   AtUserModel atUser = value as AtUserModel;
                    //   if (atUser != null) {
                    //     submitText = '${'${submitText + '[@' + atUser.nickName}:' + atUser.id}]';
                    //     editingController.text = '${'${editingController.text + '[@' + atUser.nickName}:' + atUser.id}]';
                    //   }
                    // });
                  },
                ),
              ),
              Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Icon(Icons.add_card_sharp, size: 20),
                    onTap: () {},
                  )
              ),
              Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Icon(Icons.face, size: 20),
                    onTap: () {
                      _getWH();
                      setState(() {
                        if (emojiShow) {
                          bottomShow = true;
                          emojiShow = false;
                          showSoftKey();
                        } else {
                          bottomShow = true;
                          emojiShow = true;
                          hideSoftKey();
                        }
                      });
                      _getWH();
                    },
                  )
              ),
            ],
          ),
        ),
        // Visibility(
        //   visible: bottomShow,
        //   child: Container(
        //     key: globalKey,
        //     child: Visibility(
        //       visible: emojiShow,
        //       child: ,
        //     ),
        //   ),
        // )
      ],
    );
  }

  void _getWH() {
    if (globalKey == null) return;
    if (globalKey.currentContext == null) return;
    if (globalKey.currentContext!.size == null) return;
    final containerWidth = globalKey.currentContext!.size!.width;
    final containerHeight = globalKey.currentContext!.size!.height;
    print('Container widht is $containerWidth, height is $containerHeight');
  }

  void showSoftKey() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  void hideSoftKey() {
    focusNode.unfocus();
  }
}
