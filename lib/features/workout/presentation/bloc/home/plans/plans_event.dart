import 'package:w_allfit/core/constants/plansType.dart';

abstract class PlansEvent {}

class LoadPopularPlans extends PlansEvent {
  final PlanType planType;
  LoadPopularPlans({required this.planType});
}

class LoadBeginnerPlans extends PlansEvent {
  final PlanType planType;
  LoadBeginnerPlans({required this.planType});
}

class LoadAdvancePlans extends PlansEvent {
  final PlanType planType;
  LoadAdvancePlans({required this.planType});
}

class LoadIntermediatePlans extends PlansEvent {
  final PlanType planType;
  LoadIntermediatePlans({required this.planType});
}
