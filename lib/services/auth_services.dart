import '../utils/storage_util.dart';

class AuthenticationService {
  static Future<void> saveToken(String token) async {
    await StorageUtil.saveToken(token);
  }

  static Future<String?> getToken() async {
    return await StorageUtil.getToken();
  }

  static Future<void> cleartoken() async {
    await StorageUtil.clearToken();
  }
}
