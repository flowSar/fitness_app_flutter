import 'package:flutter/cupertino.dart';

class WorkoutProvider extends ChangeNotifier {
  late int _sessionId = 0;
  late int _planId = 0;
  late int _quickStartPlanId = 0;

  void updateSessionId(int newSessionId) {
    _sessionId = newSessionId;
    notifyListeners();
  }

  void updatePlanId(int newPlanId) {
    _planId = newPlanId;
    notifyListeners();
  }

  void updateQuickStartPlanId(int quickStartPlanId) {
    _quickStartPlanId = quickStartPlanId;
    notifyListeners();
  }

  int get planId => _planId;

  int get sessionId => _sessionId;

  int get quickStartPlanId => _quickStartPlanId;
}
