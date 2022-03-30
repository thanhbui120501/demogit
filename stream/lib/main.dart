import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Main app and Pages for Tab Layout
void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 1,
        child: DefaultTabController(
          length: 1,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Provider Demo"),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.add)),
                ],
              ),
            ),
            body: MyEventPage(),
            floatingActionButton: Consumer(builder: (context, ref, _) {
              return _CustomButton(
                onPress: () {
                  ref.read(_eventProvider).add();
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  const _CustomButton({
    Key? key,
    required this.onPress,
  }) : super(key: key);
  final void Function() onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: const Text('Add'),
    );
  }
}

// Event page (counting)
class MyEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final _value = ref.watch(_eventStreamProvider);
        return _value.when(
          data: (data) {
            print('data:$data');
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('StreamProvider Example'),
                const SizedBox(height: 50),
                Text('$data', style: Theme.of(context).textTheme.displayLarge)
              ],
            );
          },
          error: (error, _) => const SizedBox(),
          loading: () => const SizedBox(),
        );
      },
    );
  }
}

// User List Page
final _eventProvider = Provider(
  (ref) => Event(),
);
final _eventStreamProvider = StreamProvider<int>(
  (ref) => ref.watch(_eventProvider).intStream(),
  dependencies: [
    _eventProvider,
  ],
);

// EventProvider (Stream)
class Event {
  StreamController<int> sc = StreamController();
  int count = 0;

  Stream<int> intStream() {
    sc.sink.add(count);
//    return Stream<int>.periodic(interval, (int _count) => _count++);
    return sc.stream;
  }

  add() {
    count++;
    print(count);
    sc.sink.add(count);
  }
}
