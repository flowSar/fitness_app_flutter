import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late bool disyplayOverlayScreen = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Stack(
        children: [
          PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) {
              setState(() {
                disyplayOverlayScreen = true;
              });
            },
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: EdgeInsets.all(10),
                  child: SafeArea(
                      child: Scaffold(
                    body: Column(
                      children: [
                        TextField(),
                        Switch(value: true, onChanged: (value) {}),
                        Expanded(
                            child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 120,
                              child: Text('Hello wolrd'),
                            );
                          },
                        )),
                        TextButton(
                            onPressed: () {}, child: Text('dd exercise')),
                        TextButton(onPressed: () {}, child: Text('save plan')),
                      ],
                    ),
                  )),
                ),
              ),
            ),
          ),
          if (disyplayOverlayScreen)
            _overlayScreen(context, () {
              setState(() {
                disyplayOverlayScreen = false;
              });
            })
        ],
      ),
    );
  }
}

Widget _overlayScreen(BuildContext context, VoidCallback fn) {
  final width = MediaQuery.sizeOf(context).width * 0.90;
  return Positioned.fill(
      child: SafeArea(
          child: Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromRGBO(62, 61, 66, 0.699),
    ),
    backgroundColor: Color.fromRGBO(62, 61, 66, 0.699),
    body: SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            style: TextButton.styleFrom(
                fixedSize: Size(width, 60),
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            child: Text(
              'quit',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              fn();
            },
            style: TextButton.styleFrom(
                fixedSize: Size(width, 60),
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            child: Text(
              'Resume',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    ),
  )));
}
