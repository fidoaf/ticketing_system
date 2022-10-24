import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ticketing_system/comments/comments.dart';
import 'package:ticketing_system/common/bloc/event_transformer.dart';

part 'comment_event.dart';
part 'comment_state.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc({required this.postId, required this.httpClient})
      : super(CommentState(postId: postId)) {
    on<CommentFetched>(
      _onCommentFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final int postId;
  final http.Client httpClient;

  Future<void> _onCommentFetched(
    CommentFetched event,
    Emitter<CommentState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == CommentStatus.initial) {
        final comments = await _fetchComments(state.postId);
        return emit(
          state.copyWith(
            status: CommentStatus.success,
            comments: comments,
            hasReachedMax: false,
          ),
        );
      }
      final comments = await _fetchComments(state.comments.length);
      comments.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: CommentStatus.success,
                comments: List.of(state.comments)..addAll(comments),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: CommentStatus.failure));
    }
  }

  Future<List<Comment>> _fetchComments(int postId, [int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts/$postId/comments',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Comment(
          id: map['id'] as int,
          name: map['name'] as String,
          email: map['email'] as String,
          body: map['body'] as String,
          postId: map['postId'] as int,
        );
      }).toList()
        ..shuffle();
    }
    throw Exception('error fetching comments');
  }
}
