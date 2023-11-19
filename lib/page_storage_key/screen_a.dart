import 'package:flutter/material.dart';

class ScreenA extends StatefulWidget {
  const ScreenA({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScreenAState();
  }
}

class _ScreenAState extends State<ScreenA> {
  ScrollController controller = ScrollController();
  bool _firstAutoscrollExecuted = false;
  bool _shouldAutoscroll = false;
  void _scrollToBottom() {
    controller.jumpTo(controller.position.maxScrollExtent);
  }

  void _scrollListener() {
    print('object');
    _firstAutoscrollExecuted = true;

    if (controller.hasClients &&
        controller.position.pixels == controller.position.maxScrollExtent) {
      _shouldAutoscroll = true;
    } else {
      _shouldAutoscroll = false;
    }
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (controller.hasClients && _shouldAutoscroll) {
        _scrollToBottom();
      }

      if (!_firstAutoscrollExecuted && controller.hasClients) {
        _scrollToBottom();
      }
    });
    print('screen_a_init');
  }

  @override
  Widget build(BuildContext context) {
    print('screen_a');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen A'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.separated(
          controller: controller,
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
              tileColor: Colors.yellow,
              title: Center(child: Text('Item $index')),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 15,
            );
          },
        ),
      ),
    );
  }
}
