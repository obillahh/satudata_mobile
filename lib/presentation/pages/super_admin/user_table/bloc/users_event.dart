part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

class FetchUsers extends UsersEvent {}

class CreateUser extends UsersEvent {
  final User? user;
  final String? password;
  final String? confPassword;

  const CreateUser({this.user, this.password, this.confPassword});
  @override
  List<Object?> get props => [user, password, confPassword];
}

class DeleteUser extends UsersEvent {
  final int id;

  const DeleteUser({required this.id});

  @override
  List<Object?> get props => [id];
}
