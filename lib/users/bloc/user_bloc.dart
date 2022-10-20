import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:ticketing_system/users/users.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';
import 'package:ticketing_system/users/models/models.dart';

part 'user_event.dart';
part 'user_state.dart';

const _userLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.httpClient}) : super(const UserState()) {
    on<UserFetched>(
      _onUserFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onUserFetched(
    UserFetched event,
    Emitter<UserState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == UserStatus.initial) {
        final users = await _fetchUsers();
        return emit(
          state.copyWith(
            status: UserStatus.success,
            users: users,
            hasReachedMax: false,
          ),
        );
      }
      final users = await _fetchUsers(state.users.length);
      users.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: UserStatus.success,
                users: List.of(state.users)..addAll(users),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: UserStatus.failure));
    }
  }

  Future<List<User>> _fetchUsers([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
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
}
