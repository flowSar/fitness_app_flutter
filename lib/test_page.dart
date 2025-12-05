import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_event.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_state.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void showSnackBar() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("data loded"),
        duration: Duration(seconds: 3),
      ));
    }

    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
            child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(CheckAuthState());
              },
              child: Text('check auth'),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthFailed) {
                  return Text('auth failed: ${state.error}');
                }
                if (state is Authenticated) {
                  if (state.isAuthenticated) {
                    return Text('auth');
                  }
                  return Text('unauthenticated');
                }
                if (state is LogOutSuccess) {
                  return Text('log out success');
                }
                if (state is LogOutFailed) {
                  return Text('log out failed ${state.error}');
                }
                return Text('loading...');
              },
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogOutEvent());
              },
              child: Text('Logout'),
            ),
          ],
        )),
      ),
    ));
  }
}
