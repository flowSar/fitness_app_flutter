import 'package:w_allfit/core/constants/plansType.dart';

abstract class PlansState {}

class PlansInitialState extends PlansState {}

class PlansLoading extends PlansState {
  final PlanBlocType planType;
  final List<Map<String, Object>> plans;
  final List<int> plansSessionsIds;
  PlansLoading(
      {required this.planType,
      required this.plans,
      required this.plansSessionsIds});
}

class PlansLoaded extends PlansState {
  final PlanBlocType planType;
  final List<Map<String, Object>> plans;
  final List<int> plansSessionsIds;
  PlansLoaded(
      {required this.planType,
      required this.plans,
      required this.plansSessionsIds});
}

class PlansError extends PlansState {
  final String message;
  PlansError({required this.message});
}

// class PopularPlansLoading extends PlansState {
//   final List<Map<String, Object>> popularPlans;
//   final List<int> plansSessionsIds;
//   PopularPlansLoading(
//       {required this.popularPlans, required this.plansSessionsIds});
// }
//
// class BeginnerPlansLoading extends PlansState {
//   final List<Map<String, Object>> beginnerPlans;
//   final List<int> plansSessionsIds;
//   BeginnerPlansLoading(
//       {required this.beginnerPlans, required this.plansSessionsIds});
// }
//
// class IntermediatePlansLoading extends PlansState {
//   final List<Map<String, Object>> intermediatePlans;
//   final List<int> plansSessionsIds;
//   IntermediatePlansLoading(
//       {required this.intermediatePlans, required this.plansSessionsIds});
// }
//
// class AdvancePlansLoading extends PlansState {
//   final List<Map<String, Object>> advancePlans;
//   final List<int> plansSessionsIds;
//   AdvancePlansLoading(
//       {required this.advancePlans, required this.plansSessionsIds});
// }
