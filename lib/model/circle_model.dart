
class CircleModel {
  String name;
  String description;
  int num;
  int topic;
  String avatarUrl;

  CircleModel(this.name, this.description, this.num, this.topic, this.avatarUrl);

  static List<CircleModel> list = [CircleModel('小品', '说学逗唱', 999, 200, ''),
    CircleModel('小品', '说学逗唱', 998, 200, ''),
    CircleModel('小品', '说学逗唱', 997, 200, ''),
    CircleModel('小品', '说学逗唱', 996, 200, ''),
    CircleModel('小品', '说学逗唱', 995, 200, ''),
    CircleModel('小品', '说学逗唱', 994, 200, ''),
    CircleModel('小品', '说学逗唱', 992, 200, '')
  ];
}