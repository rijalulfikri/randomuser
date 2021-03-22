import 'package:user/model/user.dart';

enum RStatus { loading, loaded, error }

class UserResponse {
  final List<User> results;
  final String error;
  final RStatus status;
  final double progress;

  UserResponse(
      {this.results,
      this.error = "",
      this.status = RStatus.loading,
      this.progress});

  UserResponse.fromJson(Map<String, dynamic> json)
      : results =
            (json["results"] as List).map((i) => new User.fromJson(i)).toList(),
        error = "",
        status = RStatus.loaded,
        progress = 1;

  UserResponse.withError(String errorValue)
      : results = List(),
        error = errorValue,
        status = RStatus.error,
        progress = 0;
}
