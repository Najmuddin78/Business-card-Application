import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:business_card/color_palette.dart';
import 'package:business_card/navigation_page.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      print('Email: $_email, Password: $_password');
      // Simulating a sign-in process
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NavigationPage(),
          ),
        );
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void _forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotPasswordPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Card'),
        backgroundColor: ColorPalette.appBarBackground,
        foregroundColor: ColorPalette.appBarText,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back!',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.buttonText,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Log In to your account',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.buttonText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        // labelText: 'Email',
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        // labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length < 4) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _trySubmit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 32,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: ColorPalette.buttonBackground,
                        elevation: 4,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorPalette.buttonText,
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: _forgotPassword,
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.buttonText,
                        ),
                      ),
                      child: const Text('Forgot password?'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
