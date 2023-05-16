import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatBubbles extends StatelessWidget {
  const ChatBubbles(this.message, this.isMe, this.userID, {Key? key}) : super(key: key);

  final String message;
  final bool isMe;
  final String userID;
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore
      .instance
      .collection('users')
      .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            String userName = '';
            final UserDocs = snapshot.data!.docs;
            final UserDocsSize = UserDocs.length - 1; 
            for(int i = 0; i < UserDocsSize; i++){
            if(UserDocs[i]['userUID'] == userID){
            userName = UserDocs[i]['userName'];
            }
          }
            return Stack(children: [
              Row(
                mainAxisAlignment:
                    isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  if (isMe)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 45, 0),
                      child: ChatBubble(
                        clipper:
                            ChatBubbleClipper8(type: BubbleType.sendBubble),
                        alignment: Alignment.topRight,
                        margin: const EdgeInsets.only(top: 20),
                        backGroundColor: const Color(0xff6DC4DB),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Column(
                            crossAxisAlignment: isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                message,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (!isMe)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 10, 0, 0),
                      child: ChatBubble(
                        clipper:
                            ChatBubbleClipper8(type: BubbleType.receiverBubble),
                        backGroundColor: const Color(0xffE7E7ED),
                        margin: const EdgeInsets.only(top: 20),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Column(
                            crossAxisAlignment: isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                message,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
              Positioned(
                top: 0,
                right: isMe ? 5 : null,
                left: isMe ? null : 5,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/icons/usericon.png'),
                ),
              )
            ]);
          }
        });
  }
}
