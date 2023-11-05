import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';

import 'app_route_observer.dart';

final bucketGlobal = PageStorageBucket();

class PersistPageStoragePage extends StatefulWidget {
  @override
  _PersistPageStoragePageState createState() => _PersistPageStoragePageState();
}

class _PersistPageStoragePageState extends State<PersistPageStoragePage>
    with RouteAware {
  int index = 0;
  PageController controller = PageController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppRouteObserver().routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    /// 取消路由订阅
    AppRouteObserver().routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: bucketGlobal,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PersistPageStoragePage(),
              )),
            ),
          ],
        ),
        body: Builder(builder: (context) {
          return FocusDetector(
            child: buildPageOne(context),
            onVisibilityGained: () {
              final state = bucketGlobal.readState(context,
                  identifier: PageStorageKey('pageOne'));
              print(state);
              if (state != null) controller.jumpTo(state);
            },
          );
        }),
      ),
    );
  }

  Widget buildPageOne(BuildContext context) => NotificationListener(
        onNotification: (Notification t) {
          if (t is ScrollEndNotification) {
            print(t.metrics.pixels);
            bucketGlobal.writeState(context, t.metrics.pixels,
                identifier: PageStorageKey('pageOne'));
          }
          // if (t is ScrollUpdateNotification) {
          //   print(t.scrollDelta);
          // }
          return false;
        },
        child: ListView.builder(
          key: PageStorageKey<String>('pageOne'),
          controller: controller,
          itemCount: 40,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              'List item ${index + 1}',
              style: TextStyle(fontSize: 24),
            ),
            onTap: () {
              // final state = bucketGlobal.readState(context);
              // print(state);
            },
          ),
        ),
      );

  /// Called when the current route has been pushed.
  /// 当前的页面被push显示到用户面前 viewWillAppear.
  @override
  void didPush() {
    print('didPush');
  }

  /// Called when the current route has been popped off.
  /// 当前的页面被pop viewWillDisappear.
  @override
  void didPop() {
    print('didPop');
  }

  /// Called when the top route has been popped off, and the current route
  /// shows up.
  /// 上个面的页面被pop后当前页面被显示时 viewWillAppear.
  @override
  void didPopNext() {
    print('didPopNext');
    final state =
        bucketGlobal.readState(context, identifier: PageStorageKey('pageOne'));
    print(state);
    if (state != null) controller.jumpTo(state);
  }

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible.
  /// 从当前页面push到另一个页面 viewWillDisappear.
  @override
  void didPushNext() {
    print('didPushNext');
  }
}
