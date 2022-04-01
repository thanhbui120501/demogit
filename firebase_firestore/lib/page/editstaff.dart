import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firestore/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/statff.dart';

class EditStaff extends StatelessWidget {
  const EditStaff({
    required this.staffList,
    Key? key,
  }) : super(key: key);
  final List<Staff> staffList;
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as int;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('${staffList[arg].fullName}'),
      ),
      body: Stack(
        children: [
          Container(
            height: 500,
            width: 500,
            decoration: const BoxDecoration(color: Colors.orange),
          ),
          Positioned(
              top: 30,
              left: 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ID: ${staffList[arg].id}',
                    style:const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Fullname: ${staffList[arg].fullName}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Age: ${staffList[arg].age}',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              )
          ),         
          
        ],
      ),
    );
  }
}