import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            child: Text(name[0]),
          ),
          title: Text(name),
        ),
        Divider(),
      ],
    );
  }
}