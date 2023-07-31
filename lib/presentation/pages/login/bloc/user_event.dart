part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class SetUser extends UserEvent {
  final ResponseLogin user;

  const SetUser({required this.user});

  @override
  List<Object?> get props => [user];
}

class GetUser extends UserEvent {
  final ResponseLogin user;

  const GetUser({required this.user});

  @override
  List<Object?> get props => [user];
}
