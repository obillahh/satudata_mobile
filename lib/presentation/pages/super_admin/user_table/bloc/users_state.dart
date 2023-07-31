// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersSuccess extends UsersState {
  final List<User>? user;
  final User? createUser;
  final int? deleteUser;

  const UsersSuccess({
    this.user,
    this.createUser,
    this.deleteUser,
  });

  @override
  List<Object> get props => [
        user!,
        createUser!,
        deleteUser!,
      ];
}

class UsersFail extends UsersState {
  final String errorMessage;

  const UsersFail({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
