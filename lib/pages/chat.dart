import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("test"),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: const TextField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    )),
                IconButton.outlined(
                    onPressed: () {}, icon: const Icon(Icons.arrow_forward)),
              ],
            ),
            SizedBox(
              height: 100,
              width: constraints.maxWidth,
            )
          ],
        ),
      );
    });
  }
}
