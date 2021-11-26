import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:starter_riverpod/config/config.dart';
import 'package:starter_riverpod/modules/users/users.dart';
import 'package:starter_riverpod/widgets/error.dart';
import 'package:starter_riverpod/widgets/loading_more.dart';
import 'package:starter_riverpod/widgets/user_item.dart';

class Users extends ConsumerWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.read(usersProvider.notifier);
    final usersState = ref.watch(usersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Users'),
      ),
      body: Builder(
        builder: (_) {
          if (usersState is UsersFailed) {
            return ErrorMessage(failed, onRefresh: users.refresh);
          }

          if (usersState is UsersEmpty) {
            return ErrorMessage(empty, onRefresh: users.refresh);
          }

          if (usersState is UsersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            onRefresh: users.refresh,
            child: ScrollablePositionedList.builder(
              itemScrollController: users.itemScrollController,
              itemPositionsListener: users.itemPositionsListener,
              itemCount: usersState.count + 1,
              itemBuilder: (_, index) {
                bool isItem = index < usersState.count;
                bool isLastIndex = index == usersState.count;
                bool hasReachedMax = usersState is UsersReachedMax;
                bool isLoadingMore = isLastIndex && !hasReachedMax;

                // User Item
                if (isItem) return UserItem(usersState.item(index));

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
