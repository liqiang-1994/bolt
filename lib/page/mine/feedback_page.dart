import 'dart:core';
import 'dart:io';

import 'package:bolt/constant/service_path.dart';
import 'package:bolt/util/dio_util.dart';
import 'package:bolt/util/toast_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController editingController = TextEditingController();
  List<XFile?> fileList = [];
  XFile? selectedFile;
  List<MultipartFile> submitFileList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          child: Column(
            children: [
              fHeadWidget(),
              fBodyWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget fHeadWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: IntrinsicHeight(
        child: Row(
          children: [
            InkWell(
              child: Text('取消', style: TextStyle(color: Colors.black, fontSize: 15)),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Expanded(
                child: Center(
                  child: Text('意见反馈', style: TextStyle(color: Colors.black)),
                )
            ),
            InkWell(
              child: Text('发送', style: TextStyle(color: Colors.black)),
              onTap: (){
                submitFileList.clear();
                for (int i=0; i<fileList.length; i++) {
                  submitFileList.add(MultipartFile.fromFileSync(fileList.elementAt(i)?.path ?? ""));
                }
                FormData formData = FormData.fromMap({
                  "message": editingController.text,
                  "files": fileList
                });
                DioManager.instance.post(ServicePath.feedback, formData, (data) {
                  ToastUtils.show('提交成功');
                  setState(() {
                    fileList.clear();
                    submitFileList.clear();
                    editingController.clear();
                  });
                }, (err) {
                  ToastUtils.show(err.toString());
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget fBodyWidget() {
    return Expanded(
      child: ListView(
        children: [
          Container(
            constraints: const BoxConstraints(
              minHeight: 200
            ),
            color: const Color(0xffffffff),
            margin: const EdgeInsets.all(5),
            child: TextField(
              controller: editingController,
              maxLines: 10,
              maxLength: 1000,
              decoration: InputDecoration(
                hintText: "亲爱的诗友，有什么想要告诉我的......",
                hintStyle: TextStyle(color: Color(0xff999999), fontSize: 16),
                contentPadding: const EdgeInsets.only(left: 20, right: 20),
                border: InputBorder.none
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            primary: false,
            crossAxisCount: 3,
            children: List.generate(fileList.length + 1, (index) {
              var content;
              if (index == fileList.length) {
                var add = Center(
                  child: Icon(Icons.add, size: double.infinity),
                );
                content = GestureDetector(
                  child: add,
                  onTap: () {
                    pickImage(context);
                  },
                );
              } else {
                content = Stack(
                  children: [
                    Center(
                      child: Image.file(File(fileList[index]?.path ?? ""),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: Icon(Icons.close, size: 20),
                        onTap: () {
                          fileList.removeAt(index);
                          selectedFile = null;
                          setState(() {});
                        },
                      ),
                    )
                  ],
                );
              }
              return Container(
                margin: const EdgeInsets.all(10),
                width: 10,
                height: 10,
                color: const Color(0xFFffffff),
                child: content,
              );
            }),
          )
        ],
      ),
    );
  }

  Widget fFootWidget() {
    return Container(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Icon(Icons.picture_in_picture,size:  10),
                  onTap: () {},
                )
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomSheetBuilder(BuildContext buildContext) {
    return Container(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
        child: Column(
          children: [
            _renderBottomImageItem("相机拍照", ImageSource.camera),
            _renderBottomImageItem("从图库选择", ImageSource.gallery)
          ],
        ),
      ),
    );
  }

  Widget _renderBottomImageItem(String title, ImageSource imageSource) {
    var item = SizedBox(
      height: 60,
      child: Center(child: Text(title)),
    );
    return InkWell(
      child: item,
      onTap: () {
        Navigator.of(context).pop();
        final ImagePicker imagePicker = ImagePicker();
        final Future<XFile?> image = imagePicker.pickImage(source: imageSource);
        image.then((value) {
          setState(() {
            selectedFile = value;
          });
        });
      }
    );
  }

  void pickImage(ctx) {
    num size = fileList.length;
    if (size >= 9) {
      ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('最多只能显示9张图片'))
      );
      return;
    }
    showBottomSheet(context: ctx, builder: _bottomSheetBuilder);
  }
}
