import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/business_logic/cubit/libraries_info_cubit.dart';
import 'package:klutter/data/models/librarydto.dart';
import 'package:klutter/presentation/screens/library_screen.dart';
import 'package:klutter/presentation/screens/server_home.dart';
import 'package:klutter/presentation/screens/server_picker.dart';
import 'package:klutter/presentation/widgets/klutter_drawer_header.dart';
import 'package:klutter/presentation/widgets/select_theme_tile.dart';
import 'klutter_about_list_tile.dart';

class ServerDrawer extends StatefulWidget {
  const ServerDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _ServerDrawerState createState() => _ServerDrawerState();
}

class _ServerDrawerState extends State<ServerDrawer> {
  @override
  Widget build(BuildContext context) {
    LibraryDto? currentLibrary =
        ModalRoute.of(context)?.settings.arguments as LibraryDto?;
    return Drawer(
      child: Container(
        width: 50,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            KlutterDrawerHeader(),
            Divider(),
            ListTile(
              selected:
                  ModalRoute.of(context)?.settings.name == ServerHome.routeName,
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, ServerHome.routeName),
            ),
            ListTile(
              selected: currentLibrary == null &&
                  ModalRoute.of(context)?.settings.name ==
                      LibraryScreen.routeName,
              leading: Icon(Icons.library_books),
              title: Text("Libraries"),
              onTap: () => Navigator.pushReplacementNamed(
                  context, LibraryScreen.routeName,
                  arguments: null),
            ),
            BlocBuilder<LibrariesInfoCubit, LibrariesInfoState>(
              bloc: LibrariesInfoCubit()..getAllLibraries(),
              builder: (context, state) {
                if (state is LibrariesInfoReady) {
                  return Column(
                      children: state.libraries
                          .map((e) => ListTile(
                                leading: Icon(null),
                                selected: currentLibrary?.id == e.id,
                                title: Text(
                                  e.name,
                                  style: TextStyle(fontSize: 12),
                                ),
                                onTap: () => Navigator.pushReplacementNamed(
                                    context, LibraryScreen.routeName,
                                    arguments: e),
                              ))
                          .toList());
                }
                return Container();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Change server"),
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  ServerPicker.routeName, (Route<dynamic> route) => false),
            ),
            Divider(),
            KlutterAboutListTile(),
            SelectThemeTile(),
          ],
        ),
      ),
    );
  }
}
