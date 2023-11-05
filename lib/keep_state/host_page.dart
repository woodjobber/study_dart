import 'package:flutter/material.dart';
import 'package:study_dart/keep_state/persist_pagestorage_page.dart';

import 'button_widget.dart';

class HostPage extends StatefulWidget {
  const HostPage({super.key});

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ButtonWidget(
              //   text: 'ListView',
              //   onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => ListViewPageStorageKeyPage(),
              //   )),
              // ),
              // const SizedBox(height: 16),
              // ButtonWidget(
              //   text: 'GridView',
              //   onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => GridViewPageStorageKeyPage(),
              //   )),
              // ),
              // const SizedBox(height: 16),
              // ButtonWidget(
              //   text: 'ExpansionTile',
              //   onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => ExpansionPageStorageKeyPage(),
              //   )),
              // ),
              const SizedBox(height: 16),
              ButtonWidget(
                text: 'PageStorage',
                onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PersistPageStoragePage(),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
