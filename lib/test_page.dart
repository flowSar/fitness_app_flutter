import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void showSnackBar() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("data loded"),
        duration: Duration(seconds: 3),
      ));
    }

    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
            child: Column(
          children: [],
        )),
      ),
    ));
  }
}
