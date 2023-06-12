import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppReportScreen extends StatefulWidget {
  const AppReportScreen({super.key});

  @override
  State<AppReportScreen> createState() => _AppReportScreenState();
}

class _AppReportScreenState extends State<AppReportScreen> {
  //final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  var _ReportReason = '';
  //var _ReportType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            height: 50,
            child: Image.asset('assets/icons/아이콘_흰색(512px).png'),
          ),
          centerTitle: true,
          elevation: 2,
          backgroundColor: const Color(0xff6DC4DB),
          foregroundColor: Colors.white,
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Column(children: [
                        const Text(
                          "서비스 문의",
                          style: TextStyle(
                            fontFamily: "Ssurround",
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "서비스 문의 유저: " + snapshot.data!['userName'],
                          style: const TextStyle(
                            fontFamily: "Ssurround",
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        /*TextField(
                  maxLines: 1,
                  controller: _controller,
                  decoration: const InputDecoration(labelText: '신고 유형'),
                  onChanged: (value) {
                      _ReportType = value;
                  },
                ),
                */
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xff6DC4DB), width: 3),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            maxLines: null,
                            controller: _controller2,
                            decoration: const InputDecoration(
                              labelText: '문의 내용',
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              _ReportReason = value;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: const Text(
                                    "문의 내용을 제출하시겠습니까?",
                                    style: TextStyle(
                                      fontFamily: "Ssurround",
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        child: const Text('확인'),
                                        onPressed: () async {
                                          FirebaseFirestore.instance
                                              .collection('reports')
                                              .add({
                                            "reporterType": 'ServiceReport',
                                            "reporterUID": FirebaseAuth
                                                .instance.currentUser?.uid,
                                            //"reporttype": _ReportType,
                                            "reportreason": _ReportReason,
                                          });
                                          Navigator.of(context).pop();
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    content: const Text(
                                                      "제출이 완료되었습니다.",
                                                      style: TextStyle(
                                                        fontFamily: "Ssurround",
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text('확인'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )
                                                    ]);
                                              });
                                        }),
                                    TextButton(
                                      child: const Text('취소'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: const Color(0xff6DC4DB),
                          ),
                          child: const Text(
                            '제출하기',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "SsurroundAir",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ])),
                );
              }
            }));
  }
}
