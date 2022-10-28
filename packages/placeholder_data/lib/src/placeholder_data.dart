import 'package:placeholder_data/placeholder_data.dart';

/// {@template placeholder_data}
/// The interface for an API that provides access to placeholder data.
/// {@placeholder_data}
abstract class PlaceholderDataAPI {
  const PlaceholderDataAPI();

  /// Gets all the users starting from page [startIndex].
  Future<List<User>> fetchUsers([int startIndex = 0]);
  Future<List<Post>> fetchUserPosts(int userId, [int startIndex = 0]);
  Future<List<Task>> fetchUserTasks(int userId, [int startIndex = 0]);

  /// Gets all the posts starting from page [startIndex].
  Future<List<Post>> fetchPosts([int startIndex = 0]);

  /// Gets all the comments linked to [postId].
  Future<List<Comment>> fetchComments(int postId, [int startIndex = 0]);

  /// Gets all the tasks starting from page [startIndex].
  Future<List<Task>> fetchTasks([int startIndex = 0]);
}
