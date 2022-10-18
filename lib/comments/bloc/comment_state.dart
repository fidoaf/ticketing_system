part of 'comment_bloc.dart';

enum CommentStatus { initial, success, failure }

class CommentState extends Equatable {
  const CommentState({
    this.status = CommentStatus.initial,
    this.comments = const <Comment>[],
    this.hasReachedMax = false,
    required this.postId,
  });

  final CommentStatus status;
  final List<Comment> comments;
  final bool hasReachedMax;
  final int postId;

  CommentState copyWith({
    CommentStatus? status,
    List<Comment>? comments,
    bool? hasReachedMax,
    int? postId,
  }) {
    return CommentState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      postId: postId ?? this.postId,
    );
  }

  @override
  String toString() {
    return '''CommentState { status: $status, hasReachedMax: $hasReachedMax, comments: ${comments.length} }''';
  }

  @override
  List<Object> get props => [status, comments, hasReachedMax];
}
