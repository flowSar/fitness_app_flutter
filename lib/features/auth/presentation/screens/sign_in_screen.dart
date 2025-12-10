import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/core/constants/functions.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_event.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_state.dart';
import 'package:w_allfit/features/auth/presentation/components/text_form_input.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late bool loginError = false;

  late bool loading = false;
  @override
  void dispose() {
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
              child:
                  BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
                if (state is LoginSucess) {
                  loading = false;
                  context.read<AuthBloc>().add(CheckAuthState());
                  context.go('/workoutScreen');
                }
                if (state is LoginFailed) {
                  loading = false;
                  loginError = true;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('login failed Try Again'),
                    duration: Duration(seconds: 3),
                  ));
                }
              }, builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 15,
                  children: [
                    Text(
                      'Sign In',
                      style:
                          TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                    ),
                    loginError
                        ? Text(
                            'login failed Try Again',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )
                        : SizedBox(),
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
                      type: TextInputType.text,
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
                          if (result != null && result == true) {
                            setState(() {
                              loading = true;
                            });
                            context.read<AuthBloc>().add(LogInEvent(
                                email: _emailController.text,
                                password: _passwordController.text));
                          }
                        },
                        child: loading
                            ? SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 6,
                      children: [
                        Text('I don\'t have an Account'),
                        InkWell(
                          onTap: () {
                            context.push('/signUp');
                          },
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    ));
  }
}
