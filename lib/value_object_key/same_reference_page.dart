import 'package:flutter/material.dart';
import 'user.dart';
import 'user_widget.dart';

class SameReferencePage extends StatefulWidget {
  @override
  _SameReferencePageState createState() => _SameReferencePageState();
}

class _SameReferencePageState extends State<SameReferencePage> {
  late List<User> users;

  @override
  void initState() {
    super.initState();
    final peter = User(
      name: 'Peter Drucker',
      country: 'USA',
    );

    users = [
      peter,
      //peter, // not working same reference
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
