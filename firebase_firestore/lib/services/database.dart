import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/statff.dart';

final databaseProvider = Provider((ref) => Database());

final getDataFromDatabase = FutureProvider<List<Staff>>(
  (ref) async {
    final _database = ref.watch(databaseProvider);
    await Future.delayed(const Duration(seconds: 2));
    return _database.staffList;
  },
);
final streamDataFromDatabase = StreamProvider<List<Staff>>(
  (ref) async* {
    final _database = ref.watch(databaseProvider);
    await Future.delayed(const Duration(seconds: 2));
    yield* _database.streamStaffList();
    // await for (final mStaffList in _database.streamStaffList()) {
    //   print(mStaffList);
    //   await Future.delayed(const Duration(seconds: 2));
    //   yield mStaffList;
    // }
  },
);

abstract class DatabaseServices {
  void create(Staff staff);
  Staff read(String id);
  void update(Staff staff);
  void delete(String id);
}

class Database extends DatabaseServices {
  final _controller = StreamController<List<Staff>>();
  Stream<List<Staff>> streamStaffList() {
    _controller.sink.add(staffList);
    return _controller.stream;
  }

  var staffList = <Staff>[];
  void debug() {
    print(staffList);
  }

  @override
  void create(Staff staff) {
    staffList.add(staff);
    _controller.sink.add(staffList);
  }

  @override
  void delete(String id) {
    staffList.removeWhere((mStaff) => mStaff.id == id);
    _controller.sink.add(staffList);
  }

  @override
  Staff read(String id) {
    return staffList.lastWhere((mStaff) => mStaff.id == id);
  }

  @override
  void update(Staff staff) {
    // final _index = staffList.indexWhere((mStaff) => mStaff.id == staff.id);
    // if (_index != -1) {
    //   staffList[_index] = staff;
    // }
    staffList = [
      ...[],
      for (final mStaff in staffList)
        if (mStaff.id == staff.id) staff else mStaff
    ];
    _controller.sink.add(staffList);
  }
}
