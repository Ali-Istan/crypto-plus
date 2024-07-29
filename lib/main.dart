import 'package:flutter/material.dart';

void main() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: SafeArea(child: Column(children: [Row(children: [],)],) ),),
    );
  }
}
