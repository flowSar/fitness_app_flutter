import "package:flutter/material.dart";
import "package:w_allfit/components/session_card.dart";
import "package:w_allfit/services/database/FakeDatabase.dart";
import "package:w_allfit/services/database/database.dart";
import "package:w_allfit/test_page.dart";

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final database = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(color: Colors.deepOrange),
                  child: Column(
                    children: [
                      Text(
                        "Los Belly Fat",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TestPage(),
                                ));
                          },
                          child: Text('Test',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20))),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  color: Colors.blueAccent,
                  child: ListView.builder(
                    itemCount: FakeDatabase.sessions.length,
                    itemBuilder: (context, index) {
                      var session = FakeDatabase.sessions[index];
                      return SessionCard(
                        day: session['day_number'] as int,
                        sessionId: session['id'] as int,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
