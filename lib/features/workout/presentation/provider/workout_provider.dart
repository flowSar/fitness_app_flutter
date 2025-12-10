import 'package:flutter/cupertino.dart';
import 'package:w_allfit/features/explore/data/models/plan_model.dart';

class WorkoutProvider extends ChangeNotifier {
  late String _sessionId = '';
  late String _planId = '';
  late PlanModel _plan;
  late int _quickStartPlanId = 0;

  void updateSessionId(String newSessionId) {
    _sessionId = newSessionId;
    notifyListeners();
  }

  void updateSelectedPlan(PlanModel newPlan) {
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

  PlanModel get selectedPlan => _plan;
}
