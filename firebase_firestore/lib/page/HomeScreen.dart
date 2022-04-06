import 'dart:html';

import 'package:firebase_firestore/model/statff.dart';
import 'package:firebase_firestore/page/staff_view_page/staff_view.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/database.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController fullName = TextEditingController();
    TextEditingController age = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const  InputDecoration(
              hintText: 'Full name',             
            ),
            keyboardType: TextInputType.text,
            controller: fullName,
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Age',             
            ),
            keyboardType: TextInputType.number,
            controller: age,
          ),         
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 200,
            ),
            child: Consumer(
              builder: (context, ref, _) {
                final _dataAsync = ref.watch(streamDataFromDatabase);
                return _dataAsync.when(
                  data: (data) {
                    return StaffList(staffList: data);
                  },
                  error: (error, _) => const SizedBox(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                );
              },
            ),
          ),
          
          Consumer(builder: (context, ref, _) {
            return ElevatedButton(
              child: const Icon(Icons.add),
              onPressed: () {
                // final id = ref.watch(databaseProvider).staffList[1].id;
                // ref.read(databaseProvider).read(id);
                ref.read(databaseProvider).create(                  
                      Staff(
                        id: UniqueKey().toString(),
                        fullName: fullName.text,
                        urlImage: 'urlImage',
                        age: int.parse(age.text),
                      ),
                );
                fullName.text="";;
                age.text="";
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Container(),
                //   ),
                // );
              },
            );
            }
          ),
          // Consumer(builder: (context, ref, _) {
          //   return ElevatedButton(
          //     child: const Icon(Icons.add),
          //     onPressed: () {
          //       ref.read(databaseProvider).debug();
          //       // Navigator.push(
          //       //   context,
          //       //   MaterialPageRoute(
          //       //     builder: (context) => Container(),
          //       //   ),
          //       // );
          //     },
          //   );
          // }),
        ],
      ),
    );
  }
}
