import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_system/full_side_bar.dart';
import 'package:ticketing_system/posts/posts.dart';
import 'package:http/http.dart' as http;

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const PostsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      drawer: const FullSideBar(),
      body: BlocProvider(
        create: (_) => PostBloc(httpClient: http.Client())..add(PostFetched()),
        child: const PostsList(),
      ),
    );
  }
}
