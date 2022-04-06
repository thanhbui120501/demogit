import 'package:firebase_firestore_2/Firestore/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentInfo extends StatelessWidget {
  const StudentInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: const Text('Student Information')),
      body: Consumer(
        builder: (context, ref, _) {
          final _studentAsync = ref.watch(getStudentProvider(arg));
          return _studentAsync.when(
            data: (mStudent) {
              if (mStudent != null) {
                return Padding(
                  padding: const EdgeInsets.only(top: 50, left: 100),
                  child: Column(
                    children: [
                      Column(
                        children: <Widget>[
                          const Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 300,
                            height: 50,
                            child: TextField(
                              decoration:
                                  InputDecoration(hintText: mStudent.name),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: <Widget>[
                          const Text(
                            'Code',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 300,
                            height: 50,
                            child: TextField(
                              decoration:
                                  InputDecoration(hintText: mStudent.code),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: <Widget>[
                          const Text(
                            'Group',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 300,
                            height: 50,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: mStudent.group),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
            error: (err, _) => const SizedBox(),
            loading: () => const SizedBox(),
          );
        },
      ),
    );
  }
}
