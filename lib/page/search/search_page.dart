import 'dart:math';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> _listHistory = [
    'test',
    'shoe',
    'Fold Widget',
    'long ',
    's',
    'pick pick',
    'show time',
    'next time',
    'fly to the end',
    'jomin',
    'a very long long long long long long long long long long long long long'
  ];
  bool isFold = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(builder: (context) {
          return  IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back, color: Colors.black)
          );

        }),
        title: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Container(
            height: 35,
            width: MediaQuery.of(context).size.width - 50,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 50),
                    child: Icon(Icons.search, color: Colors.teal),
                  ),
                  Text('搜索喜欢的内容', style: TextStyle(color: Colors.grey, fontSize: 15))
                ],
              ),
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: (){},
              icon: const Icon(Icons.search_outlined, size: 35, color: Colors.blue))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 30, left: 16, bottom: 16),
              child: const Text('历史搜索', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isFold = true;
                });
              },
              child: Container(
                width: double.maxFinite,
                height: 50,
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Text(
                  'History (click to reset)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FlowSearchWidget(
            extentHeight: 30,
            spacing: 10,
            runSpacing: 10,
            isFold: isFold,
            foldLine: 2,
            foldWidgetInEnd: true,
            foldWidget: GestureDetector(
              onTap: () {
                setState(() {
                  isFold = !isFold;
                  print(isFold);
                });
              },
              child: const Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Colors.grey,
                size: 25,
              ),
            ),
            children: _listHistory.map((e) => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200]
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                e,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            )).toList(),
          ),
        )
          ],
        ),
      ),
    );
  }
}

/// https://github.com/EchoPuda/fold_warp/blob/master/lib/fold_wrap_delegate.dart
/// https://juejin.cn/post/7109413914332364831
class FlowSearchWidget extends StatefulWidget {

  final List<Widget> children;

  final Widget? foldWidget;

  final int foldLine;

  final int maxLine;

  final bool isFold;

  /// The spacing between Items in the horizontal direction
  final double spacing;

  /// The spacing between Items in the vertical direction
  final double runSpacing;

  final int lineMaxLength;

  final double extentHeight;

  final Function? onCallLineNum;

  final bool foldWidgetInEnd;

  @override
  State<FlowSearchWidget> createState() => _FlowSearchWidgetState();

  const FlowSearchWidget({
    Key? key,
    required this.children,
    this.foldWidget,
    this.foldLine = 0,
    this.maxLine = 0,
    this.isFold = false,
    this.spacing = 0,
    this.runSpacing = 0,
    this.lineMaxLength = 0,
    required this.extentHeight,
    this.onCallLineNum,
    this.foldWidgetInEnd = false}) : super(key: key);
}

class _FlowSearchWidgetState extends State<FlowSearchWidget> {
  int line = 0;

  List<Widget> _getChildren() {
    List<Widget> children = [];
    children.addAll(widget.children);
    if (widget.foldWidget != null) {
      children.add(widget.foldWidget!);
    } else {
      children.add(Container());
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FoldWrapDelegate(
        foldLine: widget.foldLine,
        extentHeight: widget.extentHeight,
        maxLine: widget.maxLine,
        isFold: widget.isFold,
        spacing: widget.spacing,
        runSpacing: widget.runSpacing,
        line: line,
        lineMaxLength: widget.lineMaxLength,
        foldWidgetInEnd: widget.foldWidgetInEnd,
        onLine: (int i) {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            widget.onCallLineNum?.call(i);
            setState(() {
              line = i;
            });
          });
        }
      ),
      children: _getChildren()
    );
  }
}

class FoldWrapDelegate extends FlowDelegate {

  final int foldLine;
  final int maxLine;
  final bool isFold;
  final double spacing;
  final double runSpacing;
  final double extentHeight;
  final int line;
  final ValueChanged<int>? onLine;
  final int lineMaxLength;
  final bool foldWidgetInEnd;


  FoldWrapDelegate({required this.foldLine, this.maxLine = 0, this.isFold = false, this.spacing = 0,
      this.runSpacing = 0, required this.extentHeight, this.line = 0, this.onLine,
      this.lineMaxLength = 0, this.foldWidgetInEnd = false});

