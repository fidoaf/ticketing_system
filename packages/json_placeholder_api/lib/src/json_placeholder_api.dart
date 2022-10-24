import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:placeholder_data/placeholder_data.dart';

class JSONPlaceholderAPI extends PlaceholderDataAPI {
  JSONPlaceholderAPI({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const String _domain = 'jsonplaceholder.typicode.com';

  static const _userLimit = 20;
  static const _postLimit = 20;
  static const int _commentLimit = 20;
  static const _taskLimit = 20;

  final http.Client _httpClient;

  @override
  Future<List<User>> fetchUsers([int startIndex = 0]) async {
    final response = await _httpClient.get(
      Uri.https(
        _domain,
        '/users',
        <String, String>{'_start': '$startIndex', '_limit': '$_userLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
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
    throw Exception('error fetching users');
  }

  @override
  Future<List<Post>> fetchPosts([int startIndex = 0]) async {
    final response = await _httpClient.get(
      Uri.https(
        _domain,
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
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
    throw Exception('error fetching posts');
  }

  @override
  Future<List<Comment>> fetchComments(int postId, [int startIndex = 0]) async {
    final response = await _httpClient.get(
      Uri.https(
        _domain,
        '/posts/$postId/comments',
        <String, String>{'_start': '$startIndex', '_limit': '$_commentLimit'},
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

  @override
  Future<List<Task>> fetchTasks([int startIndex = 0]) async {
    final response = await _httpClient.get(
      Uri.https(
        _domain,
        '/todos',
        <String, String>{'_start': '$startIndex', '_limit': '$_taskLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
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
    throw Exception('error fetching tasks');
  }
}
