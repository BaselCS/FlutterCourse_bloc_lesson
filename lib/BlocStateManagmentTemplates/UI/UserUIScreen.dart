import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_events.dart';
import '../bloc/user_state.dart';
import '../data/UserProvider.dart';

class MyBlocPage extends StatefulWidget {
  MyBlocPage({Key? key}) : super(key: key);

  @override
  State<MyBlocPage> createState() => _MyBlocPageState();
}

class _MyBlocPageState extends State<MyBlocPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Users List")),
      body: buildBloc(),
    );
  }

  /**  --------------- Focus Here  ----------------------- **/
  Widget buildBloc() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is FailedUserState)
          return Center(
            child: Text("FailedUserState"),
          );

        if (state is LoadingState)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (state is SuccessUserList) {
          //Not same as ==
          List<User> usersList = state.userList;
          bool isDivider = state.isDivider;
          return buildUserList(usersList, isDivider);
        }
        return Center(
            child: ElevatedButton(
          onPressed: () {
            context.read<UserBloc>().add(GetUserEvent()); //How to read
          },
          child: Text("Get User List"),
        ));
      },
    );
  }
  /** 
   --------------- Focus Here  -----------------------
     **/

  Widget buildUserList(List<User> users, bool isDivider) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: [
            ListTile(leading: Icon(Icons.person), title: Text("${users[index].name}"), subtitle: Text("${users[index].email}")),
            if (isDivider) Divider()
          ]);
        });
  }
}
