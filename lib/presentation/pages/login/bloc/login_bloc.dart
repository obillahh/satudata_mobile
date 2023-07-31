import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satudata_mobile/data/models/login_model.dart';
import 'package:satudata_mobile/data/request/api_login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Login>(
      (event, emit) async {
        emit(LoginLoading());
        try {
          final responseLogin =
              await ApiUser.login(event.email, event.password);
          emit(LoginSuccess(login: responseLogin));
        } catch (e) {
          emit(
            LoginError(
              error: 'Failed to fetch organizations $e',
            ),
          );
        }
      },
    );
  }
}
