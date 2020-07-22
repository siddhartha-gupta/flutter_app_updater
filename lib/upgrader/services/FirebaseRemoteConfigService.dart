import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'AppVersionManagerService.dart';

class FireBaseRemoteConfigService {
  static RemoteConfig _remoteConfig;
  static String _androidForceUpdateVersion;

  static void fetchConfig() async {
    if (_remoteConfig == null && !kIsWeb) {
      _remoteConfig = await RemoteConfig.instance;
    }

    if (kIsWeb) {
      _androidForceUpdateVersion = '1.0.0';
    } else {
      parseRemoteConfig();
    }
  }

  static void parseRemoteConfig() async {
    try {
      await _remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await _remoteConfig.activateFetched();

      if (Platform.isAndroid) {
        _androidForceUpdateVersion =
            _remoteConfig.getString('android_force_update_version');

        AppVersionManagerService.versionCheck(_androidForceUpdateVersion);
      }
    } on FetchThrottledException catch (exception) {
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }
}
