
class TabIconEntity {
  String name;
  String activeIcon;
  String normalIcon;
  bool isSelected;
  int index;

  TabIconEntity({
    this.name = '',
    this.activeIcon = '',
    this.normalIcon = '',
    this.isSelected = false,
    this.index = 0
  });

  static List<TabIconEntity> tabIconsList = <TabIconEntity>[
    TabIconEntity(
      name: '首页',
      activeIcon: 'assets/images/tab_1_active.png',
      normalIcon: 'assets/images/tab_1_normal.png',
      index: 0,
      isSelected: true,
    ),
    TabIconEntity(
      name: '诗集',
      activeIcon: 'assets/images/tab_2_active.png',
      normalIcon: 'assets/images/tab_2_normal.png',
      index: 1,
      isSelected: false,
    ),
    TabIconEntity(
      name: '圈子',
      activeIcon: 'assets/images/tab_3_active.png',
      normalIcon: 'assets/images/tab_3_normal.png',
      index: 2,
      isSelected: false,
    ),
    TabIconEntity(
      name: '我',
      activeIcon: 'assets/images/tab_4_active.png',
      normalIcon: 'assets/images/tab_4_normal.png',
      index: 3,
      isSelected: false,
    ),
  ];
}