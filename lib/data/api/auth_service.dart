import 'package:hive/hive.dart';

class AuthService {
  static const String tokenBox = 'tokenBox';

  Future<void> storeToken(String token) async {
    var box = Hive.box(tokenBox);
    await box.put('token', token);
    print('Token stored successfully!');
  }

  String? getToken() {
    var box = Hive.box(tokenBox);
    return box.get('token');
  }
}
