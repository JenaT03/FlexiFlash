import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import 'auth_manager.dart';
import '../shared/dialog_utils.dart';

class Register extends StatefulWidget {
  static const routeName = '/register';
  final VoidCallback onLoginTap; // Nhận hàm onLoginTap từ AuthScreen

  const Register({super.key, required this.onLoginTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                      "ĐĂNG KÝ",
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
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              filled: false,
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Mật khẩu",
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              filled: false,
                            ),
                            obscureText: true,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: "Nhập lại mật khẩu",
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              filled: false,
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondary, // Màu nền
                              foregroundColor: Theme.of(context)
                                  .colorScheme
                                  .onSecondary, // Màu chữ

                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                            ),
                            child: const Text("ĐĂNG KÝ"),
                          ),
                          const SizedBox(height: 40),
                          RichText(
                            text: TextSpan(
                              text: "Nếu bạn đã có tài khoản, hãy ",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Đăng nhập",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget
                                        .onLoginTap, // Gọi hàm onLoginTap từ widget
                                ),
                              ],
                            ),
                          ),
                        ],
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
}
