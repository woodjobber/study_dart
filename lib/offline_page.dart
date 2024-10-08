import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class OfflinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Offline Demo"),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          connectivity,
          Widget child,
        ) {
          final bool connected =
              !connectivity.contains(ConnectivityResult.none);
          return new Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                height: 24.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: connected ? Color(0xFF00EE44) : Color(0xFFEE4400),
                  child: Center(
                    child: Text("${connected ? 'ONLINE' : 'OFFLINE'}"),
                  ),
                ),
              ),
              Center(
                child: new Text(
                  'Yay!',
                ),
              ),
            ],
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'There are no bottons to push :)',
            ),
            new Text(
              'Just turn off your internet.',
            ),
          ],
        ),
      ),
    );
  }
}
