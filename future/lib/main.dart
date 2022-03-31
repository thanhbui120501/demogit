import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Future and Stream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

final streamProvider = StreamProvider.autoDispose<List<int>>((ref) async* {
  await for (final item in Stream.value([4, 6, 7])) {
    await Future.delayed(Duration(
      seconds: 3,
    ));
    print('Item:$item');
    yield item;
  }
});
final futureProvider = FutureProvider<int>((ref) => Future.value(64));

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamAsyncValue = ref.watch(streamProvider);
    //final futureAsyncValue = ref.watch(futureProvider);

    // same syntax
    return Scaffold(
      body: Center(
        child: streamAsyncValue.when(
          data: (data) {
            print(data);
            return Text('Value: $data');
          },
          loading: () => const CircularProgressIndicator(),
          error: (e, st) => Text('Error: $e'),
        ),
      ),
    );
  }
}
