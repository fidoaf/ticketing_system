part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostFetched extends PostEvent {}

class PostByUserFetched extends PostEvent {
  const PostByUserFetched(this.userId);

  final int userId;

  @override
  List<Object> get props => [userId];
}
