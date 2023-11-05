import 'package:flutter/material.dart';
import 'user.dart';
import 'user_widget.dart';

class SameValuesPage extends StatefulWidget {
  @override
  _SameValuesPageState createState() => _SameValuesPageState();
}

class _SameValuesPageState extends State<SameValuesPage> {
  late List<User> users;

  @override
  void initState() {
    super.initState();
    final peter1 = User(
      name: 'Peter Drucker',
      country: 'USA',
    );

    final peter2 = User(
      name: 'Peter Drucker',
      country: 'USA',
    );

    users = [
      peter1,
      peter2,
      User(
        name: 'Sarah Abs',
        country: 'England',
      ),
      User(
        name: 'James High',
        country: 'India',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            children: users.map<Widget>((user) {
              return UserWidget(
                key: ObjectKey(user),
                user: user,
              );
            }).toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.swap_horiz, size: 32),
          onPressed: swapTiles,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );

  void swapTiles() => setState(() {
        final user = users.removeAt(0);
        users.insert(1, user);
      });
}
