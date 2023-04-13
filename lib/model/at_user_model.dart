
import 'package:azlistview/azlistview.dart';

class AtUserModel extends ISuspensionBean{

  var id;
  var avatarUrl;
  var nickName;

  String? tagIndex;

  AtUserModel(this.id);

  @override
  String getSuspensionTag() => tagIndex!;
}