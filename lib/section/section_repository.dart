import 'dart:async';

enum AppSectionStatus { home, users, posts }

extension AppSectionStatusX on AppSectionStatus {
  bool get isHome => this == AppSectionStatus.home;
  bool get isUsers => this == AppSectionStatus.users;
  bool get isPosts => this == AppSectionStatus.posts;
}

class SectionRepository {
  final _controller = StreamController<AppSectionStatus>();

  Stream<AppSectionStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AppSectionStatus.home;
    yield* _controller.stream;
  }
}
