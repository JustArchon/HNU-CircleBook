import 'package:flutter/material.dart';

class GroupCalendarScreen extends StatefulWidget {
  final String title, groupId;

  const GroupCalendarScreen({
    super.key,
    required this.title,
    required this.groupId,
  });

  @override
  State<GroupCalendarScreen> createState() => _GroupCalendarScreenState();
}

class _GroupCalendarScreenState extends State<GroupCalendarScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "그룹명",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        actions: <Widget>[
          // 그룹 방 내 상단 메뉴 버튼 예정
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () {
              //print('Group menu button is clicked');
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                  bottom: 10,
                ),
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: Colors.lightGreen,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "도서명 : ${widget.title}",
                      style: const TextStyle(fontSize: 20),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // 그룹 내 데이터 가져올 예정
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "그룹 인원 (04 / 04)",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Text(
                          "토론 횟수 (01 / 02)",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "독서 기간 (11 / 14)",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Text(
                          "인증 기간 (02 / 03)",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // 달력 관리 프로그램 구현 예정
          const Center(
            child: Text(
              "달력",
              style: TextStyle(fontSize: 50),
            ),
          ),
        ],
      ),
    );
  }
}
