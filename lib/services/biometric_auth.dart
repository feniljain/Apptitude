import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

LocalAuthentication localAuth;

class BiometricAuth {
  static Future<LocalAuthentication> initBiometric() async {
    localAuth=LocalAuthentication();
    print('Biometric initialized!');
    return Future.value(localAuth);
  }


  @override
  static Future<bool> authenticate() async {
    try {
      final didAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Use fingerprint | PIN | Password | Pattern to verify',
      );
      print('Did authenticate: $didAuthenticate');
      return didAuthenticate;
    } on PlatformException catch (exception) {
      print(exception);
      return false;
    }
  }

  @override
  static Future<bool> isAvailable() async {
    try {
      final canCheckBiometrics = await localAuth.canCheckBiometrics;
      print('Can authenticate: $canCheckBiometrics');
      return canCheckBiometrics;
    } on PlatformException catch (exception) {
      print(exception);
      return false;
    }
  }
}
