import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:starter_bloc/config/config.dart';
import 'package:starter_bloc/modules/users/users.dart';
import 'package:starter_bloc/widgets/error.dart';
import 'package:starter_bloc/widgets/loading_more.dart';
import 'package:starter_bloc/widgets/user_item.dart';

class Users extends StatelessWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UsersBloc(UsersService()),
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
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, usersState) {
          final users = context.read<UsersBloc>();

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
