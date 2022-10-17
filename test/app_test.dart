// ignore_for_file: prefer_const_constructors

import 'package:ticketing_system/app.dart';
import 'package:ticketing_system/posts/posts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticketing_system/section/section_repository.dart';

void main() {
  group('App', () {
    testWidgets('renders PostsPage', (tester) async {
      await tester.pumpWidget(App(
        sectionRepository: SectionRepository(),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(PostsPage), findsOneWidget);
    });
  });
}
