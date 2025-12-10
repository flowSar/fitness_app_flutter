import 'package:flutter/cupertino.dart';
import 'package:w_allfit/features/user_workout/data/models/user_plan_model.dart';

class UserWorkoutProvider extends ChangeNotifier {
  late String _sessionId = '';
  late String _planId = '';
  late UserPlanModel _plan;
  late int _quickStartPlanId = 0;

  void updateSessionId(String newSessionId) {
    _sessionId = newSessionId;
    notifyListeners();
  }

  void updateSelectedPlan(UserPlanModel newPlan) {
    _plan = newPlan;
    notifyListeners();
  }

  void updatePlanId(String newPlanId) {
    _planId = newPlanId;
    notifyListeners();
  }

  void updateQuickStartPlanId(int quickStartPlanId) {
    _quickStartPlanId = quickStartPlanId;
    notifyListeners();
  }

  String get planId => _planId;

  String get sessionId => _sessionId;

  int get quickStartPlanId => _quickStartPlanId;

  UserPlanModel get selectedPlan => _plan;
}
