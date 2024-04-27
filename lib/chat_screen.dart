import 'package:flutter/material.dart';
import 'package:gdsc_chatbot/message.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _userInputs = TextEditingController();
  static const apiKey = "AIzaSyBe4Jl6oJewne82U7c_cBNfEJa3Ng1_bak";
  final model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);

  List<Message> _message = [];

  Future<void> callGemini() async {
    final message = _userInputs.text;
    setState(() {
      _message.add(
        Message(
          isUser: true,
          message: message,
          date: DateTime.now(),
        ),
      );
    });

    final content = Content.text(message);
    final response = await model.generateContent([content]);
    print(response.text);

    setState(() {
      _message.add(
        Message(
          isUser: false,
          message: response.text ?? "",
          date: DateTime.now(),
        ),
      );
    });
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
              Expanded(
                child: ListView.builder(
                    itemCount: _message.length,
                    itemBuilder: (context, index) {
                      final message = _message[index];
                      return Messages(
                          isUser: message.isUser,
                          message: message.message,
                          date: DateFormat("HH:mm").format(message.date));
                    }),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _userInputs,
                        decoration: InputDecoration(
                            label: const Text("Type in here", style: TextStyle(color: Colors.white),),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            // enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white),
                            // ),
                            ),
                            style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.all(10),
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
