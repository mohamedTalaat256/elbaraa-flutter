import 'package:elbaraa/data/business_logic/chat/chat_cubit.dart';
import 'package:elbaraa/data/models/chat.dart';
import 'package:elbaraa/data/models/user.dart';
import 'package:elbaraa/presentation/widgets/custome_text.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:localization/localization.dart';
import 'package:badges/badges.dart' as badges;

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  late List<Chat> allChats;

/*   int? userId;
  Future getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt("userid");
  } */

 @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatCubit>(context).getAuthUserChat();
  }
/*     @override
  void didChangeDependencies() {
     getId();
       super.didChangeDependencies();
    BlocProvider.of<ChatCubit>(context).getAuthUserChat();

    if (mounted) {
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          setState(() {
            BlocProvider.of<ChatCubit>(context).getAllChats();
          });
        }
      });
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          _appBar(context),
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is ChatsLoading) {
                return showLoadingIndicator();
              } else if (state is ChatsLoaded) {
                allChats = (state).chats;
                return SliverList(
                  delegate: SliverChildBuilderDelegate((_, int index) {
                    /*  DateTime last_date =
                          DateTime.parse(allChats[index].last_date!); */

                    /* int difference = DateTime(
                              last_date.year, last_date.month, last_date.day)
                          .difference(
                              DateTime(today.year, today.month, today.day))
                          .inDays; */

                    /*  if (difference >= 1) {
                        displayed_date = DateFormat.yMMMd().format(
                            DateTime.tryParse(allChats[index].last_date!)!);
                      } else {
                        displayed_date = DateFormat.jm().format(
                            DateTime.tryParse(allChats[index].last_date!)!);
                      } */

                    return _chat_item(allChats[index], context, index);
                  }, childCount: allChats.length),
                );
              } else if (state is ChatLoadingFialState) {
                return showErrorMessage(state.message);
              } else {
                return showLoadingIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  GestureDetector _chat_item(Chat chatItem, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        User user = User.partial(
          id: chatItem.id,
          firstName: chatItem.user.firstName,
          lastName: chatItem.user.lastName,
          imageUrl: chatItem.user.imageUrl,
        );
        Navigator.of(
          context,
        ).pushNamed('/chat_messages_screen', arguments: user).then((_) {
          setState(() {
            BlocProvider.of<ChatCubit>(context).getAuthUserChat();
          });
        });
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: badges.Badge(
                    /* badgeColor: chatItem.unread == 0
                          ? Colors.red.withOpacity(0)
                          : Colors.red, */
                    position: badges.BadgePosition.topEnd(top: -5, end: -5),
                    badgeAnimation: badges.BadgeAnimation.slide(
                      // disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
                      // curve: Curves.easeInCubic,
                    ),
                    badgeContent: chatItem.isRead != 0
                        ? CustomeText(
                            text: chatItem.isRead.toString(),
                            color: Colors.white,
                          )
                        : SizedBox(),
                    child: CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(chatItem.user.imageUrl),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomeText(
                            color: Theme.of(context).primaryColor,
                            text:
                                '${chatItem.user.firstName} ${chatItem.user.lastName}',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: CustomeText(
                                color: Theme.of(context).primaryColor,
                                text: chatItem.lastMessageDate != ''
                                    ? Jiffy.parse(
                                        chatItem.lastMessageDate,
                                      ).format(pattern: "yyyy-MM-dd hh:mm:ss")
                                    : chatItem.lastMessageDate,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            chatItem.lastMessage,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  SliverAppBar _appBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      floating: true,
      pinned: true,
      snap: false,
      centerTitle: false,
      title: CustomeText(
        text: 'messages'.i18n(),
        color: Theme.of(context).primaryColor,
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
      bottom: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Column(
          children: [
            Container(
              width: double.infinity,
              height: 40,
              child: Center(child: _searchTextFormFied()),
            ),
             SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget showLoadingIndicator() {
    return SliverToBoxAdapter(
      child: Center(
        heightFactor: 10.0,
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget showErrorMessage(String messge) {
    return SliverToBoxAdapter(
      child: Center(
        heightFactor: 5.0,
        child: Column(
          children: [
            Text('Failed to Load Messages', style: TextStyle(fontSize: 25)),
            Text(messge, style: TextStyle(fontSize: 15)),
            Icon(Icons.block_outlined, color: Colors.red, size: 66),
          ],
        ),
      ),
    );
  }

  Widget _searchTextFormFied() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: TextFormField(
        onChanged: (value) {},
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.black),
        ),
      ),
    );
  }
}
