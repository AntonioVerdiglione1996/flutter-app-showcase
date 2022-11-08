import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/domain/stores/user_store.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/main.dart';

class LogInUseCase {
  const LogInUseCase(this._userStore);

  final UserStore _userStore;

  static const int _kMilliseconds = 500;
  static const int _kMultiplier = 2;

  Future<Either<LogInFailure, User>> execute({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      return failure(const LogInFailure.missingCredentials());
    }

    if (!isUnitTests) {
      await Future.delayed(
        Duration(
          milliseconds:
              _kMilliseconds + Random().nextInt(_kMilliseconds * _kMultiplier),
        ),
      );
    }

    if (username == 'test' && password == 'test123') {
      final user = User(
        id: "id_$username",
        username: username,
      );
      _userStore.user = user;
      return success(
        user,
      );
    }
    return failure(const LogInFailure.unknown());
  }
}
