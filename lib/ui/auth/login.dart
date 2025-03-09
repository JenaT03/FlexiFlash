import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_manager.dart';
import '../shared/dialog_utils.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    try {
      // Log user in
      await context.read<AuthManager>().login(
            _authData['email']!,
            _authData['password']!,
          );
    } catch (error) {
      log('$error');
      if (mounted) {
        showErrorDialog(context, error.toString());
      }
    }

    _isSubmitting.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(
                'assets/images/bg_img.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo.png',
                      width: 200,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "KHÁM PHÁ THẾ GIỚI, THEO CÁCH CỦA BẠN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 70),
                    Text(
                      "ĐĂNG NHẬP",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _buildEmailField(),
                            const SizedBox(height: 25),
                            _buildPasswordField(),
                            const SizedBox(height: 30),
                            ValueListenableBuilder<bool>(
                              valueListenable: _isSubmitting,
                              builder: (context, isSubmitting, child) {
                                if (isSubmitting) {
                                  return const CircularProgressIndicator();
                                }
                                return _buildSubmitButton();
                              },
                            ),
                            const SizedBox(height: 40),
                            RichText(
                              text: TextSpan(
                                text: "Nếu bạn chưa có tài khoản hãy ",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: "Đăng ký",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      ),
      child: const Text("ĐĂNG NHẬP"),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        border: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        filled: false,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Email không hợp lệ!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['email'] = value!;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Mật khẩu",
        border: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        filled: false,
      ),
      obscureText: true,
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.length < 8) {
          return 'Mật khẩu phải có ít nhất 8 ký tự!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
    );
  }
}
