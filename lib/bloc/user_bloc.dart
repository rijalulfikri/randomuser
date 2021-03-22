import 'package:user/model/user_response.dart';
import 'package:user/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final UserRepository _repository = UserRepository();
  final BehaviorSubject<UserResponse> _subject =
      BehaviorSubject<UserResponse>();

  getUser() async {
    var take = 10;
    Duration interval = Duration(milliseconds: 100);
    Stream<double> stream =
        Stream<double>.periodic(interval, (value) => value / take)
            .take(take + 1);
    await for (double i in stream) {
      var progress = i;
      final response = UserResponse(results: [], progress: progress);
      _subject.sink.add(response);
    }

    _repository.getUser().then((response) => _subject.sink.add(response));
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;
}

final bloc = UserBloc();
