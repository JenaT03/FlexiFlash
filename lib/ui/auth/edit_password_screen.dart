import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen.dart';

class EditPasswordScreen extends StatefulWidget {
  static const routeName = '/edit_password';

  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  String currentPass = '', newPass = '', confirmPass = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Căn giữa các children trong Row
            children: [
              Image.asset('assets/images/logo.png', height: 36),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'THAY ĐỔI MẬT KHẨU',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(children: <Widget>[
                  _buildCurrentPass(),
                  const SizedBox(height: 10),
                  _buildNewPass(),
                  const SizedBox(height: 10),
                  _buildConfirmPass(),
                ]),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShortButton(
                  text: 'Lưu thay đổi',
                  onPressed: _isSaving ? null : () => _saveForm(),
                  isDisabled: _isSaving,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  TextFormField _buildCurrentPass() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Nhập mật khẩu hiện tại',
        filled: false,
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      autofocus: true,
      obscureText: true,
      validator: (value) {
        if (value == null || value.length < 8) {
          return 'Mật khẩu phải có ít nhất 8 ký tự!';
        }
        return null;
      },
      onSaved: (value) {
        currentPass = value!;
      },
    );
  }

  TextFormField _buildNewPass() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Nhập mật khẩu mới',
        filled: false,
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      autofocus: true,
      obscureText: true,
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.length < 8) {
          return 'Mật khẩu phải có ít nhất 8 ký tự!';
        }
        return null;
      },
      onSaved: (value) {
        newPass = value!;
      },
    );
  }

  TextFormField _buildConfirmPass() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Nhập lại mật khẩu',
        filled: false,
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      autofocus: true,
      obscureText: true,
      validator: (value) {
        if (value != _passwordController.text) {
          return 'Mật khẩu không khớp!';
        }
        return null;
      },
      onSaved: (value) {
        confirmPass = value!;
      },
    );
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    if (!mounted) return;
    setState(() {
      _isSaving = true;
    });
    try {
      final result = await context
          .read<AuthManager>()
          .changePass(currentPass, newPass, confirmPass);
      if (result != null && result == true) {
        await showSucessDialog(context, 'Mật khẩu của bạn đã được thay đổi');
        Navigator.of(context).pop();
      } else {
        await showInforDialog(context, 'Mật khẩu không đúng vui lòng nhập lại');
      }
    } catch (error) {
      print("Lỗi xảy ra: $error");
      await showErrorDialog(context, 'Xin lỗi không thay đổi mật khẩu');
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}
