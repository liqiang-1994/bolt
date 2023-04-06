import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:go_router/go_router.dart';

import '../../model/subject_entity.dart';

class BlogContentWidget extends StatelessWidget {
  Subject subject;

  BlogContentWidget({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) => _buildContentWidget(context, subject);
}

Widget _buildContentWidget(BuildContext context, Subject subject) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),

    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAuthorImg(context, subject),
          _buildContent(context, subject, true),
          _buildButton(context, subject)
        ],
      ),
    )
  );
}

Widget _buildAuthorImg(BuildContext context, Subject subject) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
    child: Row(
      children: [
        InkWell(
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                image: DecorationImage(
                  image: NetworkImage(subject.avatarUrl),
                  fit: BoxFit.cover
                )
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                    child: Text(subject.nickName,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 2, 0, 0),
              child: Text(subject.dateTimeStr, style: const TextStyle(color: Colors.grey, fontSize: 10)),
            )
          ],
        ),
        Expanded(
            child: Align(
              alignment: FractionalOffset.centerRight,
              child: GestureDetector(
                child: Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.orange),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: const Text(
                    '关注',
                    style: TextStyle(fontSize: 12, color: Colors.orange),
                  ),
                ),
              ),
            )
        )
      ],
    ),
  );
}

Widget _buildContent(BuildContext context, Subject subject, bool isDetail) {
  print(subject.content + isDetail.toString());
  String content = subject.content;
  if (!isDetail) {
    if (content.length > 140) {
      subject.content = '${content.substring(0, 140)} ... 全文';
    }
  }
  return InkWell(
    onTap: (){
      context.push('/blog_detail', extra: subject);
    },
    child: Container(
      alignment: FractionalOffset.centerLeft,
      margin: const EdgeInsets.fromLTRB(15, 5, 15, 20),

      child: ParsedText(
        text: content,
        style: const TextStyle(
            height: 1.5,
            fontSize: 15,
            color: Colors.black
        ),
        parse: [
          MatchText(
              pattern: r'\[(@[^:]+):([^\]]+)\]',
              style: const TextStyle(
                  color: Color(0xff5B778D),
                  fontSize: 15
              ),
              renderText: ({String str = '', pattern = ''}) {
                Map<String, String> map = {};
                RegExp regExp = RegExp(pattern);
                RegExpMatch? match = regExp.firstMatch(str);
                map['display'] = match?.group(1) ?? '';
                map['value'] = match?.group(2) ?? '';
                return map;
              },
              onTap: (contentId) {
                print('1');
              }
          ),
          MatchText(
              pattern: '#.*?#',
              style: const TextStyle(
                color: Color(0xff5B778D),
                fontSize: 15,
              ),
              renderText: ({String str = '', pattern = ''}) {
                Map<String, String> map = {};
                String idStr = str.substring(str.indexOf(':')+1, str.lastIndexOf('#'));
                String showStr = str.substring(str.indexOf('#'), str.indexOf('#')+1).replaceAll(':'+idStr, "");
                map['display'] = showStr;
                map['value'] = idStr;
                return map;
              },
              onTap: (String contentId) {
                print('2');
              }
          ),
          MatchText(
              pattern: '全文',
              style: const TextStyle(
                color: Color(0xff5B778D),
                fontSize: 15,
              ),
              renderText: ({String? str, String? pattern}) {
                Map<String, String> map = {};
                map['display'] = '全文';
                map['value'] = '全文';
                return map;
              },
              onTap: (content) async {
                print('3');
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('click'),
                        content: const Text('点击全文'),
                        actions: [
                          ElevatedButton(onPressed: (){},
                              child: const Text('Close')
                          )
                        ],
                      );
                    }
                );
              }
          )
        ],
      ),
    )
  );
}

Widget _buildButton(BuildContext context, Subject subject) {
  return Container(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.thumb_up, size: 20, color: Colors.grey),
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 4),
                  child: Text(subject.up.toString(), style: const TextStyle(fontSize: 15, color: Colors.black)),
                )
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.share, size: 20, color: Colors.grey),
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 4),
                  child: Text(subject.up.toString(), style: const TextStyle(fontSize: 15, color: Colors.black)),
                )
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.comment, size: 20, color: Colors.grey),
                Container(
                  margin: const EdgeInsets.only(left: 8, right: 4),
                  child: Text(subject.up.toString(), style: const TextStyle(fontSize: 15, color: Colors.black)),
                )
              ],
            ),
          ),
        ),
      ],
    )
  );
}
