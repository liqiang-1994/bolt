import 'package:bolt/model/user_model.dart';
import 'package:sp_util/sp_util.dart';

class UserInfoUtils {
  static const String spUserId = "sp_user_id";
  static const String spUserName = "sp_user_name";
  static const String spUserAvatar = "sp_user_avatar";
  static const String spIsLogin = "sp_is_login";


  static UserModel saveUserInfo(Map data) {
    int id = data["id"];
    String userName = data["userName"];
    SpUtil.putInt(spUserId, id);
    SpUtil.putString(spUserName, userName);
    SpUtil.putBool(spIsLogin, true);
    UserModel userModel = UserModel(
        id: id,
        userName: userName
    );
    return userModel;
  }

  static UserModel getUserInfo() {
    bool? isLogin = SpUtil.getBool(spIsLogin);
    if (isLogin == null || !isLogin) {
      return UserModel();
    }
    UserModel userModel = UserModel();
    userModel.id = SpUtil.getInt(spUserId);
    userModel.userName = SpUtil.getString(spUserName);
    return userModel;
  }

  static bool isLogin() {
    bool? isLogin = SpUtil.getBool(spIsLogin);
    return isLogin != null && isLogin;
  }

  static saveUserAvatar(String avatar) async {
    await SpUtil.putString(spUserAvatar, avatar);
  }

  static loginOut() {
    SpUtil.remove(spUserId);
    SpUtil.remove(spUserName);
    SpUtil.remove(spUserAvatar);
    SpUtil.remove(spIsLogin);

  }
}