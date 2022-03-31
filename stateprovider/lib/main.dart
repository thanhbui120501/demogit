import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// A Counter example implemented with riverpod

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

final valueProvider = Provider<int>((ref) => 36);
final counterProvider = StateProvider((ref) => 0);

/// Providers are declared globally and specifies how to create a state

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<int>(counterProvider, (previous, current) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Previous value is:$previous--Current value is: $current')));
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        // Consumer is a widget that allows you reading providers.
        // You could also use the hook "ref.watch(" if you uses flutter_hooks
        child: Consumer(builder: (context, ref, _) {
          final count = ref.watch(counterProvider);
          return Text('$count');
        }),
      ),
      floatingActionButton: FloatingActionButton(
        // The read method is an utility to read a provider without listening to it
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();

          ref.read(counterProvider.state).update((state) => state + 1);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
