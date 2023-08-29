import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../api/api.dart';
import '../model/user_model.dart';

part 'user_bloc_event.dart';
part 'user_bloc_state.dart';

class UserBlocBloc extends Bloc<UserBlocEvent, UserBlocState> {
  List<Result> result = [];
  UserBlocBloc() : super(UserBlocInitial()) {
    final ApiProvider _apiRepository = ApiProvider();
    on<UserFetchEvent>((event, emit) async {
      try {
        emit(UserBlocLoading());
        final mList = await _apiRepository.fetchItems();
        result = mList.results!;
        emit(UserBlocData(userModel: mList.results!));
      } catch (e) {
        log(e.toString());
      }
    });

    on<UserFetchEventSortAsc>((event, emit) async {
      try {
        result.sort((a, b) => a.name!.compareTo(b.name!));

        emit(UserBlocData(userModel: result));
        emit(UserBlocSort());
      } catch (e) {
        log(e.toString());
      }
    });

    on<UserFetchEventSortDes>((event, emit) async {
      try {
        result.sort((a, b) => b.name!.compareTo(a.name!));

        emit(UserBlocData(userModel: result));
        emit(UserBlocSort());
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
