part of 'section_bloc.dart';

class SectionEvent extends Equatable {
  const SectionEvent();

  @override
  List<Object?> get props => [];
}

class SectionChanged extends SectionEvent {
  const SectionChanged(this.status);

  final AppSectionStatus status;

  @override
  List<Object?> get props => [status];
}
