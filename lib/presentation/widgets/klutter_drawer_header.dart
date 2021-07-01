import 'package:flutter/material.dart';

class KlutterDrawerHeader extends StatelessWidget {
  const KlutterDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Stack(
        children: [
          Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Klutter",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Color(Colors.white.value)),
              )),
        ],
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage("assets/images/icon.png"),
              fit: BoxFit.contain)),
    );
  }
}
