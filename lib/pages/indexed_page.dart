import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:study_dart/pages/keep_alive_page.dart';
import 'package:study_dart/pages/preload_page_view.dart';

class IndexedPage extends StatefulWidget {
  const IndexedPage({super.key});

  @override
  State<IndexedPage> createState() => _IndexedPageState();
}

class _IndexedPageState extends State<IndexedPage> {
  var currentIndex = 0;
  PreloadPageController controller = PreloadPageController(initialPage: 0);
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "首页"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: '分类'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), label: '购物车'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), label: '会员中心'),
  ];

  final pages = const [
    KeepAlivePage(child: HomePage()),
    KeepAlivePage(child: SecondPage()),
    KeepAlivePage(child: ThirdPage()),
    KeepAlivePage(child: FourPage()),
  ];

  bool pageViewEnable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          currentIndex = 3;
          setState(() {});
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomTabs,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
          if (pageViewEnable) {
            controller.jumpToPage(index);
          }
        },
      ),
      body: pageViewEnable
          ? PreloadPageView(
              scrollBehavior: CupertinoScrollBehavior(),
              controller: controller,
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: pages,
              preloadPagesCount: pages.length - 1,
              allowImplicitScrolling: true,
            )
          : SwipeDetector(
              child: IndexedStack(
                children: [...pages],
                index: currentIndex,
              ),
              onSwipeLeft: (offset) {
                print(offset);
                if (offset.dx.abs() < 40) {
                  return;
                }
                if (currentIndex >= pages.length - 1) {
                  return;
                }
                currentIndex++;
                if (currentIndex > pages.length - 1) {
                  currentIndex = pages.length - 1;
                }
                setState(() {});
              },
              onSwipeRight: (offset) {
                print(offset);
                if (offset.dx.abs() < 40) {
                  return;
                }
                if (currentIndex == 0) {
                  return;
                }
                setState(() {
                  currentIndex--;
                  if (currentIndex < 0) {
                    currentIndex = 0;
                  }
                });
              },
            ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Center(
          child: ElevatedButton(onPressed: () {}, child: Text('tab4')),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});
  @override
  Widget build(BuildContext context) {
    print("SecondPage");
    return Scaffold(
      body: Container(
        color: Colors.orangeAccent,
      ),
    );
  }
}

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late var controller = TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    print("_ThirdPageState");
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          tabs: [
            Text('data1'),
            Text('data2'),
            Text('data3'),
          ],
          controller: controller,
        ),
      ),
      body: Container(
        color: Colors.tealAccent,
        child: Stack(
          children: [
            TabBarView(
              children: [Container(), Container(), Container()],
              controller: controller,
            ),
            TabPageSelector(
              controller: controller,
              color: Colors.tealAccent,
              selectedColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class FourPage extends StatelessWidget {
  const FourPage({super.key});
  @override
  Widget build(BuildContext context) {
    print("FourPage");
    return Scaffold(
      body: Container(
        color: Colors.purple,
        child: Center(
          child: CupertinoButton.filled(
              child: Text(
                'open',
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .push(MaterialPageRoute(builder: (ctx) {
                  return ThirdPage();
                }));
              }),
        ),
      ),
    );
  }
}

class CupertinoTabPageWidget extends StatefulWidget {
  const CupertinoTabPageWidget({super.key});

  @override
  State<CupertinoTabPageWidget> createState() => _CupertinoTabPageWidgetState();
}

class _CupertinoTabPageWidgetState extends State<CupertinoTabPageWidget> {
  var currentIndex = 0;
  final List<BottomNavigationBarItem> tabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "首页"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: '分类'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), label: '购物车'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), label: '会员中心'),
  ];

  final pages = const [
    KeepAlivePage(child: HomePage()),
    KeepAlivePage(child: SecondPage()),
    KeepAlivePage(child: ThirdPage()),
    KeepAlivePage(child: FourPage()),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: currentIndex,
        items: tabs,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (child) {
            return CupertinoPageScaffold(
              child: pages[index],
              navigationBar: CupertinoNavigationBar(
                middle: Text(tabs[index].label!),
                backgroundColor: Colors.transparent,
              ),
            );
          },
        );
      },
    );
  }
}
