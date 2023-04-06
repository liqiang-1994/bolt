
import 'package:bolt/constant/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogDetailHeadWidget extends StatefulWidget {
  BlogDetailHeadWidget(this.avatarUrl, {Key? key}) : super(key: key);

  String avatarUrl;

  @override
  State<BlogDetailHeadWidget> createState() => _BlogDetailHeadWidgetState();
}

class _BlogDetailHeadWidgetState extends State<BlogDetailHeadWidget> {

  bool _highLight = false;

  void _handleTapDown(TapDownDetails downDetails) {
    setState(() {
      _highLight = true;
    });
  }

  void _handleTapUp(TapUpDetails upDetails) {
    setState(() {
      _highLight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highLight = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Center(
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    '正文',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    onTapDown: _handleTapDown,
                    onTapUp: _handleTapUp,
                    onTapCancel: _handleTapCancel,
                    child: const Icon(Icons.more_horiz, size: 15),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      onTapDown: _handleTapDown,
                      onTapUp: _handleTapUp,
                      onTapCancel: _handleTapCancel,
                      child: _highLight ? Image.asset('${Constants.ASSETS_IMG}icon_back_highlighted.png',
                          height: 23, width: 23) : Image.asset('${Constants.ASSETS_IMG}icon_back_highlighted.png',
                          height: 23, width: 23)
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          color: const Color(0xffE6E4E3),
          height: 0.5,
        )
      ],
    );
  }
}
