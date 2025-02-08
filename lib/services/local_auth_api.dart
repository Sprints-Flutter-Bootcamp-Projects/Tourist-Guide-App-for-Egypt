import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();
  static Future<bool> authenticate() async {
    final supportsBioAuth = await _auth.canCheckBiometrics;

    if (!supportsBioAuth) return false;

    try {
      return await _auth.authenticate(
        localizedReason: 'Scan Fingerprint to Authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
