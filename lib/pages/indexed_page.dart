import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:study_dart/pages/custom_bottom_navigation_bar.dart';
import 'package:study_dart/pages/effect_state.dart';
import 'package:study_dart/pages/keep_alive_page.dart';
import 'package:study_dart/pages/preload_page_view.dart';
import 'package:study_dart/safe_set_state.dart';

class IndexedPage extends StatefulWidget {
  const IndexedPage({super.key});

  @override
  State<IndexedPage> createState() => _IndexedPageState();
}

class _IndexedPageState extends State<IndexedPage> with WidgetsBindingObserver {
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
    KeepAlivePage(child: ABModelDemo()),
    KeepAlivePage(child: TempWidget()),
    KeepAlivePage(child: InheritedModelExample()),
    KeepAlivePage(child: FourPage()),
  ];

  bool pageViewEnable = true;

  final changeIndexNotifier = ValueNotifier(0);
  bool leftToRight = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint('state = $state');
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (currentIndex == 3) {
            leftToRight = false;
          } else if (currentIndex == 0) {
            leftToRight = true;
          }
          if (leftToRight) {
            currentIndex++;
          } else {
            currentIndex--;
          }

          if (pageViewEnable) {
            controller.jumpToPage(currentIndex);
          }
          changeIndexNotifier.value = currentIndex;
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: bottomTabs,
        changeIndexNotifier: changeIndexNotifier,
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
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        EffectState,
        SafeState {
  late var controller = TabController(length: 3, vsync: this);
  @override
  void initState() {
    useEffect(() {
      return () {
        print("_ThirdPageState disposed");
      };
    }).autoDispose(() {
      print("_ThirdPageState disposed2");
    });
    super.initState();
    safeSetState(() {});
  }

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

class ScrollNotifierPage extends StatefulWidget {
  const ScrollNotifierPage({super.key});

  @override
  State<ScrollNotifierPage> createState() => _ScrollNotifierPageState();
}

class _ScrollNotifierPageState extends State<ScrollNotifierPage> {
  String message = 'New';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GFG'),
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            color: Colors.orangeAccent,
            child: Center(
              child: Text(
                message,
                style: TextStyle(fontSize: 35),
              ),
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollStartNotification) {
                  setState(() {
                    message = 'started';
                  });
                } else if (scrollNotification is ScrollUpdateNotification) {
                  setState(() {
                    message = 'updated';
                  });
                } else if (scrollNotification is ScrollEndNotification) {
                  setState(() {
                    message = 'end';
                  });
                } else if (scrollNotification is OverscrollNotification) {
                  setState(() {
                    message = 'over';
                  });
                }
                return true;
              },
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('$index'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InheritedWrapper extends StatefulWidget {
  const InheritedWrapper({
    super.key,
    required this.child,
  });
  final Widget child;

  static InheritedWrapperState of(BuildContext context, {bool build = true}) {
    return build
        ? (context.dependOnInheritedWidgetOfExactType<InheritedCounter>())!.data
        : (context.findAncestorWidgetOfExactType<InheritedCounter>())!.data;
  }

  @override
  State<InheritedWrapper> createState() => InheritedWrapperState();
}

class InheritedWrapperState extends State<InheritedWrapper> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedCounter(
      child: widget.child,
      counter: counter,
      data: this,
    );
  }
}

class InheritedCounter extends InheritedWidget {
  InheritedCounter({
    Key? key,
    required this.child,
    required this.counter,
    required this.data,
  }) : super(key: key, child: child);

  final Widget child;
  final int counter;
  final InheritedWrapperState data;
  @override
  bool updateShouldNotify(covariant InheritedCounter oldWidget) {
    return counter != oldWidget.counter;
  }
}

class TempWidget extends StatefulWidget {
  const TempWidget({super.key});

  @override
  State<TempWidget> createState() => _TempWidgetState();
}

class _TempWidgetState extends State<TempWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InheritedWrapper(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetA(),
            WidgetB(),
            WidgetC(),
          ],
        ),
      ),
    );
  }
}

class WidgetA extends StatefulWidget {
  const WidgetA({super.key});

  @override
  State<WidgetA> createState() => _WidgetAState();
}

class _WidgetAState extends State<WidgetA> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text('add'));
  }

  void onPressed() {
    InheritedWrapperState wrapperState =
        InheritedWrapper.of(context, build: false);
    wrapperState.incrementCounter();
    var id = context.findAncestorWidgetOfExactType<Scaffold>();
    print(id);
  }
}

class WidgetB extends StatelessWidget {
  const WidgetB({super.key});

  @override
  Widget build(BuildContext context) {
    InheritedWrapperState wrapperState = InheritedWrapper.of(context);

    return Text('${wrapperState.counter}');
  }
}

