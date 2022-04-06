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
    TextEditingController id = TextEditingController();
    TextEditingController fullName = TextEditingController();
    TextEditingController age = TextEditingController();
    final idList = ModalRoute.of(context)!.settings.arguments as String;
    return Consumer(builder: (context,ref,_){
      final editStaffList = ref.watch(databaseProvider).read(idList);
      return Scaffold(
        appBar: AppBar(title: const Text("Edit Staff")),
        body: Padding(         
          padding: const EdgeInsets.only(left: 200,right: 200),
          child:ListView(
            children: [
            const SizedBox(height: 200,),
            Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Row(children: [
                const Text(
                  'ID',
                  style:TextStyle(
                    color: Color.fromARGB(255, 233, 22, 7),
                  ),
                ),
                
                TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: '${editStaffList.id}',
                  ),     
                  controller: id,                         
                ),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Row(children: [
                const Text(
                  'Full Name',
                  style:TextStyle(
                    color: Color.fromARGB(255, 233, 22, 7),
                  ),
                ),
                
                TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: '${editStaffList.fullName}',
                  ),     
                  controller: fullName,                         
                ),
              ],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Row(
                children: [
                const Text(
                  'Age',
                  style:TextStyle(
                    color: Color.fromARGB(255, 233, 22, 7),
                  ),
                ),
                
                TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: '${editStaffList.age}',
                  ),     
                  controller: age,                         
                ),
              ],
              ),
            ),
            
            ],
          ),
        ),         
      );     
    });   
  }
}
