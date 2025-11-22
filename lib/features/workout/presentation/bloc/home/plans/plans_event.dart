import 'package:w_allfit/core/constants/plansType.dart';

abstract class PlansEvent {}

class LoadPopularPlans extends PlansEvent {
  final PlanBlocType planType;
  LoadPopularPlans({required this.planType});
}

class LoadBeginnerPlans extends PlansEvent {
  final PlanBlocType planType;
  LoadBeginnerPlans({required this.planType});
}

class LoadAdvancePlans extends PlansEvent {
  final PlanBlocType planType;
  LoadAdvancePlans({required this.planType});
}

class LoadIntermediatePlans extends PlansEvent {
  final PlanBlocType planType;
  LoadIntermediatePlans({required this.planType});
}
