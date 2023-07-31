import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/login_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<SetUser>(
      (event, emit) {
        emit(UserSet(user: event.user));
      },
    );
    on<GetUser>(
      (event, emit) {
        emit(UserSet(user: event.user));
      },
    );
  }
}
