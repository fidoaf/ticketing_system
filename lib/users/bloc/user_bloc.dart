import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:placeholder_data/placeholder_data.dart';
import 'package:ticketing_system/common/bloc/event_transformer.dart';

part 'user_event.dart';
part 'user_state.dart';

const throttleDuration = Duration(milliseconds: 100);

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required PlaceholderDataAPI dataRepository})
      : _dataRepository = dataRepository,
        super(const UserState()) {
    on<UserFetched>(
      _onUserFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final PlaceholderDataAPI _dataRepository;

  Future<void> _onUserFetched(
    UserFetched event,
    Emitter<UserState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == UserStatus.initial) {
        final users = await _dataRepository.fetchUsers();
        return emit(
          state.copyWith(
            status: UserStatus.success,
            users: users,
            hasReachedMax: false,
          ),
        );
      }
      final users = await _dataRepository.fetchUsers(state.users.length);
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
}
