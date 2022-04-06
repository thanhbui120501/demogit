import 'package:firebase_firestore_2/models/student.dart';
import 'package:firebase_firestore_2/pages/infostudent.dart';
import 'package:flutter/material.dart';

class ListStudents extends StatelessWidget {
  const ListStudents({Key? key, required this.listStudents}) : super(key: key);
  final List<Student> listStudents;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: listStudents.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            listStudents[index].name,
          ),
          subtitle: Text(
            listStudents[index].group,
          ),
          trailing: Text(
            listStudents[index].code,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const StudentInfo(),
                  settings: RouteSettings(arguments: listStudents[index].id)),
            );
          },
        );
      },
    );
  }
}
