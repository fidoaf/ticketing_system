part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CommentFetched extends CommentEvent {}
