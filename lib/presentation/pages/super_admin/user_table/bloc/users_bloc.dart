import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satudata_mobile/data/request/api_user.dart';

import '../../../../../data/models/user/response_user.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<FetchUsers>(
      (event, emit) async {
        emit(UsersLoading());
        try {
          final response = await ApiUsers.getUsers();
          emit(UsersSuccess(user: response));
        } catch (e) {
          print(e);
          emit(const UsersFail(errorMessage: 'Failed to fetch users'));
        }
      },
    );
    on<CreateUser>(
      (event, emit) async {
        emit(UsersLoading());
        try {
          final response = await ApiUsers.createUser(
              event.user!, event.password!, event.confPassword!);
          emit(UsersSuccess(createUser: response));
        } catch (e) {
          print(e);
          emit(const UsersFail(errorMessage: 'Failed to create user'));
        }
      },
    );
    on<DeleteUser>(
      (event, emit) async {
        emit(UsersLoading());
        try {
          final response = await ApiUsers.deleteUser(event.id);
          emit(UsersSuccess(deleteUser: response));
        } catch (e) {
          print(e);
          emit(const UsersFail(errorMessage: 'Failed to delete user'));
        }
      },
    );
  }
}