class WidgetC extends StatelessWidget {
  const WidgetC({super.key});

  @override
  Widget build(BuildContext context) {
    InheritedWrapperState wrapperState =
        InheritedWrapper.of(context, build: true);

    return Text('${wrapperState.counter}');
  }
}

enum LogoAspect { backgroundColor, large }

class LogoModel extends InheritedModel<LogoAspect> {
  const LogoModel({
    super.key,
    this.backgroundColor,
    this.large,
    required super.child,
  });

  final Color? backgroundColor;
  final bool? large;

  static Color? backgroundColorOf(BuildContext context) {
    return InheritedModel.inheritFrom<LogoModel>(context,
            aspect: LogoAspect.backgroundColor)
        ?.backgroundColor;
  }

  static bool sizeOf(BuildContext context) {
    return InheritedModel.inheritFrom<LogoModel>(context,
                aspect: LogoAspect.large)
            ?.large ??
        false;
  }

  @override
  bool updateShouldNotify(LogoModel oldWidget) {
    return backgroundColor != oldWidget.backgroundColor ||
        large != oldWidget.large;
  }

  @override
  bool updateShouldNotifyDependent(
      LogoModel oldWidget, Set<LogoAspect> dependencies) {
    print(dependencies);
    if (backgroundColor != oldWidget.backgroundColor &&
        dependencies.contains(LogoAspect.backgroundColor)) {
      return true;
    }
    if (large != oldWidget.large && dependencies.contains(LogoAspect.large)) {
      return true;
    }
    return false;
  }
}

class InheritedModelExample extends StatefulWidget {
  const InheritedModelExample({super.key});

  @override
  State<InheritedModelExample> createState() => _InheritedModelExampleState();
}

class _InheritedModelExampleState extends State<InheritedModelExample> {
  bool large = false;
  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('InheritedModel Sample')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: LogoModel(
              backgroundColor: color,
              large: large,
              child: const BackgroundWidget(
                child: LogoWidget(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Rebuilt Background'),
                      duration: Duration(milliseconds: 500),
                    ),
                  );
                  setState(() {
                    if (color == Colors.blue) {
                      color = Colors.red;
                    } else {
                      color = Colors.blue;
                    }
                  });
                },
                child: const Text('Update background'),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Rebuilt LogoWidget'),
                      duration: Duration(milliseconds: 500),
                    ),
                  );
                  setState(() {
                    large = !large;
                  });
                },
                child: const Text('Resize Logo'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Color color = LogoModel.backgroundColorOf(context)!;

    return AnimatedContainer(
      padding: const EdgeInsets.all(12.0),
      color: color,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      child: child,
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool largeLogo = LogoModel.sizeOf(context);

    return AnimatedContainer(
      padding: const EdgeInsets.all(20.0),
      duration: const Duration(seconds: 2),
      curve: Curves.fastLinearToSlowEaseIn,
      alignment: Alignment.center,
      child: FlutterLogo(size: largeLogo ? 200.0 : 100.0),
    );
  }
}

class ABModel extends InheritedModel<String> {
  const ABModel({
    super.key,
    this.a,
    this.b,
    required super.child,
  });

  final int? a;
  final int? b;

  static ABModel? maybeOf(BuildContext context, [String? aspect]) {
    return InheritedModel.inheritFrom(context, aspect: aspect);
  }

  static int aOf(BuildContext context) {
    final ABModel? result = maybeOf(context, 'a');
    assert(result != null, 'Unable to find an instance of MyModel...');
    return (result!.a ?? 1);
  }

  static int bOf(BuildContext context) {
    final ABModel? result = maybeOf(context, 'b');
    assert(result != null, 'Unable to find an instance of MyModel...');
    return (result!.b ?? 1);
  }

  @override
  bool updateShouldNotify(ABModel oldWidget) {
    return a != oldWidget.a || b != oldWidget.b;
  }

  @override
  bool updateShouldNotifyDependent(
      ABModel oldWidget, Set<String> dependencies) {
    return (a != oldWidget.a && dependencies.contains('a')) ||
        (b != oldWidget.b && dependencies.contains('b'));
  }
}

class ABModelDemo extends StatefulWidget {
  const ABModelDemo({super.key});

  @override
  State<ABModelDemo> createState() => _InheritedModelDemoState();
}

