import 'package:flutter/cupertino.dart';

class SessionProvider extends ChangeNotifier {
  late int sessionId = 0;

  void updateSessionId(int newSessionId) {
    sessionId = newSessionId;
    notifyListeners();
  }

  int get id {
    return sessionId; // notify UI to rebuild
  }
}
