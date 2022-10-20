import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ticketing_system/section/section_repository.dart';

part 'section_event.dart';
part 'section_state.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  SectionBloc({required SectionRepository sectionRepository})
      : _sectionRepository = sectionRepository,
        super(const SectionState.home()) {
    on<SectionChanged>((event, emit) => _onSectionChanged);
    _sectionStatusSubscription = _sectionRepository.status.listen((status) {
      add(SectionChanged(status));
    });
  }

  final SectionRepository _sectionRepository;
  late StreamSubscription<AppSectionStatus> _sectionStatusSubscription;

  @override
  Future<void> close() {
    _sectionStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onSectionChanged(
      SectionChanged event, Emitter<SectionState> emit) async {
    switch (event.status) {
      case AppSectionStatus.home:
        return emit(const SectionState.home());
      case AppSectionStatus.users:
        return emit(const SectionState.users());
      case AppSectionStatus.posts:
        return emit(const SectionState.posts());
      case AppSectionStatus.tasks:
        return emit(const SectionState.tasks());
      case AppSectionStatus.comments:
        return emit(const SectionState.comments());
    }
  }
}
