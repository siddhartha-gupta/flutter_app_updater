import 'package:get_it/get_it.dart';

class ForceUpdateStore {
  static GetIt locator = GetIt();
  static String appUrl;

  static GetIt getLocator() {
    return locator;
  }

  static void setAppUrl(String url) {
    ForceUpdateStore.appUrl = url;
  }

  static String getAppUrl() {
    return ForceUpdateStore.appUrl;
  }
}
