part of 'user_bloc_bloc.dart';

abstract class UserBlocEvent extends Equatable {
  const UserBlocEvent();

  @override
  List<Object> get props => [];
}

class UserFetchEvent extends UserBlocEvent {}

class UserFetchEventSortAsc extends UserBlocEvent {}

class UserFetchEventSortDes extends UserBlocEvent {}

