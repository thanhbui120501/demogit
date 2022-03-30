import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage(),debugShowCheckedModeBanner: false,);
  }
}
class Clock extends StateNotifier<DateTime>{
  Clock() : super(DateTime.now()){
    _timer = Timer.periodic(Duration(seconds: 1),(_){
      state = DateTime.now();
    });
  }
  late final Timer _timer;

  // @override 
  // void dispose(){
  //   _timer?.cancel();
  //   super.dispose();
  // }
}
final clockProvider = StateNotifierProvider<Clock, DateTime>((ref) {
  return Clock();
});
class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context,  ref) {
    // this line is used to watch the provider's *state*
    // to get an instance of the clock itself, call `watch(clockProvider.notifier)`
    final currentTime = ref.watch(clockProvider);
    // format the time as `hh:mm:ss`
    final timeFormatted = DateFormat.Hms().format(currentTime);
    return Scaffold(
      body: Center(
        child: Text(
          timeFormatted,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
