import 'package:flutter/material.dart';

class PersonalCollectWidget extends StatefulWidget {
  const PersonalCollectWidget({Key? key}) : super(key: key);

  @override
  State<PersonalCollectWidget> createState() => _PersonalCollectWidgetState();
}

final List<String> tabName = ['动态', '唐诗', '宋词', '文集', '元曲', '成语', '歇后语'];
late TabController tabController;

class _PersonalCollectWidgetState extends State<PersonalCollectWidget> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabName.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: DefaultTabController(
        length: tabName.length,
        child: Column(
          children: const [
            Align(
              alignment: Alignment.centerLeft,
              child: _TabBarWidget(),
            )
          ],
        ),
        
      ),
    );
  }
}

class _TabBarWidget extends StatefulWidget {
  const _TabBarWidget({Key? key}) : super(key: key);

  @override
  State<_TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<_TabBarWidget> {
  late Color selectedColor, unselectedColor;
  late TextStyle selectedStyle, unselectedStyle;
  late List<Widget> tabWidgetList;

  @override
  void initState() {
    super.initState();
    selectedColor = Colors.black;
    unselectedColor = const Color.fromARGB(255, 117, 117, 117);
    selectedStyle = TextStyle(fontSize: 18, color: selectedColor);
    unselectedStyle = TextStyle(fontSize: 18, color: unselectedColor);
    tabWidgetList = tabName.map((e) => Text(e, style: const TextStyle(fontSize: 15))).toList();
  }

  @override
  void dispose() {
    super.dispose();
    if (tabController != null) {
      tabController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabWidgetList,
      indicatorColor: selectedColor,
      labelColor: selectedColor,
      labelStyle: selectedStyle,
      unselectedLabelColor: unselectedColor,
      unselectedLabelStyle: unselectedStyle,
      indicatorSize: TabBarIndicatorSize.tab,
      controller: tabController,
    );
  }
}


