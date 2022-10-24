import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:placeholder_data/placeholder_data.dart';
import 'package:ticketing_system/posts/posts.dart';

class MockDataRepository extends Mock implements PlaceholderDataAPI {}

class MockPost extends Mock implements Post {}

void main() {
  group('PostBloc', () {
    late MockDataRepository repository;
    late Post post;
    late PostBloc bloc;

    setUp(() {
      repository = MockDataRepository();
      post = MockPost();
      when(() => post.id).thenReturn(1);
      when(() => post.title).thenReturn('Lorem ipsum');
      when(() => post.body).thenReturn('Lorem ipsum');
      when(() => post.userId).thenReturn(1);
      when(() => repository.fetchPosts())
          .thenAnswer((_) => Future.value(<Post>[]));
      bloc = PostBloc(dataRepository: repository);
    });

    test('initial state is correct', () {
      expect(bloc.state, const PostState());
    });

    test('makes correct api request', () {
      expect(
        repository.fetchPosts(),
        isNot(throwsA(anything)),
      );

      verify(() => repository.fetchPosts()).called(1);
    });
  });
}
