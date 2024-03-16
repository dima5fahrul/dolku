// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ChatScreen> {
  final TextEditingController _promptController = TextEditingController();

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/sign_in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        elevation: 1,
        leading: const Icon(Icons.chat, size: 30),
        actions: const [
          Icon(Icons.settings),
          SizedBox(width: 10),
          Icon(Icons.person),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            _PromptView(promptController: _promptController),
            const _ChatView(),
          ],
        ),
      ),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.35,
      child: ListView(
        children: const [
          _ChatBubble(text: 'Hello, how can I help you?', isUser: false),
          _ChatBubble(text: 'I need help with my account', isUser: true),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.text, required this.isUser});

  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isUser
                  ? Colors.grey.shade200
                  : Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(text,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: isUser ? Colors.black : Colors.white)),
          ),
        ),
      ),
    );
  }
}

class _PromptView extends StatefulWidget {
  const _PromptView({required this.promptController});

  final TextEditingController promptController;

  @override
  State<_PromptView> createState() => _PromptViewState();
}

class _PromptViewState extends State<_PromptView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      color: Colors.white,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: TextField(
          controller: widget.promptController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            filled: true,
            fillColor: Colors.grey.shade100,
            hintText: 'Ask me anything!',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send),
            ),
          ),
        ),
      ),
    );
  }
}
