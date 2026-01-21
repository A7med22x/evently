import 'package:evently/app_theme.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = .new();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = .new();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 24),
              Center(child: Image.asset('assets/images/logo.png', height: 27)),
              SizedBox(height: screenHeight * 0.03),
              Text('Create your account', style: textTheme.headlineSmall),
              SizedBox(height: 24),
              DefaultTextFormFiled(
                hintText: 'Enter your name',
                prefixIconImageName: 'profile',
                controller: nameController,
                validator: (value) {
                  if (value == null || value.length < 2) {
                    return 'Invalid name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DefaultTextFormFiled(
                hintText: 'Enter your email',
                prefixIconImageName: 'email',
                controller: emailController,
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'Invalid emil';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DefaultTextFormFiled(
                hintText: 'Enter your password',
                prefixIconImageName: 'password',
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Invalid password';
                  }
                  return null;
                },
                isPassword: true,
              ),
              SizedBox(height: 16),
              DefaultTextFormFiled(
                hintText: 'Confirm your password',
                prefixIconImageName: 'password',
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Invalid password';
                  }
                  return null;
                },
                isPassword: true,
              ),
              SizedBox(height: screenHeight * 0.04),
              DefaultElevatedButton(label: 'Register', onPressed: register),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Text('Already have an account?', style: textTheme.titleSmall),
                  TextButton(onPressed: () {}, child: Text('Login')),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              Center(
                child: Text(
                  'Or',
                  style: textTheme.titleMedium!.copyWith(
                    color: AppTheme.primaryLight,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              DefaultElevatedButton(
                onPressed: () {},
                label: 'Register with Google',
                icon: 'google',
                foregroundColor: AppTheme.primaryLight,
                backgroundColor: AppTheme.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() {}
}
