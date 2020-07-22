import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../ForceUpdateStore.dart';
import '../services/DialogService.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = ForceUpdateStore.getLocator()<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showDialog() {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text('New Update Available'),
          content: Text(
            'There is a newer version of app available, please update the app.',
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Update Now'),
              onPressed: () => _launchURL(ForceUpdateStore.getAppUrl()),
            ),
          ],
        );
      },
    );
  }
}
