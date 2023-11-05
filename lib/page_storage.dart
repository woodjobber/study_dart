import 'dart:math';

import 'package:flutter/material.dart';

class PageStorageHomePage extends StatefulWidget {
  @override
  _PageStorageHomePageState createState() => _PageStorageHomePageState();
}

class _PageStorageHomePageState extends State<PageStorageHomePage> {
  final Key keyOne = PageStorageKey('pageOne');
  final Key keyTwo = PageStorageKey('pageTwo');

  int currentTab = 0;

  late PageOne one;
  late PageTwo two;
  late List<Widget> pages;
  late Widget currentPage;

  late List<Data> dataList;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    dataList =
        List.generate(20, (index) => Data(index, false, "Example-$index"))
            .toList();
    one = PageOne(
      key: keyOne,
      dataList: dataList,
    );
    two = PageTwo(
      key: keyTwo,
    );

    pages = [one, two];

    currentPage = one;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Persistence');

    /// PageStorage：widget 临时移出 tree，再次attach ，可恢复状态.
    return Scaffold(
      appBar: AppBar(
        title: Text("Persistence Example"),
      ),
      body: PageStorage(
        child: currentPage,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTab,
        onTap: (int index) {
          setState(() {
            currentTab = index;
            currentPage = pages[index];
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

class PageOne extends StatefulWidget {
  final List<Data> dataList;
  PageOne({
    Key? key,
    required this.dataList,
  }) : super(key: key);

  @override
  PageOneState createState() => PageOneState();
}

class PageOneState extends State<PageOne> {
  @override
  void dispose() {
    print('dispose page one');
    super.dispose();
  }

  Color color = Colors.black54;

  @override
  void initState() {
    print('init State page one');
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        color = randomColor();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.dataList.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            key: PageStorageKey('${widget.dataList[index].id}'),
            title: Text(widget.dataList[index].title),
            onExpansionChanged: (b) => setState(() {
              widget.dataList[index].expanded = b;
              PageStorage.of(context).writeState(context, b,
                  identifier: ValueKey(
                    '${widget.dataList[index].id}',
                  ));
            }),
            initiallyExpanded:
                // widget.dataList[index].expanded,
                PageStorage.of(context).readState(
                      context,
                      identifier: ValueKey(
                        '${widget.dataList[index].id}',
                      ),
                    ) ??
                    false,
            children: <Widget>[
              Container(
                color: index % 2 == 0 ? Colors.orange : color,
                height: 100.0,
              ),
            ],
          );
        });
  }
}

class PageTwo extends StatefulWidget {
  PageTwo({Key? key}) : super(key: key);

  @override
  PageTwoState createState() => PageTwoState();
}

class PageTwoState extends State<PageTwo> {
  @override
  void initState() {
    super.initState();
    print('init state page two');
  }

  @override
  void dispose() {
    print('dispose page two');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(10.0),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(5.0),
          color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
          child: Center(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}

class Data {
  final int id;
  bool expanded;
  final String title;
  Data(this.id, this.expanded, this.title);
}

Color randomColor() {
  return Color.fromARGB(255, Random().nextInt(256) + 0,
      Random().nextInt(256) + 0, Random().nextInt(256) + 0);
}
