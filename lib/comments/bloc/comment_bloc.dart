import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:placeholder_data/placeholder_data.dart';
import 'package:ticketing_system/common/bloc/event_transformer.dart';

part 'comment_event.dart';
part 'comment_state.dart';

const throttleDuration = Duration(milliseconds: 100);

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc(
      {required this.postId, required PlaceholderDataAPI dataRepository})
      : _dataRepository = dataRepository,
        super(CommentState(postId: postId)) {
    on<CommentFetched>(
      _onCommentFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final int postId;
  final PlaceholderDataAPI _dataRepository;

  Future<void> _onCommentFetched(
    CommentFetched event,
    Emitter<CommentState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == CommentStatus.initial) {
        final comments = await _dataRepository.fetchComments(state.postId);
        return emit(
          state.copyWith(
            status: CommentStatus.success,
            comments: comments,
            hasReachedMax: false,
          ),
        );
      }
      final comments =
          await _dataRepository.fetchComments(state.comments.length);
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
}
