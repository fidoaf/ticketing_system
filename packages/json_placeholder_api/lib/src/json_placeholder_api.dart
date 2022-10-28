import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:placeholder_data/placeholder_data.dart';

class JSONPlaceholderAPI extends PlaceholderDataAPI {
  JSONPlaceholderAPI({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const String _domain = 'jsonplaceholder.typicode.com';

  static const int _userLimit = 20;
  static const int _postLimit = 20;
  static const int _commentLimit = 20;
  static const int _taskLimit = 20;

  final http.Client _httpClient;

  Future<List<dynamic>> _fetchData(
    String entityName, {
    int startIndex = 0,
    int limit = 20,
  }) async {
    final response = await _httpClient.get(
      Uri.https(
        _domain,
        '/$entityName',
        <String, String>{'_start': '$startIndex', '_limit': '$limit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body;
    }
    throw Exception('error fetching $entityName');
  }

  @override
  Future<List<User>> fetchUsers([int startIndex = 0]) async {
    final items =
        await _fetchData('users', startIndex: startIndex, limit: _userLimit);
    return items.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return User(
        id: map['id'] as int,
        name: map['name'] as String,
        username: map['username'] as String,
        email: map['email'] as String,
      );
    }).toList()
      ..shuffle();
  }

  @override
  Future<List<Post>> fetchUserPosts(int userId, [int startIndex = 0]) async {
    final items = await _fetchData(
      'user/$userId/posts',
      startIndex: startIndex,
      limit: _postLimit,
    );
    return items.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return Post(
        id: map['id'] as int,
        title: map['title'] as String,
        body: map['body'] as String,
        userId: map['userId'] as int,
      );
    }).toList();
  }

  @override
  Future<List<Task>> fetchUserTasks(int userId, [int startIndex = 0]) async {
    final items = await _fetchData(
      'user/$userId/todos',
      startIndex: startIndex,
      limit: _taskLimit,
    );
    return items.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return Task(
        id: map['id'] as int,
        title: map['title'] as String,
        completed: map['completed'] as bool,
        userId: map['userId'] as int,
      );
    }).toList();
  }

  @override
  Future<List<Post>> fetchPosts([int startIndex = 0]) async {
    final items =
        await _fetchData('posts', startIndex: startIndex, limit: _postLimit);
    return items.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return Post(
        id: map['id'] as int,
        title: map['title'] as String,
        body: map['body'] as String,
        userId: map['userId'] as int,
      );
    }).toList()
      ..shuffle();
  }

  @override
  Future<List<Comment>> fetchComments(int postId, [int startIndex = 0]) async {
    final items = await _fetchData(
      'posts/$postId/comments',
      startIndex: startIndex,
      limit: _commentLimit,
    );
    return items.map((dynamic json) {
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

  @override
  Future<List<Task>> fetchTasks([int startIndex = 0]) async {
    final items =
        await _fetchData('todos', startIndex: startIndex, limit: _taskLimit);
    return items.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return Task(
        id: map['id'] as int,
        title: map['title'] as String,
        completed: map['completed'] as bool,
        userId: map['userId'] as int,
      );
    }).toList()
      ..shuffle();
  }
}
