import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firestore_2/models/student.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class FireStoreDataBase {
  //final _controller = StreamController<List<Student>>();
  final firestoreInstance = FirebaseFirestore.instance;

  final collectionRef =
      FirebaseFirestore.instance.collection("Students").withConverter(
            fromFirestore: (snap, _) => Student.fromMap(snap.data()!),
            toFirestore: (student, _) => student.toMap(),
          );

  Future<List<Student>> getStudents() async {
    final _snapshots = await collectionRef.get();
    return _snapshots.docs
        .map(
          (rDoc) => rDoc.data()..id = rDoc.id,
        )
        .toList();
  }

  Stream<List<Student>> streamStudentsList() {
    final _snapshots = collectionRef.snapshots();
    final _students = _snapshots.map(
      (mSnapshot) => mSnapshot.docs.map(
        (rDoc) {
          final _student = rDoc.data()..id = rDoc.id;
          return _student;
        },
      ).toList(),
    );
    return _students;
  }

  Future<Student?> readStudent({
    String? id,
    required String code,
  }) async {
    if (id != null) {
      final _snapshot = await collectionRef.doc(id).get();
      return _snapshot.data()!..id = _snapshot.id;
    } else {
      final _snapshot =
          await collectionRef.where('code', isEqualTo: code).get();
      if (_snapshot.docs.isNotEmpty) {
        return _snapshot.docs.first.data()..id = _snapshot.docs.first.id;
      } else {
        return null;
      }
    }
  }

  void addStudent(Student student) {
    collectionRef.add(student);
  }

  void deleteStudent(String id) {
    collectionRef.doc(id).delete();
  }
}

final databaseProvider = Provider((ref) => FireStoreDataBase());
final getStudentProvider =
    FutureProvider.family<Student?, String>((ref, rId) async {
  final _database = ref.watch(databaseProvider);
  return _database.readStudent(
    id: rId,
    code: '',
  );
});
final getStudentsProvider = FutureProvider<List<Student>>((ref) async {
  final _database = ref.watch(databaseProvider);

  return _database.getStudents();
});

final streamStudentsProvider = StreamProvider<List<Student>>((ref) async* {
  final _database = ref.watch(databaseProvider);
  yield* _database.streamStudentsList();
});
