import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/core/constants/functions.dart';
import 'package:w_allfit/features/auth/data/models/user_model.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_event.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_state.dart';
import 'package:w_allfit/features/auth/presentation/components/text_form_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: EdgeInsets.only(top: 130, left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 15,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                  ),
                  TextFormInput(
                    nameController: _nameController,
                    type: TextInputType.text,
                    label: 'Name',
                    placeHolder: 'Enter Your Name',
                    validate: (value) =>
                        value!.length < 2 ? 'Name tp Short' : null,
                  ),
                  TextFormInput(
                    nameController: _emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email',
                    placeHolder: 'Enter Your Email',
                    validate: (value) => !isValidEmail(value!)
                        ? 'this email is not valid'
                        : null,
                  ),
                  TextFormInput(
                    nameController: _passwordController,
                    type: TextInputType.visiblePassword,
                    obscureText: true,
                    label: 'Password',
                    placeHolder: 'Enter Your Password',
                    validate: (value) =>
                        value!.length < 8 ? 'Password tp Short' : null,
                  ),
                  Material(
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          fixedSize: Size(120, 45),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black),
                      onPressed: () {
                        final result = _formKey.currentState?.validate();
                        if (result == true) {
                          final user = UserModel(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                          context.read<AuthBloc>().add(SignUpEvent(user: user));
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 6,
                    children: [
                      Text('Already Have an account'),
                      InkWell(
                        onTap: () {
                          context.push('/signIn');
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is SignUpSucess) {
                        context.go('/signIn');
                      }
                      if (state is SignUpFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.error),
                          duration: Duration(seconds: 3),
                        ));
                      }
                    },
                    child: SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
