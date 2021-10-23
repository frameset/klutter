import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klutter/business_logic/cubit/server_cubit.dart';
import 'package:klutter/business_logic/cubit/servercheck_cubit.dart';
import 'package:klutter/data/models/server.dart';
import 'package:validators/validators.dart';
import 'package:klutter/presentation/widgets/server_picker_drawer.dart';
import 'server_home.dart';

class ServerPicker extends StatefulWidget {
  static const routeName = '/serverPicker';

  const ServerPicker({Key? key}) : super(key: key);

  @override
  _ServerPickerState createState() => _ServerPickerState();
}

class _ServerPickerState extends State<ServerPicker> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServerCubit()..getServers(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text("Select a Komga server")),
            drawer: ServerPickerDrawer(),
            body: BlocConsumer<ServerCubit, ServerState>(
              listener: (context, state) {
                if (state is ServerReady) {
                  Navigator.of(context).pushNamed(ServerHome.routeName);
                }
                if (state is ServerAddNewFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Adding new server failed")));
                }
              },
              builder: (context, state) {
                if (state is ServerInitial) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ServersEmpty) {
                  return Center(
                    child: Text("Add a server using the floating button"),
                  );
                } else if (state is ServersFetched) {
                  return ListView.builder(
                      itemCount: state.servers.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(state.servers[0].key);
                        return Card(
                          child: ServerCard(state.servers[index]),
                        );
                      });
                } else {
                  return Center(
                      child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ));
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                ServerCubit serverCubit = context.read<ServerCubit>();
                AddServerDialog addServerDialog = AddServerDialog();
                showDialog(
                    context: context,
                    builder: (context) {
                      return BlocProvider<ServerCubit>.value(
                        value: serverCubit,
                        child: addServerDialog,
                      );
                    });
              },
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

class AddServerDialog extends StatefulWidget {
  const AddServerDialog({Key? key}) : super(key: key);

  @override
  _AddServerDialogState createState() => _AddServerDialogState();
}

class _AddServerDialogState extends State<AddServerDialog> {
  final _formKey = GlobalKey<FormState>();
  late String serverName;
  late String url;
  late String username;
  late String password;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Add new server"),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) => serverName = value,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      icon: Icon(Icons.star),
                      labelText: 'Server Nickname',
                      hintText: 'Enter a server nickname'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Server Name';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                    keyboardType: TextInputType.url,
                    onChanged: (value) => url = value,
                    decoration: InputDecoration(
                        icon: Icon(Icons.cloud),
                        labelText: 'Server address',
                        hintText: 'Enter the server\'s address'),
                    validator: (value) {
                      if (isURL(
                        value!,
                        protocols: ['http', 'https'],
                        requireProtocol: true,
                      )) {
                        return null;
                      } else {
                        return "URL not valid. Please include the protocol, e.g. https://komga.example.com";
                      }
                    }),
                AutofillGroup(
                    child: Column(children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.username],
                    onChanged: (value) => username = value,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Username',
                        hintText: 'Enter your username'),
                    validator: (value) {
                      if (isEmail(value!)) {
                        return null;
                      } else {
                        return 'Enter your username, it should be a valid email address';
                      }
                    },
                  ),
                  TextFormField(
                    onChanged: (value) => password = value,
                    autofillHints: [AutofillHints.password],
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        icon: Icon(Icons.password),
                        labelText: 'Password',
                        hintText: 'Enter your password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                    obscureText: true,
                  )
                ])),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<ServerCubit>(context).addNewServer(
                            serverName: serverName.trim(),
                            url: url.replaceAll(RegExp(r"\/+$"), ''),
                            username: username,
                            password: password);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Submit"))
              ],
            ),
            // autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        )
      ],
    );
  }
}

class ServerCard extends StatelessWidget {
  final Server server;
  const ServerCard(this.server);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<ServerCubit>()..setCurrentServer(server),
      child: ListTile(
        leading: BlocBuilder<ServerCheckCubit, ServerCheckState>(
            bloc: ServerCheckCubit()..checkServer(server),
            builder: (context, state) {
              if (state is ServerCheckOnline) {
                return ServerCardLeadingIcon(Colors.green);
              } else if (state is ServerCheckOffline) {
                return ServerCardLeadingIcon(Colors.red);
              } else {
                return ServerCardLeadingIcon(Colors.grey);
              }
            }),
        title: Text(server.name),
        subtitle: Text(server.username),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Colors.red,
          onPressed: () =>
              context.read<ServerCubit>()..removeServer(server.key),
        ),
      ),
    );
  }
}

class ServerCardLeadingIcon extends StatelessWidget {
  final Color color;
  const ServerCardLeadingIcon(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity, child: Icon(Icons.circle, color: color));
  }
}
