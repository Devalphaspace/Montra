import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:montra/Controller/session_controller.dart';
import 'package:montra/Screens/AuthScreen/security_check_screen.dart';
import 'package:montra/Services/auth.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Constants/shared.dart';
import 'package:montra/Screens/AuthScreen/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  Session? session;
  final SessionController _sessionController = Get.put(SessionController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          FocusManager.instance.primaryFocus!.unfocus();
        });
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: light,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: light,
          elevation: 0,
          shadowColor: Colors.transparent,
          // leading: IconButton(
          //   onPressed: () {
          //     setState(() {
          //       Get.back();
          //     });
          //   },
          //   icon: SvgPicture.asset(
          //     'assets/icons/arrow_left.svg',
          //     theme: SvgTheme(
          //       currentColor: dark50,
          //     ),
          //   ),
          // ),
          centerTitle: true,
          title: const Text('Login'),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryTextFormField(
                  textEditingController: emailController,
                  fieldName: 'Email',
                  isObscure: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.isEmail) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                PrimaryTextFormField(
                  textEditingController: passwordController,
                  fieldName: 'Password',
                  isObscure: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 24),
                PrimaryElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        session = await loginSession(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        log(session.toString());

                        if (session != null) {
                          log(session.toString());
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.done),
                                  SizedBox(width: 16),
                                  Text("Logged In successfully")
                                ],
                              ),
                            ),
                          );

                          _sessionController
                              .initializeSessionID(
                                  passedSessionID: session!.$id)
                              .then((value) {
                            Get.to(
                              () => SecurityCheckScreen(
                                userID: session!.userId,
                                sessionID: session!.$id,
                              ),
                            );
                          }).onError((error, stackTrace) {
                            Fluttertoast.showToast(
                                msg:
                                    'Something went wrong. Please try again after some time!');
                          });
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.close),
                                  SizedBox(width: 16),
                                  Text("Login failed")
                                ],
                              ),
                            ),
                          );
                        }
                      } on AppwriteException catch (e) {
                        log(e.toString());
                      } catch (e) {
                        log(e.toString());
                      }
                    }
                  },
                  buttonName: 'Login',
                ),
                const SizedBox(height: 12),
                Text(
                  'or with',
                  style: body3.copyWith(
                    fontWeight: FontWeight.bold,
                    color: light20,
                  ),
                ),
                const SizedBox(height: 12),
                CustomOutlinedButton(
                  onPressed: () {},
                  iconString: 'assets/icons/google.svg',
                  buttonName: 'Sign Up with Google',
                ),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      setState(() {
                        Get.to(
                          () => const ForgotPasswordScreen(),
                        );
                      });
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(Get.width, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide.none,
                      ),
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: title3.copyWith(color: violet),
                    )),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account yet? ',
                    style: body1.copyWith(color: light20),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: body1.copyWith(color: violet),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
