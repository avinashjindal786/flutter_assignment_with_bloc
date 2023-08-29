part of 'user_bloc_bloc.dart';

abstract class UserBlocState extends Equatable {
  const UserBlocState();

  @override
  List<Object> get props => [];
}

class UserBlocInitial extends UserBlocState {}

class UserBlocLoading extends UserBlocState {}
class UserBlocFilmLoading extends UserBlocState {}
class UserBlocSort extends UserBlocState {}


class UserBlocData extends UserBlocState {
  final List<Result> userModel;
  
  UserBlocData({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class UserBlocFilmData extends UserBlocState {
  final Map<String, dynamic> filmData;

  UserBlocFilmData({required this.filmData});

  @override
  List<Object> get props => [filmData];

}
