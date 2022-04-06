import 'package:firebase_firestore_2/Firestore/database.dart';
import 'package:firebase_firestore_2/models/student.dart';
import 'package:firebase_firestore_2/pages/liststudents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

TextEditingController name = TextEditingController();
TextEditingController coded = TextEditingController();
TextEditingController group = TextEditingController();

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Demo firebase'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 800, left: 100),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                controller: name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 800, left: 100),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Code',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                controller: coded,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 800, left: 100),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Group',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
                controller: group,
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: Consumer(builder: (context, ref, _) {
                final _dataAsync = ref.watch(streamStudentsProvider);
                return _dataAsync.when(
                  data: (data) {
                    return ListStudents(listStudents: data);
                  },
                  error: (error, _) {
                    return const SizedBox();
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                );
              }),
            ),
            Consumer(builder: (context, ref, _) {
              return ElevatedButton(
                  onPressed: () {
                    ref.read(databaseProvider).addStudent(
                          Student(
                              code: coded.text,
                              name: name.text,
                              group: group.text),
                        );
                    coded.clear();
                    name.clear();
                    group.clear();
                  },
                  child: const Icon(Icons.add));
            }),
          ],
        ));
  }
}
