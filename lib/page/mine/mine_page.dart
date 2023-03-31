import 'package:bolt/constant/constants.dart';
import 'package:flutter/material.dart';

class MinePageWidget extends StatefulWidget {
  const MinePageWidget({Key? key}) : super(key: key);

  @override
  State<MinePageWidget> createState() => _MinePageWidgetState();
}

class _MinePageWidgetState extends State<MinePageWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xffEEEEEE),
        child: Column(
          children: [
            _buildTitle(),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 1),
                  children: [
                    _buildInfo(),
                    _buildMyInfo(),
                    _buildBottom()
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
  
  Widget _buildTitle() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 15),
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  '${Constants.ASSETS_IMG}mine_add_friends.png',
                  width: 25,
                  height: 25,
                ),
              ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  '我的',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: InkWell(
                        child: Image.asset(
                          '${Constants.ASSETS_IMG}mine_qr_code.png',
                          width: 25,
                          height: 25,
                        ),
                        onTap: () {},
                      ),
                    ),
                    InkWell(
                      child: Image.asset(
                        '${Constants.ASSETS_IMG}mine_message.png',
                        width: 30,
                        height: 33,
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10, bottom: 5),
      child: Column(
        children:  [
          Material(
            color: Colors.white,
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.only(top: 2, bottom: 2),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10),
                      child: mineHeadWidget(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                child: Text('小提琴与厨师',
                                    style: TextStyle(fontSize: 15, color: Colors.black)),
                              ),
                            ),
                            Center(
                              child: Container(),
                            )
                          ],
                        )
                      ],
                    ),
                    Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Image.asset('${Constants.ASSETS_IMG}icon_right_arrow.png',
                              width: 20,
                              height: 30,
                            ),
                          ),
                        )
                    )
                  ],
                ),
              ),
              onTap: () {},
            ),
          ),
          Container(
            height: 0.5,
            color: const Color(0xffE2E2E2),
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text(
                              '1',
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: const Text(
                              '创作',
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  )
              ),
              Container(
                margin: const EdgeInsets.only(right: 0),
                child: Image.asset('${Constants.ASSETS_IMG}icon_line.png',
                  width: 20,
                  height: 30,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text(
                              '11',
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: const Text(
                              '关注',
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  )
              ),
              Container(
                margin: const EdgeInsets.only(right: 0),
                child: Image.asset('${Constants.ASSETS_IMG}icon_line.png',
                  width: 20,
                  height: 30,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: const Text(
                              '100',
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: const Text(
                              '收藏',
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget mineHeadWidget() {
    return const CircleAvatar(
      radius: 25,
      backgroundImage: AssetImage('${Constants.ASSETS_IMG}my.png'),
    );
  }

  Widget _buildMyInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 5),
      child: Column(
        children: [
          Material(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 20, 20),
                child: Row(
                  children: [
                    Image.asset(
                      "${Constants.ASSETS_IMG}icon_setting.png",
                      width: 25,
                      height: 25,
                    ),
                    Expanded(child: Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text('设置',
                        style: TextStyle(color: Colors.black, fontSize: 18),),
                    ))
                  ],
                ),
              ),
              onTap: () {},
            )
          ),
          Material(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 20, 20),
                child: Row(
                  children: [
                    Image.asset(
                      "${Constants.ASSETS_IMG}icon_collect.png",
                      width: 25,
                      height: 25,
                    ),
                    Expanded(child: Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text('我的收藏',
                        style: TextStyle(color: Colors.black, fontSize: 18),),
                    ))
                  ],
                ),
              ),
              onTap: () {},
            )
          ),
          Material(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 20, 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "${Constants.ASSETS_IMG}icon_up.png",
                        width: 25,
                        height: 25,
                      ),
                      Expanded(child: Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: const Text('我的赞',
                          style: TextStyle(color: Colors.black, fontSize: 18),),
                      ))
                    ],
                  ),
                ),
                onTap: () {},
              )
          ),
          Material(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 20, 20),
                  child: Row(
                    children: [
                      Image.asset(
                        "${Constants.ASSETS_IMG}icon_circle.png",
                        width: 25,
                        height: 25,
                      ),
                      Expanded(child: Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: const Text('关注的圈子',
                          style: TextStyle(color: Colors.black, fontSize: 18),),
                      ))
                    ],
                  ),
                ),
                onTap: () {},
              )
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Material(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 20, 20),
                child: Row(
                  children: [
                    Image.asset(
                      "${Constants.ASSETS_IMG}icon_help.png",
                      width: 25,
                      height: 25,
                    ),
                    Expanded(child: Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text('反馈建议',
                        style: TextStyle(color: Colors.black, fontSize: 18),),
                    ))
                  ],
                ),
              ),
              onTap: () {},
            ),
          ),
          Material(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 20, 20),
                child: Row(
                  children: [
                    const Icon(Icons.drafts_outlined, size: 25, color: Colors.grey),
                    Expanded(child: Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text('草稿箱',
                        style: TextStyle(color: Colors.black, fontSize: 18),),
                    ))
                  ],
                ),
              ),
              onTap: () {},
            ),
          ),
          Material(
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 20, 20),
                child: Row(
                  children: [
                    const Icon(Icons.share, size: 25, color: Colors.grey),
                    Expanded(child: Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text('分享',
                        style: TextStyle(color: Colors.black, fontSize: 18),),
                    ))
                  ],
                ),
              ),
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
