import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firestore/Page/editstaff.dart';
import 'package:firebase_firestore/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/statff.dart';

class DeleteStaff extends StatelessWidget {
  const DeleteStaff({
    required this.staffList,
    Key? key,
  }) : super(key: key);
  final List<Staff> staffList;
  
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    return Consumer(builder: (context,ref,_){
      //final id = ref.watch(databaseProvider).staffList[arg].id;          
      final deleteStaffList = ref.watch(databaseProvider).read(id);
      return Scaffold(
        appBar: AppBar(
        title: const Text('Staff Detail'),
      ),
      body: Stack(
        children: [
          Container(
            height: 500,
            width: 500,
            decoration: const BoxDecoration(color: Colors.orange),
          ),
          Consumer(builder: (context, ref, _) {
             
            return Positioned(
                top: 30,
                left: 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ID: ${deleteStaffList.id}',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Fullname: ${deleteStaffList.fullName}',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Age: ${deleteStaffList.age}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ));
          }),         
          Positioned(
            left: 30,
            top: 300,
            child: Consumer(
              
              builder: (context,ref,_){               
                return ElevatedButton(
                  onPressed: (){
                    ref.read(databaseProvider).delete(id);

                    Navigator.pop(context);
                  }, 
                  child: const Icon(Icons.delete),
                );
              }
            ),
          ),
          Positioned(
            left: 100,
            top: 300,
            child: Consumer(
              builder: (context,ref,_){
                return ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditStaff(staffList: staffList,), 
                        settings:RouteSettings(arguments: id),                
                      ),
                    );
                  }, 
                  child: const Icon(Icons.next_plan),
                );
              }
            ),
          )
        ],
      ),
      );
    });   
  }
}