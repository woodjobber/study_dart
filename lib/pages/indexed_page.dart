import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomTabs,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
          // controller.jumpToPage(index);
        },
      ),
      body: PreloadPageView(
        scrollBehavior: CupertinoScrollBehavior(),
        controller: controller,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: pages,
        preloadPagesCount: pages.length - 1,
        allowImplicitScrolling: true,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
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
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print("_ThirdPageState");
    super.build(context);
    return Scaffold(
      body: Container(
        color: Colors.tealAccent,
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
        color: Colors.blue,
      ),
    );
  }
}
