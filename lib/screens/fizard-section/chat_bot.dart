import 'package:faszen/services/google_api_service.dart';
import 'package:faszen/widgets/animated_gradient_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/chatmodel.dart';

class Chat extends StatefulWidget {
  final void Function() ongetBack;
  const Chat({super.key, required this.ongetBack});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<ChatModel> list = <ChatModel>[];
  bool isUser = true;
  TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    String formattedDateTime = DateFormat('d MMM HH:mm').format(DateTime.now());
    list.add(
      ChatModel(
        date: formattedDateTime,
        isUser: isUser,
        type: 'show_date',
      ),
    );
    list.add(ChatModel(type: 'end_space', isUser: isUser));
    _apiService.getGoogleApiToken();
  }

  Function(List<ChatModel>)? onListChanged(list) {
    setState(() {
      this.list = list;
    });
    return null;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> _getResponse()async {
    final ChatModel response = await _apiService.queryDialogflow(messageController.text , '1234');
    response.list = list;
    response.index = list.length-1;
    response.onListChanged = onListChanged;
    setState(() {
      list.insert(list.length-1 , response );
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            icon: Icon(Icons.chevron_left_sharp,
                color: Colors.white,
                size: MediaQuery.of(context).size.height * 0.045),
            onPressed: () {
              widget.ongetBack(); 
            },
          ),
        ),
        title: Row(
          children: [
            const Text(
              'Chat with Fizard',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Image.asset(
              "assets/icon1.png",
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.075,
              width: MediaQuery.of(context).size.width * 0.070,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.025),
            Image.asset(
              "assets/icon2.png",
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.075,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.025),
            Image.asset(
              "assets/icon3.png",
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.090,
              width: MediaQuery.of(context).size.width * 0.090,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          ],
        ),
        elevation: 5,
        backgroundColor: Colors.black,
        shadowColor: Colors.black,
        titleSpacing: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView.builder(
              itemCount: list.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return list[index];
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: GradientBorderBox(
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: messageController,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.mic),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          hintText: "Ask Fizard",
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),

                  ),
                  const SizedBox(width: 5),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      color:
                           Colors.grey[500]!, 
                    ),
                    child: IconButton(
                      onPressed: () {
                        String message = messageController.text.trim();
                        if (message.isNotEmpty) {
                          setState(() {
                            list.insert(
                              list.length - 1,
                              ChatModel(
                                text: message,
                                isUser: true,
                                type: 'user_text',
                              ),
                            );
                          });
                          _getResponse();
                          messageController.text = "";
                        }
                      },
                      icon: const Icon(Icons.send),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
