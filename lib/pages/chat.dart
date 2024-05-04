import 'package:aiapp/providers/openai.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: constraints.maxHeight - 200,
              child: ChatMessages(),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    )),
                IconButton.outlined(
                    onPressed: () {
                      context
                          .read<OpenAIProvider>()
                          .createMessage(_controller.text);

                      _controller.clear();
                    },
                    icon: const Icon(Icons.arrow_forward)),
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

class ChatMessages extends StatelessWidget {
  const ChatMessages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var messages = context.watch<OpenAIProvider>().messageHistory;

    return ListView(
      children: messages
          .map((message) => Card(
                child: Column(
                  children: [
                    Text(message.role ?? 'no role'),
                    Text(message.content ?? 'no message')
                  ],
                ),
              ))
          .toList(),
    );
  }
}
