import 'package:flutter/material.dart';

class ListViewPageStorageKeyPage extends StatefulWidget {
  @override
  _ListViewPageStorageKeyPageState createState() =>
      _ListViewPageStorageKeyPageState();
}

class _ListViewPageStorageKeyPageState
    extends State<ListViewPageStorageKeyPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: buildPages(),
        bottomNavigationBar: buildBottomBar(),
      );

  Widget buildBottomBar() {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.clear),
          label: 'listview',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.done),
          label: 'key listview',
        ),
      ],
      onTap: (int index) => setState(() => this.index = index),
    );
  }

  Widget buildPages() {
    switch (index) {
      case 0:
        return buildPageOne();
      case 1:
        return buildPageTwo();
      default:
        return Container();
    }
  }

  Widget buildPageOne() => ListView.builder(
        itemCount: 40,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            'List item ${index + 1}',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );

  Widget buildPageTwo() => ListView.builder(
        key: PageStorageKey<String>('pageTwo'),
        itemCount: 40,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            'List item ${index + 1}',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
}
