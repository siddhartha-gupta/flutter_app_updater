import 'package:package_info/package_info.dart';
import 'package:version/version.dart';
import '../ForceUpdateEvents.dart';

class AppVersionManagerService {
  static PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  static void versionCheck(final String remoteConfigVersion) async {
    _packageInfo = await PackageInfo.fromPlatform();

    Version currentVersion = Version.parse(_packageInfo.version);
    Version requiredVersion = Version.parse(remoteConfigVersion);

    if (requiredVersion > currentVersion) {
      ForceUpdateEvents.setForceUpdate(true);
    } else {
      ForceUpdateEvents.setForceUpdate(false);
    }
  }
}
