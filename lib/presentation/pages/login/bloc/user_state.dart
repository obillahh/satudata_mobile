part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserSet extends UserState {
  final ResponseLogin user;

  const UserSet({required this.user});

  @override
  List<Object> get props => [user];
}
