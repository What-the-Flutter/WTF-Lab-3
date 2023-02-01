import 'package:shared_preferences/shared_preferences.dart';

import '../utils/verify_method_enum.dart';
import 'security_repository_api.dart';

class SecurityRepository implements SecurityRepositoryApi {
  static const String _userVerifyMethodKey = 'userVerifyMethodKey';

  static VerifyMethod _verifyMethod = VerifyMethod.none;

  @override
  VerifyMethod get verifyMethod => _verifyMethod;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final methodName = prefs.getString(_userVerifyMethodKey);

    if (methodName != null) {
      _verifyMethod = VerifyMethod.values.byName(
        methodName,
      );
    } else {
      prefs.setString(
        _userVerifyMethodKey,
        VerifyMethod.none.name,
      );
    }
  }

  @override
  Future<void> setVerifyMethod(VerifyMethod method) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _userVerifyMethodKey,
      method.name,
    );
  }

  @override
  Future<void> resetToDefault() async {
    await setVerifyMethod(SecurityRepositoryApi.defaultVerifyMethod);
  }
}
