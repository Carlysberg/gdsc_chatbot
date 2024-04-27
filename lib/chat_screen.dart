import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _userInputs = TextEditingController();
  final apiKey = "AIzaSyB2YHQuJDPopAjXFaHhYc1GAhKq9NDEdfI";
  Future<void> callGemini() async {
    final model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);
    final prompt = "hello";
    final content = Content.text(prompt);
    final response = await model.generateContent([content]);
    print(response.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/logo.bmp"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _userInputs,
                        decoration: InputDecoration(
                            label: const Text("Type in here"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            )),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.all(16),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(
                          const CircleBorder(),
                        )),
                    onPressed: () {
                      callGemini();
                    },
                    icon: const Icon(Icons.send, size: 30),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
