import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_system/users/users.dart';
import 'package:http/http.dart' as http;

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
        create: (_) => UserBloc(httpClient: http.Client())..add(UserFetched()),
        child: const UsersList(),
      ),
    );
  }
}
