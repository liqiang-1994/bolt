import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {

  Future<bool> getPermission(Permission permission) async {
    PermissionStatus permissionStatus = await permission.status;
    if (permissionStatus.isGranted) {
      return true;
    } else {
      permissionStatus = await permission.request();
      if (!permissionStatus.isGranted) {
        openAppSettings();
      }
      return permissionStatus.isGranted;
    }
  }

  Future<void> openCamera() async {
    final bool permission = await getPermission(Permission.camera);
    print(permission);
    if (permission) {
    }
  }
}