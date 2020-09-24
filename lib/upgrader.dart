import 'dart:async';

import 'upgrader/ForceUpdateEvents.dart';
import 'upgrader/ForceUpdateStore.dart';
import 'upgrader/services/DialogService.dart';
import 'upgrader/services/AppVersionManagerService.dart';

class UpgraderService {
  static DialogService _dialogService =
      ForceUpdateStore.getLocator()<DialogService>();
  static StreamSubscription<bool> forceUpdateSubscription;

  static void initialize(String appUrl) async {
    ForceUpdateStore.setAppUrl(appUrl);
    ForceUpdateStore.getLocator().registerLazySingleton(() => DialogService());
    forceUpdateSubscription =
        ForceUpdateEvents.appForceUpdate.listen((value) async {
      if (value) {
        await _dialogService.showDialog();
      }
    });
  }

  static void verifyVersion(final String remoteConfigVersion) {
    AppVersionManagerService.versionCheck(remoteConfigVersion);
  }

  static void cleanup() {
    forceUpdateSubscription.cancel();
  }
}
