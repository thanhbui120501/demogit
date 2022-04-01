import 'package:firebase_firestore/page/deletestaff.dart';
import 'package:flutter/material.dart';

import '../../model/statff.dart';

class StaffList extends StatelessWidget {
  const StaffList({
    Key? key,
    required this.staffList,
  }) : super(key: key);
  final List<Staff> staffList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: staffList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(staffList[index].fullName),
          trailing: Text(staffList[index].id),
          subtitle: Text(staffList[index].age.toString()),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DeleteStaff(staffList: staffList,),
                settings:  RouteSettings(arguments: index),
              ),
            );
          },
        );
      },
    );
  }
}
