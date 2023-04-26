import 'dart:async';

import '../bloc/user_events.dart';
import '../bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/UserProvider.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(InitialState()) {
    on<GetUserEvent>(_getUserList);
  }

  FutureOr<void> _getUserList(GetUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingState());

    try {
      List<User> user = await ApiProvider().getUsers();
      emit(SuccessUserList(isDivider: true, userList: user)); //same as return Or Send
    } catch (e) {
      print(e);
      emit(FailedUserState());
    }
  }
}
