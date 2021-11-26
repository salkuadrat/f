import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:starter_getx/config/config.dart';
import 'package:starter_getx/modules/users/users.dart';
import 'package:starter_getx/widgets/error.dart';
import 'package:starter_getx/widgets/loading_more.dart';
import 'package:starter_getx/widgets/user_item.dart';

class Users extends StatelessWidget {
  final UsersController users;

  const Users(this.users, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Users'),
      ),
      body: Obx(
        () {
          if (users.isFailed) {
            return ErrorMessage(failed, onRefresh: users.reload);
          }

          if (users.isEmpty) {
            return ErrorMessage(empty, onRefresh: users.reload);
          }

          if (users.isLoadingFirst) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: users.reload,
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
}
