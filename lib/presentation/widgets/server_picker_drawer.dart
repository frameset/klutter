import 'package:flutter/material.dart';
import 'package:klutter/presentation/widgets/klutter_drawer_header.dart';
import 'package:klutter/presentation/widgets/select_theme_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'klutter_about_list_tile.dart';

class ServerPickerDrawer extends StatelessWidget {
  const ServerPickerDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        KlutterDrawerHeader(),
        ListTile(
          leading: Icon(Icons.web),
          title: Text("Komga Website"),
          onTap: () => _launchBrowser("http://komga.org"),
        ),
        ListTile(
          leading: Icon(Icons.web),
          title: Text("Klutter GitHub"),
          onTap: () => _launchBrowser("http://github.com/frameset/klutter"),
        ),
        Divider(),
        KlutterAboutListTile(),
        SelectThemeTile(),
      ]),
    );
  }

  Future<void> _launchBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
