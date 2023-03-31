import 'package:bolt/page/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            myInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.white10
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const HomePageWidget();
          }));
        },
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.search, size: 18),
            ),
            const Expanded(
                child: Text('搜索')),
            SizedBox(
              width: 40,
              child: ElevatedButton(
                onPressed: () {},
                child: const Icon(Icons.settings_overscan, size: 18),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget myInfoCard() {
    return Container(
      color: Color(0xFF222222),
      margin: EdgeInsets.only(top: 10, bottom: 6),
      padding: EdgeInsets.only(top: 12, bottom: 8),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            decoration: const BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.all(Radius.circular(6.0))
            ),
            child: ElevatedButton(
              onPressed: () {  },
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage("https://pic1.zhimg.com/v2-ec7ed574da66e1b495fcad2cc3d71cb9_xl.jpg"),
                  radius: 20,
                ),
                title: Container(
                  margin: const EdgeInsets.only(bottom: 2.0),
                  child: const Text('limaomao'),
                ),
                subtitle: Container(
                  margin: const EdgeInsets.only(top: 2.0),
                  child: Text('edit'),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width-6.0) / 4,
                child: ElevatedButton(
                  onPressed: () {  },
                  child: Container(
                    height: 50,
                    child: Column(
                      children: [
                        Container(
                          child: Text('57', style: TextStyle(fontSize: 16, color: Colors.white30),),
                        ),
                        Container(
                          child: Text('创做', style: TextStyle(fontSize: 12, color: Colors.white30),),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 14,
                decoration: const BoxDecoration(
                  border: BorderDirectional(
                    start: BorderSide(color: Colors.white12 , width: 1)
                  )
                ),
              )
            ],
          )
        ],
      ),

    );
  }
}

