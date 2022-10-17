import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_system/users/users.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        switch (state.status) {
          case UserStatus.failure:
            return const Center(child: Text('failed to fetch users'));
          case UserStatus.success:
            if (state.users.isEmpty) {
              return const Center(child: Text('no users'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.users.length
                    ? const BottomLoader()
                    : UserListItem(user: state.users[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.users.length
                  : state.users.length + 1,
              controller: _scrollController,
            );
          case UserStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<UserBloc>().add(UserFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
