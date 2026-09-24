import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { sigin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.sigin;

  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _namecontroller.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
      name: _namecontroller.text,
      onSuccess: () {
        // Success
      },
    );
  }

  void signInUser() {
    authService.signInUser(
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
      context: context,
      onSuccess: () {
        // Success
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),

              ListTile(
                title: const Text(
                  "Create Account",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
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
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _namecontroller,
                          hintText: 'Name',
                        ),
                        SizedBox(height: 10),
                        CustomTextfield(
                          controller: _emailcontroller,
                          hintText: 'Email',
                        ),
                        SizedBox(height: 10),
                        CustomTextfield(
                          controller: _passwordcontroller,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: 'Sign UP',
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),

              ListTile(
                title: const Text(
                  "Sign -In",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.sigin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),

              if (_auth == Auth.sigin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextfield(
                          controller: _emailcontroller,
                          hintText: 'Email',
                        ),
                        SizedBox(height: 10),
                        CustomTextfield(
                          controller: _passwordcontroller,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: 'Sign In',
                          onTap: () {
                            // Fixed validation and added signInUser()
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
