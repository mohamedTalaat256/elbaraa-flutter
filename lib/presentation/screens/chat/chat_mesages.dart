
import 'package:elbaraa/constants/strings.dart';
import 'package:elbaraa/data/business_logic/chat/chat_bloc.dart';
import 'package:elbaraa/data/business_logic/chat/chat_cubit.dart';
import 'package:elbaraa/data/models/user.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/ChatMessage.dart';

class ChatMessagesScreen extends StatefulWidget {
  final User secondPerson;

  ChatMessagesScreen({
    Key? key,
    required this.secondPerson,
  }) : super(key: key);

  @override
  State<ChatMessagesScreen> createState() => _ChatMessagesScreenState();
}

class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
  ScrollController _scrollController =
      new ScrollController(initialScrollOffset: 0.0);

  int? userId;
  String? sendMessage;
  var _controller = TextEditingController();
  late List<ChatMessage> chatMessages;

  User? user;

  Future getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt("userid");
  }

  @override
  void initState() {
    getId();

    super.initState();
    BlocProvider.of<ChatCubit>(context)
        .getChatMessages(widget.secondPerson.id);
  }

  bool sendingMessageLoading = false;
  bool messageSendSuccess = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      /* FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          if (message.data['sender_id'] == widget.secondPerson.id) {
            setState(() {
              chatMessages.insert(
                  0,
                  ChatMessage(
                      id: '0',
                      message: message.notification?.body,
                      name: '',
                      avatar: '',
                      created_at: message.sentTime.toString(),
                      sender_id: 1));
            });
            _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );
          }
        }
      }); */
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context, widget.secondPerson),
        body: BlocListener<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state is SendingMessageLoadingState) {
              setState(() {
                sendingMessageLoading = true;
              });
            } else if (state is MessageSendSuccessState) {
              setState(() {
                sendingMessageLoading = false;
                messageSendSuccess = true;
              });
            } else if (state is MessageSendFailState) {
              _showDialog(context, state.message);
              setState(() {
                sendingMessageLoading = false;
              });
            }
          },
          child: Column(
            children: <Widget>[
              Expanded(child: _chatMessages()),
              _sendTextInput(),
            ],
          ),
        ));
  }

  Future<String?> _showDialog(BuildContext context, String message) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Text(message),
        content: const Text('Fail to send Message'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text(
              'Cancel',
              style: TextStyle(color: kTextGreen),
            ),
          ),
        ],
      ),
    );
  }

  Padding _sendingMessageWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context, User user) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      foregroundColor: Theme.of(context).primaryColor,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(user.imageUrl),
                maxRadius: 20,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      user.firstName,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    user.online != 0
                        ? Text('Online',
                            style: TextStyle(color: Colors.green, fontSize: 13))
                        : Text('Offline',
                            style: TextStyle(color: Colors.red, fontSize: 13)),
                  ],
                ),
              ),
              Icon(
                Icons.settings,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Align _sendTextInput() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
        height: 60,
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: softTextOrange,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  sendMessage = value;
                },
                decoration: InputDecoration(
                  hintText: "Write message...",
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            FloatingActionButton(
              onPressed: () {
               /*  DateTime now = DateTime.now();
                BlocProvider.of<ChatBloc>(context).add(SendMessageButtonPressed(
                    reciver_id: widget.secondPerson.id!,
                    message: sendMessage!));

                if (messageSendSuccess) {
                  print('message sent>>>>>>>>>>>>>>>>');
                  setState(() {
                    chatMessages.insert(
                        0,
                        ChatMessage(
                            id: '0',
                            message: sendMessage!,
                            name: '',
                            avatar: '',
                            created_at: now.toString(),
                            sender_id: userId));
                  });
                }

                _scrollController.animateTo(
                  _scrollController.position.minScrollExtent,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );

                _controller.clear(); */
              },
              child: sendingMessageLoading
                  ? _sendingMessageWidget(context)
                  : Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
              backgroundColor: softTextOrange,
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }

  BlocBuilder<ChatCubit, ChatState> _chatMessages() {
    return BlocBuilder<ChatCubit, ChatState>(builder: (cxt, state) {
      if (state is ChatMessagesLoaded) {
        chatMessages = (state).chatMessages;

        print(chatMessages.length);
        return Container(
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            reverse: true,
            itemCount: chatMessages.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
                child: Align(
                  alignment: (chatMessages[index].sender_id == userId
                      ? Alignment.topRight
                      : Alignment.topLeft),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: (chatMessages[index].sender_id == userId
                          ? softTextOrange.withOpacity(0.8)
                          : Color.fromARGB(255, 218, 218, 218)),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment:
                          chatMessages[index].sender_id == userId
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatMessages[index].message!,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              chatMessages[index].created_at!.substring(11, 16),
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            chatMessages[index].sender_id == userId
                                ? Icon(
                                    Icons.done,
                                    size: 14.0,
                                  )
                                : SizedBox(
                                    width: 0,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