class _InheritedModelDemoState extends State<ABModelDemo> {
  int a = 0;
  int b = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: ABModel(
              a: a,
              b: b,
              child: Builder(
                builder: (ctx) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AWidget(),
                      BWidget(),
                    ],
                  );
                },
              ),
            ),
          ),
          ShaderMask(
            shaderCallback: (bounds) {
              return RadialGradient(
                center: Alignment.topLeft,
                radius: 1.0,
                colors: [Colors.yellow, Colors.deepOrange],
                tileMode: TileMode.clamp,
              ).createShader(bounds);
            },
            child: ElevatedButton(
              onPressed: () {
                a++;
                b++;
                setState(() {});
              },
              child: Text(
                'add',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
          ShaderMask(
            shaderCallback: (bounds) {
              return RadialGradient(
                center: Alignment.topLeft,
                radius: 1.0,
                colors: [Colors.yellow, Colors.deepOrange],
                tileMode: TileMode.clamp,
              ).createShader(bounds);
            },
            child: ElevatedButton(
              onPressed: () {
                a = max(--a, 0);
                b = max(--b, 0);
                setState(() {});
              },
              child: Text(
                'minus',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
          ShaderMask(
            shaderCallback: (bounds) {
              return RadialGradient(
                center: Alignment.topLeft,
                radius: 1.0,
                colors: [Colors.yellow, Colors.deepOrange],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: Text(
              'Burning Text!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AWidget extends StatelessWidget {
  const AWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterLogo(
      size: 2 * ABModel.aOf(context).toDouble(),
    );
  }
}

class BWidget extends StatelessWidget {
  const BWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterLogo(
      size: 5 * ABModel.bOf(context).toDouble(),
    );
  }
}

/// Flutter code sample for [InheritedNotifier].

class SpinModel extends InheritedNotifier<AnimationController> {
  const SpinModel({
    super.key,
    super.notifier,
    required super.child,
  });

  static double of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SpinModel>()!
        .notifier!
        .value;
  }
}

class Spinner extends StatelessWidget {
  const Spinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: SpinModel.of(context) * 2.0 * pi,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.green,
        child: const Center(
          child: Text('Whee!'),
        ),
      ),
    );
  }
}

class InheritedNotifierExample extends StatefulWidget {
  const InheritedNotifierExample({super.key});

  @override
  State<InheritedNotifierExample> createState() =>
      _InheritedNotifierExampleState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _InheritedNotifierExampleState extends State<InheritedNotifierExample>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SpinModel(
      notifier: _controller,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Spinner(),
          Spinner(),
          Spinner(),
        ],
      ),
    );
  }
}

class RepaintBoundaryPage extends StatefulWidget {
  const RepaintBoundaryPage({super.key});
  @override
  State createState() => new _RepaintBoundaryPageState();
}

class _RepaintBoundaryPageState extends State<RepaintBoundaryPage> {
  final GlobalKey _paintKey = new GlobalKey();
  Offset _offset = Offset.zero;

  Widget _buildBackground() {
    return RepaintBoundary(
      child: CustomPaint(
        painter: BackgroundColor(MediaQuery.of(context).size),
        isComplex: true,
        willChange: false,
      ),
    );
  }

  Widget _buildCursor() {
    return Listener(
      onPointerDown: _updateOffset,
      onPointerMove: _updateOffset,
      child: CustomPaint(
        key: _paintKey,
        painter: CursorPointer(_offset),
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan,
        title: const Text('Flutter RepaintBoundary Demo'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _buildBackground(),
          _buildCursor(),
        ],
      ),
    );
  }

  _updateOffset(PointerEvent event) {
    RenderBox? referenceBox =
        _paintKey.currentContext?.findRenderObject() as RenderBox;
    Offset offset = referenceBox.globalToLocal(event.position);
    setState(() {
      _offset = offset;
    });
  }
}

class BackgroundColor extends CustomPainter {
  static const List<Color> colors = [
    Colors.orange,
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.red,
  ];

  Size _size;
  BackgroundColor(this._size);

  @override
  void paint(Canvas canvas, Size size) {
    final Random rand = Random(12345);

    for (int i = 0; i < 10000; i++) {
      canvas.drawOval(
          Rect.fromCenter(
            center: Offset(
              rand.nextDouble() * _size.width - 100,
              rand.nextDouble() * _size.height,
            ),
            width: rand.nextDouble() * rand.nextInt(150) + 200,
            height: rand.nextDouble() * rand.nextInt(150) + 200,
          ),
          Paint()
            ..color = colors[rand.nextInt(colors.length)].withOpacity(0.3));
    }
  }

  @override
  bool shouldRepaint(BackgroundColor other) => false;
}

class CursorPointer extends CustomPainter {
  final Offset _offset;

  CursorPointer(this._offset);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      _offset,
      10.0,
      new Paint()..color = Colors.green,
    );
  }

  @override
  bool shouldRepaint(CursorPointer old) => old._offset != _offset;
}
