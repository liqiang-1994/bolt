import 'package:flutter/material.dart';

import '../../model/circle_model.dart';

class MyCircleWidget extends StatefulWidget {
  const MyCircleWidget({Key? key}) : super(key: key);

  @override
  State<MyCircleWidget> createState() => _MyCircleWidgetState();
}

class _MyCircleWidgetState extends State<MyCircleWidget> {
  List<CircleModel> circleList =  CircleModel.list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: ListView.builder(
          padding: const EdgeInsets.only(left: 10, right: 10),
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            final int count = circleList.length > 4 ? 4 : circleList.length;
            return Container(
              padding: const EdgeInsets.only(left: 5, right: 10, bottom: 10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                              'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg',
                              width: 65,
                              height: 65
                          )
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              circleList[index].num.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 15,
                                  backgroundColor: Colors.white
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      circleList[index].name,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  )
                ],
              ),
            );
          }
      ),
    );
  }
}
