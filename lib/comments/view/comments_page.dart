import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_data/placeholder_data.dart';
import 'package:ticketing_system/comments/comments.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key, required this.postId});

  final int postId;

  static Route<void> route(int postId) {
    return MaterialPageRoute<void>(
        builder: (_) => CommentsPage(
              postId: postId,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: BlocProvider(
        create: (_) => CommentBloc(
            postId: postId, dataRepository: context.read<PlaceholderDataAPI>())
          ..add(CommentFetched()),
        child: const CommentsList(),
      ),
    );
  }
}
