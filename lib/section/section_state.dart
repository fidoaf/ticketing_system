part of 'section_bloc.dart';

class SectionState extends Equatable {
  const SectionState._({this.status = AppSectionStatus.home});

  final AppSectionStatus status;

  const SectionState.home() : this._(status: AppSectionStatus.home);
  const SectionState.users() : this._(status: AppSectionStatus.users);
  const SectionState.posts() : this._(status: AppSectionStatus.posts);

  @override
  List<Object?> get props => [status];
}
