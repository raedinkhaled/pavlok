part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final User user;

  const UserLoadedState(this.user);

  @override
  List<Object?> get props => [user];
}

class UserInfoLoadedState extends UserState {
  final User user;

  const UserInfoLoadedState(this.user);

  @override
  List<Object?> get props => [user];
}

class UserUpdatedState extends UserState {
  final User user;

  const UserUpdatedState(this.user);

  @override
  List<Object?> get props => [user];
}

class UserErrorState extends UserState {
  final String error;

  const UserErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
