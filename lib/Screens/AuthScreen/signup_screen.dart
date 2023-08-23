import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:montra/Auth/auth.dart';
import 'package:montra/Constants/constants.dart';
import 'package:montra/Constants/shared.dart';
import 'package:montra/Screens/AuthScreen/login_screen.dart';
import 'package:montra/Screens/AuthScreen/verification_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool checkValue = false;
  Future? user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          FocusManager.instance.primaryFocus!.unfocus();
        });
      },
      child: Scaffold(
        backgroundColor: light,
        appBar: AppBar(
          backgroundColor: light,
          elevation: 0,
          shadowColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              setState(() {
                Get.back();
              });
            },
            icon: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              theme: SvgTheme(
                currentColor: dark50,
              ),
            ),
          ),
          centerTitle: true,
          title: const Text('Sign Up'),
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
                  textEditingController: nameController,
                  fieldName: 'Name',
                  isObscure: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
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
                    } else if (value.length < 6) {
                      return 'Password must be more than 6 chars';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        value: checkValue,
                        onChanged: (value) {
                          setState(() {
                            checkValue = !checkValue;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: BorderSide(
                          width: 2,
                          color: violet,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: Get.width * 0.8,
                      child: RichText(
                        text: TextSpan(
                          text: 'By signing up, you agree to the ',
                          style: body3.copyWith(
                            color: const Color(0xFF000000),
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms of Service ',
                              style: body3.copyWith(
                                color: violet,
                              ),
                            ),
                            TextSpan(
                              text: 'and ',
                              style: body3.copyWith(
                                color: const Color(0xFF000000),
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: body3.copyWith(
                                color: violet,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                PrimaryElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState!.validate() &&
                          checkValue == true) {
                        try {
                          user = createUser(
                          email: emailController.text,
                          password: passwordController.text,
                          name: nameController.text,
                        );
                        if (user != null) {
                          log(user.toString());
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.done),
                              SizedBox(width: 16),
                              Text("Account created successfully! Login to your account")
                            ],
                          )));
                          Get.to(() => const LoginScreen());
                        }
                        } on AppwriteException catch (e) {
                          log(e.toString());
                          ScaffoldMessenger.of(context)
                              .showSnackBar( SnackBar(
                                  content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.done),
                              const SizedBox(width: 16),
                              Text(e.toString())
                            ],
                          )));
                        } catch (e) {
                          log(e.toString());
                          ScaffoldMessenger.of(context)
                              .showSnackBar( SnackBar(
                                  content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.done),
                              const SizedBox(width: 16),
                              Text(e.toString())
                            ],
                          )));
                        }
                      }
                    });
                  },
                  buttonName: 'Sign Up',
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
                RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: body1.copyWith(color: light20),
                    children: [
                      TextSpan(
                        text: 'Login',
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
