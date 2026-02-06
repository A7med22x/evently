import 'package:evently/app_theme.dart';
import 'package:evently/auth/register_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/home_screen.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/widgets/default_elevated_button.dart';
import 'package:evently/widgets/default_text_form_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently/widgets/ui_utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = .new();
  TextEditingController passwordController = .new();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 24),
                Center(
                  child: Image.asset('assets/images/logo.png', height: 27),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text('Login to your account', style: textTheme.headlineSmall),
                SizedBox(height: 24),
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
                Align(
                  alignment: .centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forget Password?'),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                DefaultElevatedButton(label: 'Login', onPressed: login),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      'Don’t have an account ?',
                      style: textTheme.titleSmall,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(RegisterScreen.routeName);
                      },
                      child: Text('Register'),
                    ),
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
                  onPressed: loginWithGoogle,
                  label: 'Login with Google',
                  icon: 'google',
                  foregroundColor: AppTheme.primaryLight,
                  backgroundColor: AppTheme.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      FirebaseService.login(
            email: emailController.text,
            password: passwordController.text,
          )
          .then((user) {
            Provider.of<UserProvider>(
              context,
              listen: false,
            ).updateCurrentUser(user);
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          })
          .catchError((error) {
            String? errorMessage;
            if (error is FirebaseAuthException) {
              errorMessage = error.message;
            }
            UiUtils.showErrorMessage(errorMessage);
          });
    }
  }

  void loginWithGoogle() {
    FirebaseService.loginWithGoogle()
        .then((user) {
          Provider.of<UserProvider>(
            context,
            listen: false,
          ).updateCurrentUser(user);
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        })
        .catchError((error) {
          String? errorMessage;
          if (error is FirebaseAuthException) {
            errorMessage = error.message;
          }
          UiUtils.showErrorMessage(errorMessage);
        });
  }
}
