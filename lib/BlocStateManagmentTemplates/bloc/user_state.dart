//state is from bloc to Ui
import '../data/UserProvider.dart';

abstract class UserState {}

class InitialState extends UserState {}

class SuccessUserList extends UserState {
  List<User> userList;
  bool isDivider;
  SuccessUserList({required this.userList, required this.isDivider});
}

class LoadingState extends UserState {}

class FailedUserState extends UserState {}
