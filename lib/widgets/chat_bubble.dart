import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';

class ChatBubbles extends StatelessWidget {
  const ChatBubbles(this.message, this.isMe, this.userID, {Key? key}) : super(key: key);

    final String message;
    final bool isMe;
    final String userID;

  @override
  Widget build(BuildContext context) {
    String userName = '';
    String ProfileLink = '';
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').where('userUID', isEqualTo: userID).limit(1)
        .get().then((querySnapshot) {
      if (querySnapshot.size > 0) {
        return querySnapshot.docs[0];
      } else {
        throw Exception('유저를 찾을 수 없습니다.');
      }
    }),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(), 
          );
        }else{
         if (snapshot.hasData) {
            Map<String, dynamic>? groupData =
                snapshot.data!.data() as Map<String, dynamic>?;
                 if (groupData != null) {
                  userName = groupData['userName'];
                  ProfileLink = groupData['UserProfileImage'];
         }
        }
        return Stack(
          children: [
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (isMe)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 45, 0),
                  child: ChatBubble(
                    clipper: ChatBubbleClipper8(type: BubbleType.sendBubble),
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top: 20),
                    backGroundColor: const Color(0xff6DC4DB),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          Text(
                            message,
                            style: TextStyle(color: Colors.white),
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
                    clipper: ChatBubbleClipper8(type: BubbleType.receiverBubble),
                    backGroundColor: Color(0xffE7E7ED),
                    margin: EdgeInsets.only(top: 20),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            isMe ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            message,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ],
          ),
          Positioned(
            top : 0,
            right: isMe ? 5 : null,
            left: isMe ? null : 5,
            child: CircleAvatar(
              backgroundImage: NetworkImage(ProfileLink),
            ),
            )
          ]
        );
        }
      }
    );
  }
}