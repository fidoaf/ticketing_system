import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_data/placeholder_data.dart';
import 'package:ticketing_system/posts/posts.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const PostsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider(
        create: (_) =>
            PostBloc(dataRepository: context.read<PlaceholderDataAPI>())
              ..add(PostFetched()),
        child: const PostsList(),
      ),
    );
  }
}
