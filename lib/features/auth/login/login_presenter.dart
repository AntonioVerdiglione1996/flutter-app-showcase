import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';

class LoginPresenter extends Cubit<LoginViewModel> {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
    this.logInUseCase,
  );

  final LoginNavigator navigator;
  final LogInUseCase logInUseCase;

  LoginPresentationModel get model => state as LoginPresentationModel;

  Future<void> execute() async {
    await logInUseCase
        .execute(
          username: model.email,
          password: model.password,
        )
        .observeStatusChanges(
          (result) => emit(model.copyWith(result)),
        )
        .asyncFold(
          (fail) => navigator.showError(fail.displayableFailure()),
          (success) => unawaited(
            navigator.showAlert(
              title: 'Success',
              message: 'Login successful',
            ),
          ),
        );
  }
}