  @override
  void paintChildren(FlowPaintingContext context) {
    var screenW = context.size.width;

    double offsetX = 0;
    double offsetY = 0;

    int foldWidgetIndex = context.childCount - 1;
    int nowLine = 1;
    int lineLength = 0;
    bool hasPainFold = false;

    for (int i = 0; i < foldWidgetIndex; i++) {
      if (offsetX + (context.getChildSize(i)?.width ?? 0) <= screenW && getLineLimit(lineLength)) {
        if (needChangeToFoldWidget(i, offsetX, screenW, nowLine, context)) {
          if (canAddFoldWidget(i, offsetX, screenW, context, foldWidgetIndex)) {
            context.paintChild(i, transform: Matrix4.translationValues(offsetX, offsetY , 0));
            offsetX = offsetX + (context.getChildSize(i)?.width ?? 0) + spacing;
          }
          if (!hasPainFold) {
            context.paintChild(foldWidgetIndex,
              transform: Matrix4.translationValues(getFoldWidgetOffsetX(
              context.getChildSize(foldWidgetIndex)?.width ?? 0, offsetX, screenW), offsetY, 0));
            offsetX = offsetX + (context.getChildSize(foldWidgetIndex)?.width ?? 0) + spacing;
            hasPainFold = true;
          }
          break;
        } else {
          context.paintChild(i, transform: Matrix4.translationValues(offsetX, offsetY, 0));
          offsetX = offsetX + (context.getChildSize(i)?.width ?? 0) + spacing;
          lineLength++;
        }
      } else {
        nowLine++;
        lineLength = 0;
        if ((isFold && (nowLine > foldLine))) {
          if (!hasPainFold) {
            context.paintChild(foldWidgetIndex,
                transform: Matrix4.translationValues(
                    getFoldWidgetOffsetX(context.getChildSize(foldWidgetIndex)?.width ?? 0, offsetX, screenW), offsetY, 0));
            offsetX = offsetX + (context.getChildSize(foldWidgetIndex)?.width ?? 0) + spacing;
            hasPainFold = true;
          }
          break;
        } else {
          if (maxLine != 0 && nowLine > maxLine) {
            break;
          } else {
            offsetX = 0;
            offsetY = offsetY + extentHeight + runSpacing;
            if (needChangeToFoldWidget(i, offsetX, screenW, nowLine, context)) {
              if (canAddFoldWidget(i, offsetX, screenW, context, foldWidgetIndex)) {
                context.paintChild(i, transform: Matrix4.translationValues(offsetX, offsetY, 0));
                offsetX = offsetX + (context.getChildSize(i)?.width ?? 0) + spacing;
              }
              if (!hasPainFold) {
                context.paintChild(foldWidgetIndex,
                  transform: Matrix4.translationValues(
                      getFoldWidgetOffsetX(context.getChildSize(foldWidgetIndex)?.width ?? 0, offsetX, screenW), offsetY, 0));
                offsetX = offsetX + (context.getChildSize(foldWidgetIndex)?.width ?? 0) + spacing;
                hasPainFold = true;
              }
            } else {
              context.paintChild(i, transform: Matrix4.translationValues(offsetX, offsetY, 0));
            }
            offsetX = offsetX + (context.getChildSize(i)?.width ?? 0) + spacing;
          }
        }
      }
    }
    onLine?.call(nowLine);
  }

  @override
  Size getSize(BoxConstraints constraints) {
    if (isFold) {
      int kLine = line;
      if (line > foldLine) {
        kLine = foldLine;
      }
      return Size(constraints.maxWidth, extentHeight * kLine + runSpacing * (kLine -1));
    }
    int kLine = line;
    if (maxLine != 0 && line > maxLine) {
      kLine = maxLine;
    }
    return Size(constraints.maxWidth, extentHeight * kLine + runSpacing * (kLine - 1));
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints(
      maxWidth: constraints.maxWidth,
      minWidth: 0,
      maxHeight: extentHeight,
      minHeight: 0);
  }

  @override
  bool shouldRepaint(covariant FoldWrapDelegate oldDelegate) {
    if (isFold != oldDelegate.isFold) {
      return true;
    }
    if (line != oldDelegate.line) {
      return true;
    }
    return false;
  }

  @override
  bool shouldRelayout(covariant FoldWrapDelegate oldDelegate) {
    return line != oldDelegate.line;
  }

  bool getLineLimit(int lineLength) {
    if (lineMaxLength == 0) {
      return true;
    }
    if (lineLength >= lineMaxLength) {
      return false;
    } else {
      return true;
    }
  }

  bool needChangeToFoldWidget(int i, double offsetX, double screenW, int nowLine, FlowPaintingContext context) {
    if (!isFold) {
      return false;
    }
    if ((i + 1 < context.childCount - 1) &&
        ((offsetX + (context.getChildSize(i)?.width ?? 0)
            + spacing + (context.getChildSize(i + 1)?.width ?? 0)) > screenW)) {
              if ((isFold && ((nowLine + 1) > foldLine))) {
                return true;
              }
    }
    return false;
  }

  bool canAddFoldWidget(int i, double offsetX, double screenW, FlowPaintingContext context, int lastIndex) {
    if ((offsetX + (context.getChildSize(i)?.width ?? 0) + spacing +
        (context.getChildSize(lastIndex)?.width ?? 0)) <= screenW) {
          return true;
        }
    return false;
  }

  double toMaxHeight(double oldMaxHeight, newMaxHeight) {
    return max(oldMaxHeight, newMaxHeight);
  }

  double getFoldWidgetOffsetX(double foldWidgetWidth, double offsetX, double screenWidth) {
    if (!foldWidgetInEnd) {
      return offsetX;
    }
    return screenWidth - foldWidgetWidth;
  }


}

