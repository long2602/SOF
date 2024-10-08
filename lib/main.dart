import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sof/view_model/ReputationHistoryProvider.dart';
import 'package:sof/view_model/UserProvider.dart';
import 'package:sof/views/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReputationHistoryProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter StackOverflow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
