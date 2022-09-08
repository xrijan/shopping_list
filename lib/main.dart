import 'package:flutter/material.dart';
import 'package:project1/provider.dart';
import 'package:project1/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShoppingListProvider(),
      child: Builder(builder: (BuildContext context) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Home(),
        );
      }),
    );
  }
}
