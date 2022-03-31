import 'package:flutter/material.dart';
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

final streamProvider = StreamProvider.autoDispose<int>((ref) {
  return Stream.fromIterable([36, 72]);
});
final futureProvider = FutureProvider<int>((ref) => Future.value(64));

class Item {
  Item(this.id, this.name);
  final String id;
  final String name;
  /* many other properties here */
}

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamAsyncValue = ref.watch(streamProvider);
    final futureAsyncValue = ref.watch(futureProvider);
    // final futureAsyncValue = ref.watch(futureProvider); // same syntax
    return Scaffold(
      body: Center(
        child: streamAsyncValue.when(
          data: (data) => Text('Value: $data'),
          loading: () => const CircularProgressIndicator(),
          error: (e, st) => Text('Error: $e'),
        ),
      ),
    );
  }
}
