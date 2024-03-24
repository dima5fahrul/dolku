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
  String text = '';
  bool isLoading = false;
  List<String> listText = [];

  @override
  void initState() {
    super.initState();
    isLoading = true;
    Future.delayed(const Duration(seconds: 1), () => _initialPrompt());
    isLoading = false;
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/sign_in');
  }

  void _initialPrompt() {
    _promptController.text = 'How can I help you today?';

    setState(() {
      isLoading = true;
      listText.add(_promptController.text);
      isLoading = false;
    });
    _promptController.clear();
  }

  void _onSend() async {
    if (_promptController.text.isNotEmpty) {
      final String message = _promptController.text;
      setState(() {
        isLoading = true;
        listText.add(message);
        isLoading = false;
      });

      _promptController.clear();
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        isLoading = true;
        if (message.toLowerCase().contains('invest')) {
          listText.add(
              'Hey, thanks for the question! You can start investment to companies that you think will provide reciprocity. But you need to know, giving an investment does not mean that the total value of the money given will be fully returned, there could be a loss if the company invested in goes bankrupt. Remain careful in choosing companies to invest in');
        } else {
          listText.add(
              'Sure, here is the list of company with stable shares: Unilever (UNVR), Indofood (ICBP), Bank Central Asia (BBCA), Bank Rakyat Indonesia (BBRI), and Telkom Indonesia (TLKM).');
        }
        isLoading = false;
      });
    }
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
            _PromptView(promptController: _promptController, onSend: _onSend),
            _ChatView(listText: listText, isLoading: isLoading),
          ],
        ),
      ),
    );
  }
}

class _ChatView extends StatefulWidget {
  const _ChatView({required this.listText, required this.isLoading});

  final List<String> listText;
  final bool isLoading;

  @override
  State<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<_ChatView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.765,
      child: ListView.builder(
        itemCount: widget.listText.length,
        itemBuilder: (context, index) {
          if (widget.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _ChatBubble(
              text: widget.listText[index],
              isUser: index % 2 == 1,
            );
          }
        },
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
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(8),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
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
    );
  }
}

class _PromptView extends StatefulWidget {
  const _PromptView({required this.promptController, required this.onSend});

  final TextEditingController promptController;
  final void Function() onSend;

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
              onPressed: widget.onSend,
              icon: const Icon(Icons.send),
            ),
          ),
        ),
      ),
    );
  }
}
