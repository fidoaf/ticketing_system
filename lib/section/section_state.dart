part of 'section_bloc.dart';

class SectionState extends Equatable {
  const SectionState._(
      {this.status = AppSectionStatus.home,
      this.focusedSection = AppSectionStatus.home});

  final AppSectionStatus status;
  final AppSectionStatus focusedSection;

  const SectionState.home() : this._(status: AppSectionStatus.home);
  const SectionState.users() : this._(status: AppSectionStatus.users);
  const SectionState.posts() : this._(status: AppSectionStatus.posts);
  const SectionState.tasks() : this._(status: AppSectionStatus.tasks);
  const SectionState.comments() : this._(status: AppSectionStatus.comments);

  @override
  List<Object?> get props => [status];
}
