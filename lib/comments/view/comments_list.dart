import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing_system/comments/comments.dart';

class CommentsList extends StatefulWidget {
  const CommentsList({super.key});

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        switch (state.status) {
          case CommentStatus.failure:
            return const Center(child: Text('failed to fetch comments'));
          case CommentStatus.success:
            if (state.comments.isEmpty) {
              return const Center(child: Text('no comments'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.comments.length
                    ? const BottomLoader()
                    : CommentListItem(comment: state.comments[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.comments.length
                  : state.comments.length + 1,
              controller: _scrollController,
            );
          case CommentStatus.initial:
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
    if (_isBottom) context.read<CommentBloc>().add(CommentFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
