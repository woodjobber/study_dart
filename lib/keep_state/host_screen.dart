import 'package:flutter/material.dart';
import 'package:study_dart/keep_state/screen_a.dart';
import 'package:study_dart/keep_state/screen_b.dart';

class HostPage extends StatefulWidget {
  const HostPage({Key? key}) : super(key: key);

  @override
  State<HostPage> createState() => _HomePageState();
}

final PageStorageBucket _bucket = PageStorageBucket();

class _HomePageState extends State<HostPage> {
  int _selectedIndex = 0;
  final PageController _controller = PageController();

  final list = [
    ScreenA(
      key: PageStorageKey('screen_a'),
    ),
    ScreenB(
      key: PageStorageKey('screen_b'),
    ),
  ];
  void onTap(int index) {
    if (_selectedIndex != index) {
      _controller.jumpToPage(index);
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final bottomNavigationBarItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Screen A'),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_wallet), label: 'Screen B')
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageStorage(
        bucket: _bucket,
        child: Scaffold(
          body: PageView(
            key: PageStorageKey('page_view'),
            children: list,
            controller: _controller,
            onPageChanged: onTap,
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: onTap,
              items: bottomNavigationBarItems),
        ),
      ),
    );
  }
}

/// 保持状态 keep state/alive
/// 方式如下：
/// 1、IndexedStack,如果您有大量子项或每个子项都很重，这可能会导致性能问题,因此，
/// 对于具有少量子项的小型且简单的小部件，建议使用 IndexedStack。
/// 2、AutomaticKeepAliveClientMixin,它允许子树请求在惰性列表中保持活动状态。
/// 3、PageStorage,PageStorage 用于保存和恢复比小部件寿命更长的值。
/// 通过在根添加 PageStorage 并向每个页面添加 PageStorageKey，
/// 页面的某些状态（例如 Scrollable 小部件的滚动位置）将自动存储在其最近的祖先 PageStorage 中，
/// 并在切换回来时恢复。
