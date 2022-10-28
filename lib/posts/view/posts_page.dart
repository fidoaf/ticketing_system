import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_data/placeholder_data.dart';
import 'package:ticketing_system/posts/posts.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key, int? userId}) : _userId = userId ?? -1;

  final int _userId;

  static Route<void> route([int? userId]) {
    return MaterialPageRoute<void>(builder: (_) => PostsPage(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider(
        create: (_) {
          PostBloc bloc =
              PostBloc(dataRepository: context.read<PlaceholderDataAPI>());
          _userId == -1
              ? bloc.add(PostFetched())
              : bloc.add(PostByUserFetched(_userId));
          return bloc;
        },
        child: PostsList(
          userId: _userId,
        ),
      ),
    );
  }
}
