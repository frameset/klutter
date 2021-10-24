import 'package:flutter/material.dart';

class KlutterAboutListTile extends StatelessWidget {
  const KlutterAboutListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AboutListTile(
      applicationLegalese: "Many thanks to gotson for creating Komga",
      applicationName: "Klutter",
      icon: Icon(Icons.help),
      applicationVersion: "0.7.0",
    );
  }
}
