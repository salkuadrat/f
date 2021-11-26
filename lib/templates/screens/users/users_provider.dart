import 'dart:io';

/// generate template for users screen
void usersProvider(String project, String dir) {
  File('$dir/users.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:$project/config/config.dart';
import 'package:$project/modules/users/users.dart';
import 'package:$project/widgets/error.dart';
import 'package:$project/widgets/loading_more.dart';
import 'package:$project/widgets/user_item.dart';

class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UsersState(UsersService()),
      child: const UsersPage(),
    );
  }
}

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Users'),
      ),
      body: Consumer<UsersState>(
        builder: (_, users, __) {
          if (users.isFailed) {
            return ErrorMessage(failed, onRefresh: users.refresh);
          }

          if (users.isEmpty) {
            return ErrorMessage(empty, onRefresh: users.refresh);
          }

          if (users.isLoadingFirst) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            onRefresh: users.refresh,
            child: ScrollablePositionedList.builder(
              itemScrollController: users.itemScrollController,
              itemPositionsListener: users.itemPositionsListener,
              itemCount: users.count + 1,
              itemBuilder: (_, index) {
                bool isItem = index < users.count;
                bool isLastIndex = index == users.count;
                bool isLoadingMore = isLastIndex && users.isLoadingMore;

                // User Item
                if (isItem) return UserItem(users.item(index));

                // Show loading more at the bottom
                if (isLoadingMore) return const LoadingMore();

                // Default empty content
                return Container();
              },
            ),
          );
        },
      ),
    );
  }
}''');
}
