import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_dart/father_widget.dart';
import 'package:study_dart/pages/indexed_page.dart';
import '../flavors.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IndexedPage();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(F.title),
    //   ),
    //
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(
    //           'Hello ${F.title}',
    //         ),
    //         ElevatedButton(
    //           onPressed: () async {},
    //           child: Text('Click Me!'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
