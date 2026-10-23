import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService authService = AuthService();
  Auth _auth = Auth.signup;

  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariable.greyBackgroundCOlor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'Welcome',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              // Create Account
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariable.backgroundColor
                    : GlobalVariable.greyBackgroundCOlor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio<Auth>(
                  activeColor: GlobalVariable.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),

              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariable.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _nameController,
                          hintText: 'Enter your name',
                        ),
                        const SizedBox(height: 10),
                        CustomTextfield(
                          controller: _emailController,
                          hintText: 'Enter your email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextfield(
                          controller: _passwordController,
                          hintText: 'Enter your password',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: 'Sign Up',
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              authService.signUpUser(
                                context: context,
                                name: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),

              // Sign In
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariable.backgroundColor
                    : GlobalVariable.greyBackgroundCOlor,
                title: const Text(
                  'Sign In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio<Auth>(
                  activeColor: GlobalVariable.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),

              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariable.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _emailController,
                          hintText: 'Enter your email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextfield(
                          controller: _passwordController,
                          hintText: 'Enter your password',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: 'Sign In',
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
