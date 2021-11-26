import 'package:flutter/material.dart';

import 'package:starter_riverpod/models/user.dart';

class UserItem extends StatelessWidget {
  final User user;

  const UserItem(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 20,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        leading: ClipOval(
          child: Container(
            color: Colors.grey.withOpacity(0.25),
            padding: const EdgeInsets.all(10),
            child: const Icon(Icons.person),
          ),
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: user.isActive ? const Icon(Icons.check) : null,
      ),
    );
  }
}
