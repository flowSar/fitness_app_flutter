import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:w_allfit/features/workout/presentation/screens/HomeScreen.dart';
import 'package:w_allfit/b_navigation_bar.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_bloc.dart';
import 'package:w_allfit/provider/session_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => WorkoutBloc(),
          ),
          ChangeNotifierProvider(
            create: (context) => SessionProvider(),
          ),
        ],
        child: MaterialApp(
          home: BNavigationBar(),
        ));
  }
}
