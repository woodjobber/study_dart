import 'package:flutter/material.dart';

class IntrinsicWidget extends StatelessWidget {
  const IntrinsicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        color: Colors.red,
                      ),
                      Container(
                        height: 100,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.orangeAccent,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
