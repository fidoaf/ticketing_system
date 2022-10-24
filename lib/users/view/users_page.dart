import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_data/placeholder_data.dart';
import 'package:ticketing_system/users/users.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const UsersPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocProvider(
        create: (_) =>
            UserBloc(dataRepository: context.read<PlaceholderDataAPI>())
              ..add(UserFetched()),
        child: const UsersList(),
      ),
    );
  }
}
