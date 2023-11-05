import 'package:flutter/material.dart';
import 'user.dart';
import 'user_widget.dart';

class ValueKeyPage extends StatefulWidget {
  @override
  _ValueKeyPageState createState() => _ValueKeyPageState();
}

class _ValueKeyPageState extends State<ValueKeyPage> {
  late List<User> users;

  @override
  void initState() {
    super.initState();

    users = [
      User(
        name: 'Peter Drucker',
        country: 'USA',
      ),
      User(
        name: 'Peter Drucker',
        country: 'USA',
      ),
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
                key: ValueKey(user), // not working
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
