part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserOk extends UserState {
  final data;
  final feature;

  UserOk({
    this.data,
    this.feature,
  });
}
