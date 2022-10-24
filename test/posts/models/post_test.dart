// ignore_for_file: prefer_const_constructors
import 'package:placeholder_data/placeholder_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Post', () {
    test('supports value comparison', () {
      expect(
        Post(id: 1, title: 'post title', body: 'post body', userId: 1),
        Post(id: 1, title: 'post title', body: 'post body', userId: 1),
      );
    });
  });
}
