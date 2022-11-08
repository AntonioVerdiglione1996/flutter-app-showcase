import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LoginPresentationModel implements LoginViewModel {
  /// Creates the initial state
  LoginPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LoginInitialParams initialParams,
  ) : appLoginResult = const FutureResult.empty();

  /// Used for the copyWith method
  LoginPresentationModel._({
    required this.appLoginResult,
  });

  final FutureResult<Either<LogInFailure, User>> appLoginResult;

  bool _isLoading = false;
  String _password = '';
  String _email = '';

  @override
  bool get isEnabled => _email.isNotEmpty && _password.isNotEmpty;

  @override
  String get password => _password;

  @override
  String get email => _email;

  @override
  bool get isLoading => appLoginResult.isPending();

  void usernameCallback({required String email}) {
    _email = email;
  }

  void passwordCallback({required String password}) {
    _password = password;
  }

  void isLoadingCallback() {
    _isLoading = !_isLoading;
  }

  LoginPresentationModel copyWith(
    FutureResult<Either<LogInFailure, User>>? appLoginResult,
  ) =>
      LoginPresentationModel._(
        appLoginResult: appLoginResult ?? this.appLoginResult,
      );
}

/// Interface to expose fields used by the view (page).
abstract class LoginViewModel {
  bool get isLoading;
  bool get isEnabled;
  String get email;
  String get password;
}
