import 'package:rxdart/subjects.dart';

class ForceUpdateEvents {
  static PublishSubject<bool> appForceUpdate = new PublishSubject<bool>();

  static void setForceUpdate(final bool forceUpdate) {
    appForceUpdate.add(forceUpdate);
  }
}
